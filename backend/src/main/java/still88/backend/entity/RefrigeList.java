package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "refrigeList")
@Entity
public class RefrigeList {

    @Id
    @Column(name = "refrigeId", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int refrigeId;

    @Column(nullable = false)
    private String refrigeName;

    // 생성자 + Builder로 일관성 유지

}
