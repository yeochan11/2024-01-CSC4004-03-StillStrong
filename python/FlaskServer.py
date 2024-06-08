from flask import Flask, request, jsonify
import pickle
import json
import sys
import numpy as np
from Weight import RecommendModel
import tensorflow as tf
import atexit

NeuralNetwork = tf.keras.models.load_model('python\\recommend_model_NeuralNetwork.h5')
NeuralNetwork.compile(
                optimizer='adam',
                loss=tf.keras.losses.MeanSquaredError(),
                metrics=['accuracy']
            )

pickle_path = "python\\ingredient_based_recommend_model.pkl"
with open(pickle_path, 'rb') as file:
    ingredient_model = pickle.load(file)

pickle_path = "python\\user_based_recommend_model.pkl"
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
    print(f'User_{user_id} received {result} recommendation')
    return jsonify({"recipeId" : result})

@app.route("/recommend/feedback", methods=['POST'])
def provide_feedback():
    global feedback_X, feedback_y, recommend_result, feedback_counter, feedback_batch

    if feedback_X is None:
        print("feedback ignore")
        return jsonify({'status': 'success'})
    
    json_data = request.get_json()
    feedback = bool(json_data.get('feedback'))

    if feedback_counter < 100:
        model.updateParameter(feedback_X, feedback_y, np.array(recommend_result) - 1, feedback)
        print(f'feedback = {feedback}')
    else:
        feedback_batch.append((feedback_X, feedback_y, np.array(recommend_result) - 1, feedback))
        if len(feedback_batch) == 10:
            for fb_X, fb_y, fb_result, fb in feedback_batch:
                model.updateParameter(fb_X, fb_y, fb_result, fb)
            feedback_batch.clear()
            print('feed-batch learning')

    feedback_counter += 1
    feedback_X = None
    feedback_y = None
    recommend_result = None

    return jsonify({'status': 'success'})

def saveModel():
    print("model score : ", model.score() * 100)
    model.save("python\\recommend_model_NeuralNetwork.h5")
    print("saving model.")

atexit.register(saveModel)

if __name__ == '__main__':
    app.run(debug=False,host="localhost", port=5000)
