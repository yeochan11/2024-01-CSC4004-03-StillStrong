package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import still88.backend.entity.User;
@Repository
public interface UserRepository extends JpaRepository<User, Long>{
}
