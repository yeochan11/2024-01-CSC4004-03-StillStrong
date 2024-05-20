package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Repository;
import still88.backend.entity.ShareRefrige;
import still88.backend.entity.User;

@Repository
public interface ShareRefrigeRepository extends JpaRepository<ShareRefrige, Long> {
    List<ShareRefrige> findAllByRefrigeList(RefrigeList refrigeList);
    Optional<ShareRefrige> findByCreateUserIdAndRequestUserIdAndRefrigeList(User createUserId, User requestUserId, RefrigeList refrigeList);

    Optional<ShareRefrige> findByRequestUserIdAndRefrigeList(User user, RefrigeList refrigeList);
}
