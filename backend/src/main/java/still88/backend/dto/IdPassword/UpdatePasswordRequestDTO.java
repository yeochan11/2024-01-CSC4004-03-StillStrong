package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UpdatePasswordRequestDTO {
    private String UpdatePassword;
    private String ConfirmPassword;
}
