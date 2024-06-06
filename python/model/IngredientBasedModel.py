import numpy as np
from gensim.models import Word2Vec

class IBRM:
    def __init__(self, recipes_ingredient):
        self.word2vec = Word2Vec(sentences=recipes_ingredient, vector_size=1000, window=28, min_count=1, workers=4)
        self.embedded_recipes = [self.__embed_recipe(recipe) for recipe in recipes_ingredient]

    def __cosine_similarity(self, vec1, vec2):
        dot_product = np.dot(vec1, vec2)
        norm_vec1 = np.linalg.norm(vec1)
        norm_vec2 = np.linalg.norm(vec2)

        if norm_vec1 == 0 or norm_vec2 == 0:
            return 0.0
        
        return dot_product / (norm_vec1 * norm_vec2)
    
    def __embed_recipe(self, recipe):
        embedding = []
        for word in recipe:
            if word in self.word2vec.wv.key_to_index:
                embedding.append(self.word2vec.wv[word])
        return np.mean(np.array(embedding), axis=0) if embedding else np.zeros(self.word2vec.vector_size)

    def recommend(self, ingredients):
        if not ingredients:
            return np.zeros(997)
        ingredient_vector = self.__embed_recipe(ingredients)
        return [self.__cosine_similarity(ingredient_vector, emb_recipe) for emb_recipe in self.embedded_recipes]
