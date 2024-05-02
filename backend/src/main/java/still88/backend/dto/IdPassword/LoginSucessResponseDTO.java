package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginSucessResponseDTO {
    private int userId;

    public String getCookieValue(){
        return Integer.toString(this.userId);
    }
}
