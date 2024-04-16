package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor
@IdClass(RefrigeListPK.class)
@Table(name = "refrigeList")
@Entity
public class RefrigeList {

    @Id
    @ManyToOne
    @JoinColumn(name = "refrigeId", nullable = false)
    private Refrige refrige;

    @Id
    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @Column(nullable = false)
    private boolean status;

    @Column(nullable = false)
    private String refrigeName;

    // 생성자 + Builder로 일관성 유지

}
