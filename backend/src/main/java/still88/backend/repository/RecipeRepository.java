package still88.backend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import still88.backend.entity.Recipe;

public interface RecipeRepository extends JpaRepository<Recipe, Long> {
}
