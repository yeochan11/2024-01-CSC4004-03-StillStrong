package still88.backend.dto.IdPassword;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class JoinInfoRequestDTO {
    private String userNickname;
    private Boolean gender;
    private int userAge;
    private String secretEmail;
    private String secretPassword;
}
