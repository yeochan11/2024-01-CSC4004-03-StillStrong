<<<<<<< HEAD
import pymysql
import json
def read_userinfo(file_path, encodings=['utf-8']):
    userinfo_list = []
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as file:
                for line in file:
                    userinfo = line.strip().split(' ')
                    if userinfo[0] == '남성':
                        userGender = True
                    else:
                        userGender = False
                    userAge = int(userinfo[1])
                    userFavorite = userinfo[2].split(',')
                    userinfo_list.append([userAge, userGender, userFavorite])
            return userinfo_list
        except UnicodeDecodeError:
            continue  
        except FileNotFoundError:
            print(f"Error: The file {file_path} does not exist.")
            return []
    print(f"Error: Could not decode file {file_path} with given encodings.")
    return []

file_path = "init_user_info.txt"
user_infos = read_userinfo(file_path)

for userinfo in user_infos:
    print(userinfo)

try:
    conn = pymysql.connect(host='localhost', user='root', password='pangpar1', db='still88', charset='utf8')
    cursor = conn.cursor()

    for i, userinfo in enumerate(user_infos):
        user_nickname = "USER_" + str(i+1)
        user_favorite = []
        for category in userinfo[2]:
            cursor.execute(f"SELECT recipeId from recipe where recipeCategory = \"{category}\";")
            recipeIds = cursor.fetchall()
            for recipeId in recipeIds:
                user_favorite.append(recipeId[0])   
        user_favorite.sort()
        query = "INSERT INTO User(userNickName, userAge, userGender, userFavorite) VALUES (%s, %s, %s, %s);"
        cursor.execute(query, (user_nickname, userinfo[0], userinfo[1], json.dumps(user_favorite)))

    conn.commit()
except pymysql.MySQLError as e:
    print(f"Error: {e}")
finally:
    cursor.close()
    conn.close()
=======
import pymysql
import json
def read_userinfo(file_path, encodings=['utf-8']):
    userinfo_list = []
    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as file:
                for line in file:
                    userinfo = line.strip().split(' ')
                    if userinfo[0] == '남성':
                        userGender = True
                    else:
                        userGender = False
                    userAge = int(userinfo[1])
                    userFavorite = userinfo[2].split(',')
                    userinfo_list.append([userAge, userGender, userFavorite])
            return userinfo_list
        except UnicodeDecodeError:
            continue  
        except FileNotFoundError:
            print(f"Error: The file {file_path} does not exist.")
            return []
    print(f"Error: Could not decode file {file_path} with given encodings.")
    return []

file_path = "init_user_info.txt"
user_infos = read_userinfo(file_path)

for userinfo in user_infos:
    print(userinfo)

try:
    conn = pymysql.connect(host='localhost', user='root', password='pangpar1', db='still88', charset='utf8')
    cursor = conn.cursor()

    for i, userinfo in enumerate(user_infos):
        user_nickname = "USER_" + str(i+1)
        user_favorite = []
        for category in userinfo[2]:
            cursor.execute(f"SELECT recipeId from recipe where recipeCategory = \"{category}\";")
            recipeIds = cursor.fetchall()
            for recipeId in recipeIds:
                user_favorite.append(recipeId[0])   
        user_favorite.sort()
        query = "INSERT INTO User(userNickName, userAge, userGender, userFavorite) VALUES (%s, %s, %s, %s);"
        cursor.execute(query, (user_nickname, userinfo[0], userinfo[1], json.dumps(user_favorite)))

    conn.commit()
except pymysql.MySQLError as e:
    print(f"Error: {e}")
finally:
    cursor.close()
    conn.close()
>>>>>>> fd71c8a268e66234bc3662341ad58e34bbdbdbb6
