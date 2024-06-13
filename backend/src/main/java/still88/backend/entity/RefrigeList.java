package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Table(name = "refrigeList")
@Entity
public class RefrigeList {

    @Id
    @Column(name = "refrigeId", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int refrigeId;

    @Column(nullable = false)
    private String refrigeName;

    @OneToMany(mappedBy = "refrigeList")
    private List<Refrige> refriges = new ArrayList<>();

    @OneToMany(mappedBy = "refrigeList")
    private List<ShareRefrige> shareRefriges = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="userId", nullable = false)
    private User user;

    @Builder
    public RefrigeList(String refrigeName, User user) {
        this.refrigeName = refrigeName;
        this.user = user;
    }

    public void updateRefrigeName(String refrigeName) {
        this.refrigeName = refrigeName;
    }
}
