package still88.backend.dto.ingredient;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class IngredientNamesResponseDTO {
    private List<String> ingredientList;
}
