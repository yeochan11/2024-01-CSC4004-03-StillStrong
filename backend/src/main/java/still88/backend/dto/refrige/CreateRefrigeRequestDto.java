package still88.backend.dto.refrige;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CreateRefrigeRequestDto {
    private int userId;
    private String refrigeName;
}
