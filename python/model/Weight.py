import pickle
import numpy as np
from tensorflow.keras.models import Model
from tensorflow.keras.layers import Input, Embedding, Flatten, Dot, Dense

ingredientModelPath = "C:\\Still88ML\\2024-01-CSC4004-03-StillStrong\\python\\model\\IngredientBasedModel.pkl"

with open(ingredientModelPath, 'r', encoding='utf-8') as file:
    ingredientModel = pickle.load(file)

userModelPath = "C:\\Still88ML\\2024-01-CSC4004-03-StillStrong\\python\\model\\user_based_recommend_model.pkl"
with open(userModelPath, 'r', encoding='utf-8') as file:
    userModel = pickle.load(file)

class RecommendModel:
    def __init__(self, ingredientModel, userModel):
        self.NeuralNetwork = Dense()
        self.ingredientModel = ingredientModel
        self.userModel = userModel
        self.ageWeight = np.zeors(998)
    
    def recommend(self, ingredientList, userId):
        userScore = []
        ingredientScore = []
        if not ingredientList:
            ingredientScore = np.zeros(998)
        else:
            ingredientScore = self.ingredientModel.recommend(ingredientList)
        
        userScore = self.userModel.recommend(userId)

        input_data = np.vstack(userScore, ingredientScore, self.ageWeight)
        
        