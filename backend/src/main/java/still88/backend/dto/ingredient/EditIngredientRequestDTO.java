package still88.backend.dto.ingredient;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.time.LocalDate;

@Data
@AllArgsConstructor
public class EditIngredientRequestDTO {
    private int ingredientNum;
    private LocalDate createdDate;
    private LocalDate ingredientDeadline;
    private String ingredientMemo;
    private String ingredientPlace;
}