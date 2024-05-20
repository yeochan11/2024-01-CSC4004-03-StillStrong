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

    // 연관 관계 매핑
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "refrigeId", nullable = false)
    private RefrigeList refrigeList;

    // 냉장고를 만든 사용자 아이디
    @Column(name = "createUserId", nullable = false)
    private int createUserId;

    // 공유 요청한 사용자 아이디
    @Column(name = "requestUserId", nullable = false)
    private int requestUserId;

    @Column(nullable = false)
    private boolean status;
}
