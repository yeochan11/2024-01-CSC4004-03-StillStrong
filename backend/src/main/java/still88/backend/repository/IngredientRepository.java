package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.Ingredient;

public interface IngredientRepository extends JpaRepository<Ingredient, Long> {
    Ingredient findIngredientByIngredientId(int ingredientId);

    Ingredient findIngredientByIngredientName(String ingredientName);
}