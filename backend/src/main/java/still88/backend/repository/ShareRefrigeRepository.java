package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;

import java.util.List;

public interface ShareRefrigeRepository extends JpaRepository<ShareRefrige, Long> {
    List<ShareRefrige> findAllByRefrigeList(RefrigeList refrigeList);
}
