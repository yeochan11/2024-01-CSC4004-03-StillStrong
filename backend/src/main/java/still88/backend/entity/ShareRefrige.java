package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "shareRefrige")
@Entity

public class ShareRefrige {
    @Id
    @Column(name="shareId", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int shareId;

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @ManyToOne
    @JoinColumn(name="refrigeId", nullable = false)
    private RefrigeList refrigeId;

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @ManyToOne
    @JoinColumn(name="userId", nullable = false)
    private User userId;

    @Column(name="status", nullable = false)
    private boolean status;

    // 생성자 + Builder로 일관성 유지
    @Builder
    public ShareRefrige(boolean status) {
        this.status = status;
    }
}
