package still88.backend.domain.refrige.service;

import still88.backend.dto.refrige.*;

public interface RefrigeService {
    public CreateUpdateRefrigeResponseDto createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto);
    public CreateUpdateRefrigeResponseDto updateRefrige(int refrigeId, UpdateRefrigeRequestDto updateRefrigeRequestDto);
    public RefrigeWithIngredientsResponseDto getRefrigeWithIngredients(int userId);
}
