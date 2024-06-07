import numpy as np
import re
import pickle
from IngredientBasedModel import IBRM

file_path = "python\\recipe_ingredients.txt" 
recipes = []

with open(file_path, 'r', encoding='utf-8') as file:
    for line in file:
        line = line.strip()
        if line: 
            line = re.split(r'\s+', line)
            recipe = [line[i] for i in range(0, len(line), 2)]
            recipes.append(recipe)

model = IBRM(recipes)

with open('python\\ingredient_based_recommend_model.pkl', 'wb') as file:
    pickle.dump(model, file)