package still88.backend.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.lang.annotation.Target;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name="idPassword")
@Entity
public class IdPassword {

    @Id
    @OneToOne
    @JoinColumn(name="userId", nullable = false)
    private User user;

    @Column(name="id", nullable = false)
    private String id;

    @Column(name="password", nullable = false)
    private String password;
}
