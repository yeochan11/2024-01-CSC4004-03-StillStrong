package still88.backend.dto.recipe;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class RecipeResponseDto {
    private int recipeId;
    private String recipeName;
    private String recipeCategory;
    private String recipeDescription;
    private String recipeImage;
    private String recipeIngredient;
    private int likeNum;

    @Builder
    public RecipeResponseDto(int recipeId, String recipeName, String recipeCategory, String recipeDescription, String recipeImage, String recipeIngredient, int likeNum) {
        this.recipeId = recipeId;
        this.recipeName = recipeName;
        this.recipeCategory = recipeCategory;
        this.recipeDescription = recipeDescription;
        this.recipeImage = recipeImage;
        this.recipeIngredient = recipeIngredient;
        this.likeNum = likeNum;
    }
}
