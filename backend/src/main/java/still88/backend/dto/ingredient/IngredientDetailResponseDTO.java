package still88.backend.dto.ingredient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class IngredientDetailResponseDTO {
    private String ingredientPlace;
    private String ingredientName;
    private LocalDate createdDate;
    private LocalDate ingredientDeadline;
    private int ingredientNum;
}
