from UserBasedModel import UBRM
import sys, os
import pickle

model = UBRM()

with open('python\\user_based_recommend_model.pkl', 'wb') as file:
    pickle.dump(model, file)