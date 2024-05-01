package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import still88.backend.entity.Ingredient;
import still88.backend.entity.Refrige;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;

import java.util.List;

@Repository
public interface RefrigeRepository extends JpaRepository<Refrige, Long> {
    void deleteRefrigeByRefrigeListAndIngredientAndUser(RefrigeList refrigeList, Ingredient ingredient, User user);

    Refrige findRefrigeByRefrigeListAndIngredient(RefrigeList refrigeList, Ingredient ingredient);

    @Query("SELECT r.ingredient.id FROM Refrige r WHERE r.refrigeList.refrigeId = :refrigeId")
    List<Integer> findIngredientIdsByRefrigeId(int refrigeId);
}