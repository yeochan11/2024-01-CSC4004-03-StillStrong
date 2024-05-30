package still88.backend.dto.recipe;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
public class MainPageResponseDTO {
    String MainRecipeImage;
    String MainRecipeName;

    List<String> SubRecipeImage;
    List<String> SubRecipeName;
    List<String> SubRecipeCategory;
}
