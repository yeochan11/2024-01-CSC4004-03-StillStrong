import numpy as np
import json
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Input
import pymysql

'''
외부 그래픽카드가 있는 사람만 사용하세요.
CUDA, cuDNN, tensorflow-gpu 가 필요합니다!!

import os
os.environ["CUDA_VISIBLE_DEVICES"] = "0"
'''

class RecommendModel:
    def __init__(self, ingredientModel, userModel):
        self.NeuralNetwork = Sequential([
            Input(shape=(997, 3)),
            Dense(100, activation='relu'),
            Dense(100, activation='relu'),
            Dense(100, activation='relu'),
            Dense(1, activation='sigmoid')
        ])
        self.ingredientModel = ingredientModel
        self.userModel = userModel
        self.ageWeight = np.zeros(997, dtype=np.float32)

        self.host = 'localhost'
        self.user = 'root'
        self.password = ''
        self.db = 'still88'
    
    def recommend(self, ingredientList, userId):
        ingredientScore = self.ingredientModel.recommend(ingredientList)
        userScore = self.userModel.recommend(userId)

        input_data = np.vstack((userScore, ingredientScore, self.ageWeight))
        result = self.NeuralNetwork.predict(input_data)

        allergy_index = self.excludeAllergy(self, userId)
        final_score = np.argsort(result)[::-1]
        recommend_id = []
        
        for id in final_score:
            if len(recommend_id) >= 5:
                break
            if id not in allergy_index:
                recommend_id.append(id)

        self.updateAge(recommend_id)
        return input_data, result, recommend_id
    
    def updateAge(self, recommend_index):
        for i in range(997):
            if not i in recommend_index:
                self.ageWeight[i] += 0.001

    def excludeAllergy(self, userId):
        conn = pymysql.connect(host=self.host, user=self.user
                                  ,password=self.password, db=self.db, charset='utf8')
        cursor = conn.cursor()
        cursor.execute(f"SELECT userAllergy from User where id = {userId};")
        allergy_list = cursor.fetchone()
        allergy_list = json.loads(allergy_list[0])

        cursor.execute("SELECT recipeIngredient from Recipe;")
        recipe_ingredient_list = []
        ingredient_list = cursor.fetchall()
        for ingredient in ingredient_list:
            recipe_ingredient_list.append(json.loads(ingredient[0]))
    
        cursor.close()
        conn.close()

        index = []
        for i, allergy_check in enumerate(self.checkAllergy(allergy_list, recipe_ingredient_list)):
            if allergy_check:
                index.append(i)

        return index
    
    def checkAllergy(self, allergy_list, recipe_ingredient_list):
        safe = np.zeros(997)
        for i, recipe_ingredient in enumerate(recipe_ingredient_list):
            if any(allergy in recipe_ingredient for allergy in allergy_list):
                safe[i] = 1
        return safe

    def updateParameter(self, X, y, recommend_id):
        y[recommend_id] -= 0.2
        self.NeuralNetwork.fit(X, y)
