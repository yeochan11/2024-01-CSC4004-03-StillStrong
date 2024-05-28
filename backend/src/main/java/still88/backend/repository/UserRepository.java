package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findUserByUserId(int userId);

    User findUserByUserNickname(String userNickname);
}
