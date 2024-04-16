package still88.backend.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Getter
@NoArgsConstructor
@Table(name = "ingredient")
@Entity
public class Ingredient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto_increment
    @Column(nullable = false)
    private int ingredientId;

    @Column(nullable = false)
    private String ingredientName;

    @Column(nullable = false)
    private LocalDate ingredientDeadline;

    @Column(nullable = false)
    private String ingredientCategory;

    // 생성자 + Builder로 일관성 유지
    @Builder
    public Ingredient(String ingredientName, LocalDate ingredientDeadline, String ingredientCategory) {
        this.ingredientName = ingredientName;
        this.ingredientDeadline = ingredientDeadline;
        this.ingredientCategory = ingredientCategory;
    }
}
