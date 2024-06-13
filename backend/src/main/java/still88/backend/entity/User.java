package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Table(name = "user")
@Entity
public class User{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private int userId;

    @OneToMany(mappedBy = "user")
    private List<Refrige> refriges = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<RefrigeList> refrigeLists = new ArrayList<>();

    @OneToMany(mappedBy = "createUserId")
    private List<ShareRefrige> createdShareRefriges = new ArrayList<>();

    @OneToMany(mappedBy = "requestUserId")
    private List<ShareRefrige> requestedShareRefriges = new ArrayList<>();

    @Column(nullable = false, length=10)
    private String userNickname;

    @Column(nullable = false)
    private int userAge;

    @Column(nullable = false)
    private Boolean userGender;

    @Column
    private String userImage;

    @Column(columnDefinition = "json")
    private String userAllergy;

    @Column(columnDefinition = "json")
    private String userFavorite;

    @Column
    @ColumnDefault("true")
    private Boolean alarm;

    public void updateInfo(String userNickname, int userAge, Boolean userGender, String userImage, Boolean alarm) {
        this.userNickname = userNickname;
        this.userAge = userAge;
        this.userGender = userGender;
        this.userImage = userImage;
        this.alarm = alarm;
    }

    public void registerFavorite(String userFavorite) {
        this.userFavorite = userFavorite;
    }

    public void registerAllergy(String userAllergy) {
        this.userAllergy = userAllergy;
    }

    @Builder
    public User(String userNickname, int userAge, Boolean userGender){
        this.userNickname = userNickname;
        this.userAge = userAge;
        this.userGender = userGender;
        this.userImage = "";
        this.userAllergy = "";
        this.userFavorite = "";
        this.alarm = true;
    }
}
