package still88.backend.domain.ingredient.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.RefrigeList;

public interface RefrigeListRepository extends JpaRepository<RefrigeList, Long> {
    RefrigeList findByRefrigeId(int refrigeId);
}
