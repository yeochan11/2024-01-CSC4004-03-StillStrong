package still88.backend.dto.user;

import lombok.Getter;

@Getter
public class UpdateUserDetailRequestDto {

    private String userNickname;

    private int userAge;

    private Boolean userGender;

    private String userImage;

    private Boolean alarm;

    private String secretEmail;
}
