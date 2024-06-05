package still88.backend.dto.refrige;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CreateUpdateRefrigeResponseDto {
    private int refrigeId;
    private String refrigeName;
    private Boolean share;
    private List<String> ingredientNames;
}
