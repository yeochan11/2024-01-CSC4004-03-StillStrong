from flask import Flask, request, jsonify
import pickle
import json
import sys
import numpy as np
sys.path.insert(0, 'python\\model')
from Weight import RecommendModel
import tensorflow as tf
import atexit

NeuralNetwork = tf.keras.models.load_model('python\\pickle\\recommend_model_NeuralNetwork.h5')
NeuralNetwork.compile(
                optimizer='adam',
                loss=tf.keras.losses.MeanSquaredError(),
                metrics=['accuracy']
            )

pickle_path = "python\\pickle\\ingredient_based_recommend_model.pkl"
with open(pickle_path, 'rb') as file:
    ingredient_model = pickle.load(file)

pickle_path = "python\\pickle\\user_based_recommend_model.pkl"
with open(pickle_path, 'rb') as file:
    user_model = pickle.load(file)

model = RecommendModel(ingredientModel = ingredient_model, userModel = user_model, NeuralNetwork = NeuralNetwork)
app = Flask(__name__)

feedback_X = None
feedback_y = None
recommend_result = None
feedback_counter = 0
feedback_batch = []

@app.route("/recommend/ingredient", methods=['POST'])
def recipe_recommend():
    global feedback_X, feedback_y, recommend_result
    
    json_data = request.get_json()
    user_id = int(json_data.get('userId'))
    ingredientList = json_data.get('ingredientList')
    print("userId = ", user_id)
    print("ingredinet List = " , ingredientList)
    if isinstance(ingredientList, str):
        try:
            ingredientList = json.loads(ingredientList)
        except json.JSONDecodeError:
            return jsonify({'error': 'Invalid ingredientList format'}), 400

    if not isinstance(ingredientList, list):
        return jsonify({'error': 'ingredientList should be a list'}), 400

    X, y, result = model.recommend(ingredientList, user_id)
    feedback_X = X
    feedback_y = y
    recommend_result = result
    print(f'사용자_{user_id}에게 {result} 추천 완료')
    return jsonify({"recipeId" : result})

@app.route("/recommend/feedback", methods=['POST'])
def provide_feedback():
    global feedback_X, feedback_y, recommend_result, feedback_counter, feedback_batch

    if feedback_X is None:
        print("피드백할 데이터가 없습니다")
        return jsonify({'status': 'success'})
    
    json_data = request.get_json()
    feedback = bool(json_data.get('feedback'))

    if feedback_counter < 100:
        model.updateParameter(feedback_X, feedback_y, np.array(recommend_result) - 1, feedback)
        print(f'만족 = {feedback} : 피드백 반영 완료')
    else:
        feedback_batch.append((feedback_X, feedback_y, np.array(recommend_result) - 1, feedback))
        if len(feedback_batch) == 10:
            for fb_X, fb_y, fb_result, fb in feedback_batch:
                model.updateParameter(fb_X, fb_y, fb_result, fb)
            feedback_batch.clear()
            print('피드백 반영 완료 - 배치 학습')

    feedback_counter += 1
    feedback_X = None
    feedback_y = None
    recommend_result = None

    return jsonify({'status': 'success'})

def saveModel():
    model.save("python\\pickle\\recommend_model_NeuralNetwork.h5")
    print("모델 저장 후 서버를 종료합니다.")

atexit.register(saveModel)

if __name__ == '__main__':
    app.run(debug=False,host="localhost", port=5000)
