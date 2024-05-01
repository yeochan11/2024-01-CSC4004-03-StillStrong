package still88.backend.dto.refrige;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GetRefrigeIngredientResponseDto {
    List<String> ingredientNames;
}
