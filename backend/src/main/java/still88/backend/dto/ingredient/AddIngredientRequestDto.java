package still88.backend.dto.ingredient;

import lombok.Data;

import java.time.LocalDate;

@Data
public class AddIngredientRequestDto {
    private int refrigeId;
    private int userId;
    private String ingredientName;
    private String ingredientCategory;
    private LocalDate createdDate;
    private int ingredientNum;
    private String ingredientPlace;
    private LocalDate ingredientDeadline;
    private String ingredientMemo;
}
