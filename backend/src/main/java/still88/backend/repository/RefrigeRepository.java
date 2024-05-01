package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import still88.backend.entity.Refrige;

@Repository
public interface RefrigeRepository extends JpaRepository<Refrige, Long> {
}
