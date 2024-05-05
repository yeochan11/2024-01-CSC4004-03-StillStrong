package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import still88.backend.entity.IdPassword;
import still88.backend.entity.User;

public interface IdPasswordRepository extends JpaRepository<IdPassword, Long> {
    IdPassword findIdPasswordByUser(User user);

    IdPassword findIdPasswordBySecretEmailAndUser(String secretEmail, User user);
    @Query("SELECT i.user FROM IdPassword i WHERE i.secretEmail = :email")
    User findIdUserBySecretEmail(String email);
}
