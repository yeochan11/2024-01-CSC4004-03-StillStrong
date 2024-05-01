package still88.backend.domain.refrige.service;

import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.CreateUpdateRefrigeResponseDto;
import still88.backend.dto.refrige.GetRefrigeListResponseDto;
import still88.backend.dto.refrige.UpdateRefrigeRequestDto;

public interface RefrigeService {
    public CreateUpdateRefrigeResponseDto createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto);
    public CreateUpdateRefrigeResponseDto updateRefrige(int refrigeId, UpdateRefrigeRequestDto updateRefrigeRequestDto);
    public GetRefrigeListResponseDto getRefrigeList(int refrigeId);
}
