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
    @Column(nullable = false)
    private int refrigeId;

    @Column(nullable = false)
    private LocalDate createdDate;

    @Column(nullable = false)
    private int ingredientNum;

    @Column(nullable = false)
    private String ingredientPlace;

    @Column
    private String ingredientMemo;

    @ManyToOne
    @JoinColumn(name = "ingredentId")
    private Ingredient ingredient;

    // 생성자 + Builder로 일관성 유지
    @Builder
    public Refrige(LocalDate createdDate, int ingredientNum, String ingredientPlace, String ingredientMemo, Ingredient ingredient) {
        this.createdDate = createdDate;
        this.ingredientNum = ingredientNum;
        this.ingredientPlace = ingredientPlace;
        this.ingredientMemo = ingredientMemo;
    }
}
