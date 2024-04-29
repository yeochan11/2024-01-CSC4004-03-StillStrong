from flask import Flask, request, jsonify
import pickle

pickle_path = ""
with open(pickle_path, 'rb') as file:
    model = pickle.load(file)

app = Flask(__name__)

@app.route("/request-recommend", methods=['POST'])
def recipe_recommend():
    result = model.score()
    return result

if __name__ == '__main__':
    app.run(debug=False,host="localhost", port=5000)
