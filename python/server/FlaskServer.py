from flask import Flask, request, jsonify
import pickle
import json
from model.Weight import RecommendModel

pickle_path = ""
with open(pickle_path, 'rb') as file:
    model = pickle.load(file)

app = Flask(__name__)

feedback_X = None
feedback_y = None
recommend_result = None

@app.route("/recommend/ingredient", methods=['POST'])
def recipe_recommend():
    global feedback_X, feedback_y, recommend_result
    
    json_data = request.get_json()
    user_id = int(json_data.get('userId'))
    ingredientList = json_data.get('ingredientList')

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
    return jsonify(result)

@app.route("/recommend/feedback", methods=['POST'])
def provide_feedback():
    global feedback_X, feedback_y, recommend_result

    json_data = request.get_json()
    feedback = bool(json_data.get('feedback'))

    model.updateParameter(feedback_X, feedback_y, recommend_result, feedback)

    feedback_X = None
    feedback_y = None
    recommend_result = None

    return jsonify({'status': 'success'})
if __name__ == '__main__':
    app.run(debug=False,host="localhost", port=5000)
