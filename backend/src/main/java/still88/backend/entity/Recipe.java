package still88.backend.entity;

import jakarta.persistence.*;
import lombok.*;

@Getter
@NoArgsConstructor
@Table(name = "recipe")
@Entity
public class Recipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private int recipeId;

    @Column(nullable = false)
    private String recipeName;

    @Column
    private String recipeCategory;

    @Column(columnDefinition = "json")
    private String recipeDescription;

    @Column(columnDefinition = "json")
    private String recipeImage;

    @Column(columnDefinition = "json")
    private String recipeIngredient;

    @Column
    private String recipeMainImage;

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
