package still88.backend.dto.recipe;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SearchResponseDTO {
    private List<String> recipeNames;
    private List<String> recipeMainImages;
    private List<List<String>> recipeIngredients;
}
