package still88.backend.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Table(name = "ingredient")
@Entity
public class Ingredient {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private int ingredientId;

    @Column(nullable = false)
    private String ingredientName;

    @Column
    private String ingredientCategory;

    @OneToMany(mappedBy = "ingredient")
    private List<Refrige> refriges = new ArrayList<>();

    @Builder
    public Ingredient(String ingredientName, String ingredientCategory) {
        this.ingredientName = ingredientName;
        this.ingredientCategory = ingredientCategory;
    }
}
