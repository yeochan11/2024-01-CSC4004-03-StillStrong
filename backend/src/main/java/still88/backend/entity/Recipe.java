package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor
@Table(name = "recipe")
@Entity
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // auto_increment
    @Column(nullable = false)
    private int recipeId;

    @Column(nullable = false)
    private String recipeName;

    @Column
    private String recipeCategory;

    // JSON 타입으로 지정
    @Column(columnDefinition = "json")
    private String recipeDescription;

    // JSON 타입으로 지정
    @Column(columnDefinition = "json")
    private String recipeImage;

    // JSON 타입으로 지정
    @Column(columnDefinition = "json")
    private String recipeIngredient;

    @Column
    private String recipeMainImage;

    // 생성자 + Builder로 일관성 유지
    @Builder
    public Recipe(String recipeName, String recipeCategory, String recipeDescription,
                  String recipeImage, String recipeIngredient, String recipeMainImage) {
        this.recipeName = recipeName;
        this.recipeCategory = recipeCategory;
        this.recipeDescription = recipeDescription;
        this.recipeImage = recipeImage;
        this.recipeIngredient = recipeIngredient;
        this.recipeMainImage = recipeMainImage;
    }
}
