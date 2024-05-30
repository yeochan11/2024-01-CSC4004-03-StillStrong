package still88.backend.dto.recipe;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RecipeDetailResponseDTO {
    String recipeName;
    String recipeCategory;
    String recipeMainImage;
    List<String> recipeIngredients;
    List<String> recipeDescriptions;
    List<String> recipeImage;

}
