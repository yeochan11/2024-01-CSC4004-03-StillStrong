package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.Ingredient;
import still88.backend.entity.Refrige;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;

public interface RefrigeRepository extends JpaRepository<Refrige, Long> {
    void deleteRefrigeByRefrigeListAndIngredientAndUser(RefrigeList refrigeList, Ingredient ingredient, User user);

    Refrige findRefrigeByRefrigeListAndIngredient(RefrigeList refrigeList, Ingredient ingredient);
}