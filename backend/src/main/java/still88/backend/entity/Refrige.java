package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Table(name = "refrige")
@Entity
public class Refrige {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto_increment
    @Column(name = "id", nullable = false)
    private int id;

    // 연관 관계 매핑
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "refrigeId", nullable = false)
    private RefrigeList refrigeList;

    // 연관 관계 매핑
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredientId", nullable = false)
    private Ingredient ingredient;

    // 연관 관계 매핑
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId", nullable = false)
    private User user;

    @Column(nullable = false)
    private LocalDate createdDate;

    @Column(nullable = false)
    private int ingredientNum;

    @Column(nullable = false)
    private String ingredientPlace;

    @Column(nullable = false)
    private LocalDate ingredientDeadline;

    @Column
    private String ingredientMemo;

    // 생성자 + Builder로 일관성 유지
    @Builder

    public Refrige(RefrigeList refrigeList, Ingredient ingredient, User user, LocalDate createdDate, int ingredientNum, String ingredientPlace, LocalDate ingredientDeadline, String ingredientMemo) {
        this.refrigeList = refrigeList;
        this.ingredient = ingredient;
        this.user = user;
        this.createdDate = createdDate;
        this.ingredientNum = ingredientNum;
        this.ingredientPlace = ingredientPlace;
        this.ingredientDeadline = ingredientDeadline;
        this.ingredientMemo = ingredientMemo;
    }
}
