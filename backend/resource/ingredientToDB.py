import pymysql

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

file_path = "resource\\ingredient_name.txt"
ingredient_name = read_ingredients(file_path)

file_path2 = "resource\\ingredient_category.txt"
ingredient_category = read_ingredients(file_path2)

if len(ingredient_name) != len(ingredient_category):
    print("Error: The number of ingredients does not match the number of categories.")
    print(len(ingredient_category))
    print(len(ingredient_name))
else:
    try:
        # mysql에 대한 정보 변경하세요
        conn = pymysql.connect(host='localhost', user='root', password='', db='still88', charset='utf8')
        cursor = conn.cursor()

        for i in range(len(ingredient_name)):
            query = "INSERT INTO ingredient(ingredientCategory, ingredientName) VALUES (%s, %s);"
            cursor.execute(query, (ingredient_category[i], ingredient_name[i]))

        conn.commit()
    except pymysql.MySQLError as e:
        print(f"Error: {e}")
    finally:
        cursor.close()
        conn.close()
