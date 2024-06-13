package still88.backend.dto.recipe;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RecipeInfoDto {
    private int recipeId;
    private String recipeName;
    private String recipeCategory;
    private String recipeMainImage;
}
