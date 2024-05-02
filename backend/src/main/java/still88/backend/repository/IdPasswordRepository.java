package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.IdPassword;
import still88.backend.entity.User;

public interface IdPasswordRepository extends JpaRepository<IdPassword, Long> {

}
