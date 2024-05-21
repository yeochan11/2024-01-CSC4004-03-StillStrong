from flask import Flask, request, jsonify
import pickle
import pymysql

pickle_path = ""
with open(pickle_path, 'rb') as file:
    model = pickle.load(file)

app = Flask(__name__)

@app.route("/request-recommend", methods=['POST'])
def recipe_recommend():
    conn = pymysql.connect(host='localhost', user='root', password='zpalq,123098!@#', db='still88', charset='utf8')
    cursor = conn.cursor()

    json_data = request.get_json()

    user_id = json_data.get('userId')
    ingredientList = json_data.get('ingredientList')

    cursor.execute(f"SELECT userAge, userGender, userFavorite from User where userId = {user_id};")

    result = cursor.fetchall()

    user_info = {
        "userAge": result[0],
        "userGender": result[1],
        "userFavorite": result[2]
    }

    result = model.score(ingredientList, user_info)
    return result

if __name__ == '__main__':
    app.run(debug=False,host="localhost", port=5000)
