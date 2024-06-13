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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "refrigeId", nullable = false)
    private RefrigeList refrigeList;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "createUserId", nullable = false)
    private User createUserId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "requestUserId", nullable = false)
    private User requestUserId;

    @Column(nullable = false)
    private boolean status;

    public void updateStatus(boolean newStatus) {
        this.status = newStatus;
    }
}
