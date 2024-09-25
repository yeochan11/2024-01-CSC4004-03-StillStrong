# UBRM.py
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.metrics.pairwise import cosine_similarity
from scipy.sparse import csr_matrix
import pymysql
import json

class UBRM:
    def __init__(self):
        self.standardizer =  StandardScaler()
        self.host = 'still88db.cbaamqy88abn.ap-northeast-2.rds.amazonaws.com'
        self.user = 'root'
        self.password = ''
        self.db = 'still88'
        self.conn = self.__connect_to_db()

    def __convert_boolean(self, value):
        return 1 if value == b'\x01' else 0

    def close_db(self):
        self.conn.close()
    
    def __read_userInfo(self):
        conn = pymysql.connect(host=self.host, user=self.user
                                  ,password=self.password, db=self.db, charset='utf8')
        cursor = conn.cursor()
        cursor.execute(f"SELECT userAge, userGender, userFavorite from User;")

        result = cursor.fetchall()

        cursor.close()
        conn.close()

        user_info_list = []
        for row in result:
            if row[2] is not None:
                user_info = [row[0], self.__convert_boolean(row[1]), json.loads(row[2])]
            else:
                user_info = [row[0], self.__convert_boolean(row[1]), []]
            user_info_list.append(user_info)

        if len(user_info_list) < 6:
            return []
        
        return user_info_list
        
    
    def __normalize_age(self, user_info):
        ages = [user[0] for user in user_info]
        normalized_ages = self.standardizer.fit_transform([[age] for age in ages])

        for i, user in enumerate(user_info):
            user_info[i][0] = normalized_ages[i][0]
        
        return user_info


    def __transformUserInfoToVector(self, user_info):
        rows = []
        cols = []
        data = []
        additional_features = []
        recipe_count = 998 

        for i, (age, gender, recipes) in enumerate(user_info):
            for recipe in recipes:
                rows.append(i)
                cols.append(recipe)
                data.append(1)
            additional_features.append([age, 1 if gender == True else 0])

        user_recipe_matrix = csr_matrix((data, (rows, cols)), shape=(len(user_info), recipe_count))

        additional_features = np.array(additional_features)
        user_features_matrix = np.hstack((additional_features, user_recipe_matrix.toarray()))

        return user_features_matrix


    def recommend(self, userId):
        user_info = self.__read_userInfo()
        if not user_info:
            return np.zeros(997)
            
        user_info = self.__normalize_age(user_info)
        user_vector = self.__transformUserInfoToVector(user_info)
        userId = userId - 1

        cosine_sim = cosine_similarity(user_vector)[userId]
        cosine_sim[userId] = -1

        most_similar_users = np.argsort(cosine_sim)[-5:][::-1]

        conn = pymysql.connect(host=self.host, user=self.user
                                  ,password=self.password, db=self.db, charset='utf8')
        
        cursor = conn.cursor()

        recipe_score_sum = np.zeros(997)

        for userId in most_similar_users:
            cursor.execute(f"SELECT userFavorite FROM User WHERE userId = {userId};")
            result = cursor.fetchone()
            if result:
                if result[0] is not None:
                    favorite_recipes = json.loads(result[0])
                    favorite_recipes = [x - 1 for x in favorite_recipes]
                    user_favorite_vector = np.zeros(997)
                    user_favorite_vector[favorite_recipes] = 1
                    recipe_score_sum += user_favorite_vector

        recipe_score_average = recipe_score_sum / 5

        cursor.close()
        conn.close()

        return recipe_score_average