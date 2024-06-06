from UserBasedModel import UBRM
import sys, os
sys.path.append(os.pardir)
import pickle

model = UBRM()

with open('python\\pickle\\user_based_recommend_model.pkl', 'wb') as file:
    pickle.dump(model, file)