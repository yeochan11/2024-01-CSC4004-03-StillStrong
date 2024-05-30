package still88.backend.domain.recipe.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import still88.backend.dto.recipe.MainPageResponseDTO;
import still88.backend.dto.recipe.RecipeDetailResponseDTO;
import still88.backend.dto.recipe.SearchResponseDTO;

public interface RecipeService {
    MainPageResponseDTO getRandomRecipes(int recipeNum);

    SearchResponseDTO serachRecipe(String seraching) throws JsonProcessingException;
}
