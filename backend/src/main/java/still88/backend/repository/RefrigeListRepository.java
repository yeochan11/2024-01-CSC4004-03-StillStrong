package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import still88.backend.entity.Refrige;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;

import java.util.List;

@Repository
public interface RefrigeListRepository extends JpaRepository<RefrigeList, Long> {
    List<RefrigeList> findByUser(User user);

    RefrigeList findByRefrigeIdAndUser(int refrigeId, User user);

    RefrigeList findByRefrigeId(int refrigeId);

    RefrigeList findRefrigeListByRefrigeNameAndUser(String refrigeName, User user);
}
