package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
public class LoginInfoRequestDTO {
    private String secretEmail;
    private String secretPassword;
}
