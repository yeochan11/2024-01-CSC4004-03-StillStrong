package still88.backend.domain.recipe.service;

import still88.backend.dto.recipe.RandomRecipeResponseDto;
import still88.backend.entity.Recipe;

import java.util.List;

public interface RecipeService {
    RandomRecipeResponseDto getRandomRecipes(int recipeNum);
}
