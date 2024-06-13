package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class JoinInfoRequestDTO {
    private String userNickname;
    private Boolean userGender;
    private int userAge;
    private String secretEmail;
    private String secretPassword;
}
