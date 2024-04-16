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

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @ManyToOne
    @JoinColumn(name = "refrigeid", nullable = false)
    private RefrigeList refrigeList;

    /**
     * ManyToOne 아무거나 넣어둔거라 수정 필요
     */
    @ManyToOne
    @JoinColumn(name = "ingredientId", nullable = false)
    private Ingredient ingredientId;

    @Column(nullable = false)
    private LocalDate createdDate;

    @Column(nullable = false)
    private int ingredientNum;

    @Column(nullable = false)
    private String ingredientPlace;

    @Column
    private String ingredientMemo;

    // 생성자 + Builder로 일관성 유지
    @Builder
    public Refrige(LocalDate createdDate, int ingredientNum, String ingredientPlace, String ingredientMemo, Ingredient ingredient) {
        this.createdDate = createdDate;
        this.ingredientNum = ingredientNum;
        this.ingredientPlace = ingredientPlace;
        this.ingredientMemo = ingredientMemo;
    }
}
