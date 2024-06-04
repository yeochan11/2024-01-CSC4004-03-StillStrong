package still88.backend.dto.recommend;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RecommendResponseDTO {
    private List<String> recipeNames;
    private List<String> recipeImages;
    private List<List<String>> recipeIngredients;
}
