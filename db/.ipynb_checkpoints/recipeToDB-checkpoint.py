import requests
import json
import pymysql

def request_data():
    apikey = '360bfc50b4154894b83c'
    request_url = f'https://openapi.foodsafetykorea.go.kr/api/{apikey}/COOKRCP01/json/1/1000'
    response = requests.get(request_url)
    data = response.json()

    recipes = []

    for item in data['COOKRCP01']['row']:
        recipe_name = item['RCP_NM']
        recipe = {'recipe_name': recipe_name, 'cook_steps': []}

        for i in range(1, 21):
            cook_step_key = f'MANUAL{i:02d}'
            cook_step = item.get(cook_step_key)
            if not cook_step or cook_step.strip() == '':
                break
            recipe['cook_steps'].append(cook_step.replace('\n', ' '))

        recipes.append(recipe)

    return recipes

def read_ingredients(file_path, encodings=['utf-8']):
    ingredients = []
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as file:
                for line in file:
                    ingredients.append(line.strip())
            return ingredients
        except UnicodeDecodeError:
            continue  
        except FileNotFoundError:
            print(f"Error: The file {file_path} does not exist.")
            return []
    print(f"Error: Could not decode file {file_path} with given encodings.")
    return []

def save_to_db(recipes, recipe_name, recipe_category, recipe_ingredients):
    connection = pymysql.connect(
        host='localhost',
        user='root',
        password='zpalq,123098!@#',
        db='still88',
        charset='utf8'
    )
    cursor = connection.cursor()

    cursor.execute('''
        CREATE TABLE IF NOT EXISTS recipe (
            recipe_id INT AUTO_INCREMENT PRIMARY KEY,
            recipe_name VARCHAR(255),
            recipe_category VARCHAR(255),
            recipe_ingredient JSON,
            recipe_description JSON
        )
    ''')

    for i in range(len(recipe_name)):
        recipe_ingredient = recipe_ingredients[i].split(' ')[::2]
        ingredient_json = json.dumps(recipe_ingredient)

        index = i
        if index >= 493:
            index += 2

        if index >= 952:
            index += 1
            
        if index < len(recipes):
            recipe_description = json.dumps(recipes[index]['cook_steps'], ensure_ascii=False)
        else:
            recipe_description = json.dumps([])

        query = '''
            INSERT INTO recipe (recipeName, recipeCategory, recipeIngredient, recipeDescription)
            VALUES (%s, %s, %s, %s)
        '''
        cursor.execute(query, (recipe_name[i], recipe_category[i], ingredient_json, recipe_description))

    connection.commit()
    cursor.close()
    connection.close()

def main():
    recipes = request_data()

    file_path1 = "recipe_name.txt"
    recipe_name = read_ingredients(file_path1)

    file_path2 = "recipe_category.txt"
    recipe_category = read_ingredients(file_path2)

    file_path3 = "recipe_ingredients.txt"
    recipe_ingredients = read_ingredients(file_path3)

    if len(recipe_name) != len(recipe_category) or len(recipe_name) != len(recipe_ingredients):
        print("Error: The number of recipe names, categories, and ingredients do not match.")
    else:
        save_to_db(recipes, recipe_name, recipe_category, recipe_ingredients)

if __name__ == "__main__":
    main()
