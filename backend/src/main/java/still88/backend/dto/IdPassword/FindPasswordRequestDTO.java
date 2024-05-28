package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class FindPasswordRequestDTO {
    private String secretEmail;
    private String userNickname;
}
