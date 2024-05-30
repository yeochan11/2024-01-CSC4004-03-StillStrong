package still88.backend.dto.recommend;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class MainPageResponseDTO {
    private String MainRecipeImage;
    private List<String> SubRecipeImage;
    private List<String> SubRecipeCategory;
    private List<String> SubRecipeName;
}
