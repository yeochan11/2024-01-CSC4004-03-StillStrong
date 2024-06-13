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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "refrigeId", nullable = false)
    private RefrigeList refrigeList;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ingredientId", nullable = false)
    private Ingredient ingredient;

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


    public void updateInfo(LocalDate createdDate, LocalDate ingredientDeadline, int ingredientNum, String ingredientPlace, String ingredientMemo){
        this.createdDate = createdDate;
        this.ingredientDeadline = ingredientDeadline;
        this.ingredientNum = ingredientNum;
        this.ingredientPlace = ingredientPlace;
        this.ingredientMemo = ingredientMemo;
    }

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
