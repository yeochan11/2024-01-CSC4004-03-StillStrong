package still88.backend.domain.ingredient.service;

import org.springframework.web.bind.annotation.CookieValue;
import still88.backend.dto.ingredient.EditIngredientRequestDTO;
import still88.backend.dto.ingredient.IngredientDetailResponseDTO;
import still88.backend.dto.ingredient.RegisterIngredientDTO;
import still88.backend.entity.Ingredient;

public interface IngredientService {
    void registerIngredient(int refrigeId, RegisterIngredientDTO registerIngredientDTO, @CookieValue String userId);

    void deleteIngredient(int refrigeId, int ingredientId, @CookieValue String userId);

    IngredientDetailResponseDTO ingredientDetail(int refrigeId, int ingredientId);

    void editIngredient(int refrigeId, int ingredientId, EditIngredientRequestDTO request);

    public Ingredient insertIngredient();
}