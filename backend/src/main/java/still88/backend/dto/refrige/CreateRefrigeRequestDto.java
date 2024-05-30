package still88.backend.dto.refrige;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Data
public class CreateRefrigeRequestDto {
    private int refrigeId;
    private String refrigeName;
    private Boolean share;
    private List<String> ingredientNames;
}
