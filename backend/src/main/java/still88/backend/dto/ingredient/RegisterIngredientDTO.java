package still88.backend.dto.ingredient;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegisterIngredientDTO {
    private String ingredientName;
    private int ingredientNum;
    private LocalDate createdDate;
    private LocalDate ingredientDeadline;
    private String ingredientMemo;
    private String ingredientPlace;
}

