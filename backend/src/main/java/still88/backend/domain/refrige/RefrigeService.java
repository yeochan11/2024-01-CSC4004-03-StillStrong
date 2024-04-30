package still88.backend.domain.refrige;

import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.CreateRefrigeResponseDto;
import still88.backend.entity.RefrigeList;

public interface RefrigeService {
    public CreateRefrigeResponseDto createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto);
}
