package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "user")
@Entity
public class User{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Integer userId;

    @Column(nullable = false, length=10)
    private String userNickname;

    @Column(nullable = false)
    private Integer userAge;

    @Column(nullable = false)
    private Boolean userGender;

    @Column(nullable = false)
    private String userImage;
}
