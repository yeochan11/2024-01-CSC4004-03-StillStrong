package still88.backend.domain.recipe.service;

import still88.backend.dto.recipe.MainPageResponseDTO;

public interface RecipeService {
    MainPageResponseDTO getRandomRecipes(int recipeNum);
}
