package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import still88.backend.entity.Ingredient;

import java.util.List;

public interface IngredientRepository extends JpaRepository<Ingredient, Long> {
    Ingredient findIngredientByIngredientId(int ingredientId);

    Ingredient findIngredientByIngredientName(String ingredientName);

    @Query("SELECT ingredientName From Ingredient")
    List<String> findAllNames();

    @Query("SELECT i.ingredientName FROM Ingredient i WHERE i.ingredientId IN :ingredientIds")
    List<String> findIngredientNamesByIngredientIds(List<Integer> ingredientIds);

    @Query("SELECT distinct ingredientCategory FROM Ingredient")
    List<String> getAllAllergyInfo();

    @Query("SELECT i FROM Ingredient i WHERE i.ingredientId IN :ingredientIds")
    List<Ingredient> findIngredientsByIds(@Param("ingredientIds") List<Integer> ingredientIds);
}
