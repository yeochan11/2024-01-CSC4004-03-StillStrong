from Weight import RecommendModel
import pickle
import numpy as np

import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

with open('python\\pickle\\ingredient_based_recommend_model.pkl', 'rb') as file:
    ingredient_model = pickle.load(file)

with open('python\\pickle\\user_based_recommend_model.pkl', 'rb') as file:
    user_model = pickle.load(file)

model = RecommendModel(ingredientModel=ingredient_model, userModel=user_model)

user_result = np.array(user_model.recommend(2)).reshape(997,1)
ingredient_result = np.array(ingredient_model.recommend(['돼지고기', '김치'])).reshape(997, 1)
age = np.zeros((997, 1))

X = np.hstack([user_result, ingredient_result, age])
y = user_result * 0.3 + ingredient_result * 0.5 + age * 0.2

model._RecommendModel__init_fit(X, y)
input_data, result, id = model.recommend(ingredientList=['돼지고기', '김치'] , userId=2)

model.updateParameter(X, y, np.array(id) - 1, False)
