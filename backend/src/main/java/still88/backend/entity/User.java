package still88.backend.entity;

import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "User")
public class User {
    @Id
    private Integer userId;
    private String userNickname;
    private Integer userAge;
    private Boolean userGender;
    private String userImage;
}
