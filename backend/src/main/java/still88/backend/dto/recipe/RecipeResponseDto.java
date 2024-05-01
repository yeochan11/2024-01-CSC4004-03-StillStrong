package still88.backend.dto.recipe;

import lombok.Data;

@Data
public class RecipeResponseDto {
    private int recipeId;
    private String recipeName;
    private String recipeCategory;
    private String recipeDescription;
    private String recipeImage;
    private String recipeIngredient;
    private int likeNum;
}
