package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class JoinResponseDTO {
    private int userId;
    private String userNickname;

    public String getCookieValue(){
        return Integer.toString(this.userId);
    }
}
