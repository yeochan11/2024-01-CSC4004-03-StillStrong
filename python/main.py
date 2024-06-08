import pickle
import numpy as np
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf
import sys
from Weight import RecommendModel

with open('python\\ingredient_based_recommend_model.pkl', 'rb') as file:
    ingredient_model = pickle.load(file)

with open('python\\user_based_recommend_model.pkl', 'rb') as file:
    user_model = pickle.load(file)

model = RecommendModel(ingredientModel=ingredient_model, userModel=user_model)

X = []
y = []
for i in range(43):
    print(i+1)
    user_result = np.array(user_model.recommend(i+1)).reshape(997,1)
    ingredient_result = np.array(ingredient_model.recommend(['삼겹살', '된장'])).reshape(997, 1)
    age = np.zeros((997, 1))

    X.append(np.hstack([user_result, ingredient_result, age]))
    y.append(user_result * 0.2 + ingredient_result * 0.7 + age * 0.1)

    model._RecommendModel__init_fit(X[i], y[i])

model.save("python\\recommend_model_NeuralNetwork.h5")