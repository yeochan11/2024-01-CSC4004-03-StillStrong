package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import still88.backend.entity.Ingredient;

import java.util.List;

public interface IngredientRepository extends JpaRepository<Ingredient, Long> {
    Ingredient findIngredientByIngredientId(int ingredientId);

    Ingredient findIngredientByIngredientName(String ingredientName);

    @Query("SELECT i.ingredientName FROM Ingredient i WHERE i.ingredientId IN :ingredientIds")
    List<String> findIngredientNamesByIngredientIds(List<Integer> ingredientIds);
}
