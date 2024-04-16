package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor
@Table(name = "refrigeList")
@Entity
public class RefrigeList {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int refrigeListId;

    @ManyToOne
    @JoinColumn(name = "refrigeId", nullable = false)
    private Refrige refrige;

    @ManyToOne
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @Column(nullable = false)
    private boolean status;

    @Column(nullable = false)
    private String refrigeName;

    // 생성자 + Builder로 일관성 유지

}
