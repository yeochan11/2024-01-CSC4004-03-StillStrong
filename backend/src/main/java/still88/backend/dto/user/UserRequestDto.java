package still88.backend.dto.user;

import jakarta.persistence.Column;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserRequestDto {
    private String userNickname;

    private int userAge;

    private Boolean userGender;

    private String userImage;

    private String userAllergy;

    private String userFavorite;
}
