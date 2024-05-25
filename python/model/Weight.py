import numpy as np
import json
import tensorflow as tf
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
            Input(shape=(3,)), 
            Dense(100, activation='relu'),
            Dense(100, activation='relu'),
            Dense(100, activation='relu'),
            Dense(1, activation='sigmoid') 
        ])
        self.NeuralNetwork.compile(
            optimizer='adam',
            loss=tf.keras.losses.MeanSquaredError(),
            metrics=['accuracy']
        )
        self.ingredientModel = ingredientModel
        self.userModel = userModel
        self.ageWeight = np.zeros(997, dtype=np.float32)

        self.host = 'localhost'
        self.user = 'root'
        self.password = ''
        self.db = 'still88'
    
    def recommend(self, ingredientList, userId):
        ingredientScore = np.array(self.ingredientModel.recommend(ingredientList)).reshape(997,1)
        userScore = np.array(self.userModel.recommend(userId)).reshape(997, 1)

        input_data = np.hstack([userScore, ingredientScore, self.ageWeight.reshape(997, 1)])
        result = self.NeuralNetwork.predict(input_data)

        allergy_index = self.__excludeAllergy(userId)
        final_score = np.argsort(result)[::-1]
        recommend_id = []
        
        for id in final_score:
            if len(recommend_id) >= 5:
                break

            if id not in allergy_index:
                recommend_id.append(int(id) + 1)

        print(final_score.shape)
        self.__updateAge(recommend_id)
        return input_data, result, recommend_id
    
    def updateParameter(self, X, y, recommend_id, feedback):
        if feedback:
            y[recommend_id] += 0.1
            self.NeuralNetwork.fit(X, y)
        else:
            y[recommend_id] -= 0.2
            self.NeuralNetwork.fit(X, y)

    def __updateAge(self, recommend_index):
        for i in range(997):
            if not i in recommend_index:
                self.ageWeight[i] += 0.001

    def __excludeAllergy(self, userId):
        conn = pymysql.connect(host=self.host, user=self.user
                                  ,password=self.password, db=self.db, charset='utf8')
        cursor = conn.cursor()
        cursor.execute(f"SELECT userAllergy from User where userId = {userId};")
        allergy_list = cursor.fetchone()
        if allergy_list[0] != None:
            allergy_list = json.loads(allergy_list[0])
        else:
            allergy_list = []

        cursor.execute("SELECT recipeIngredient from Recipe;")
        ingredient_list = cursor.fetchall()

        recipe_ingredient_list = []
        for ingredient in ingredient_list:
            ingredient = json.loads(ingredient[0])
            ingredient_category_list = []
            for ingredientName in ingredient:
                cursor.execute(f"SELECT ingredientCategory from ingredient where ingredientName = \"{ingredientName}\"")
                category = cursor.fetchone()
                if category != None and category[0] != '': 
                    ingredient_category_list.append(category[0])
                        
            recipe_ingredient_list.append(ingredient_category_list)

        cursor.close()
        conn.close()

        index = []
        for i, allergy_check in enumerate(self.__checkAllergy(allergy_list, recipe_ingredient_list)):
            if allergy_check:
                index.append(i)

        return index
    
    def __checkAllergy(self, allergy_list, recipe_ingredient_list):
        not_safe = np.zeros(997)
        for i, recipe_ingredient in enumerate(recipe_ingredient_list):
            if any(allergy in recipe_ingredient for allergy in allergy_list):
                not_safe[i] = 1
        return not_safe

    def __init_fit(self, X, y):
        self.NeuralNetwork.fit(X, y)