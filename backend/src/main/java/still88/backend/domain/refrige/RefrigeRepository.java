package still88.backend.domain.refrige;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import still88.backend.entity.RefrigeList;

@Repository
public interface RefrigeRepository extends JpaRepository<RefrigeList, Long> {

}
