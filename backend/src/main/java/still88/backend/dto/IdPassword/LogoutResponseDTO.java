package still88.backend.dto.IdPassword;

import jakarta.servlet.http.Cookie;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LogoutResponseDTO {
    private String userNickname;
    private Cookie cookie;
}
