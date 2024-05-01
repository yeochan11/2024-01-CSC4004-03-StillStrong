package still88.backend.domain.refrige;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.CreateUpdateRefrigeResponseDto;
import still88.backend.dto.refrige.UpdateRefrigeRequestDto;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;
import still88.backend.repository.RefrigeListRepository;
import still88.backend.repository.UserRepository;

@Service
@RequiredArgsConstructor
public class RefrigeServiceImpl implements RefrigeService {

    private final RefrigeListRepository refrigeListRepository;
    private final UserRepository userRepository;

    public CreateUpdateRefrigeResponseDto createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto) {
        User user = userRepository.findById(Long.parseLong(userId))
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        RefrigeList refrigeList = refrigeListRepository.save(RefrigeList.builder()
                .refrigeName(createRefrigeRequestDto.getRefrigeName())
                .user(user)
                .build());

        return CreateUpdateRefrigeResponseDto.builder()
                .refrigeId(refrigeList.getRefrigeId())
                .refrigeName(refrigeList.getRefrigeName())
                .build();
    }

    public CreateUpdateRefrigeResponseDto updateRefrige(int refrigeId, UpdateRefrigeRequestDto updateRefrigeRequestDto) {
        RefrigeList refrigeList = refrigeListRepository.findById((long) refrigeId)
                .orElseThrow(() -> new IllegalArgumentException("Refrige not found with id: " + refrigeId));

        // 기존 엔티티 수정
        refrigeList.updateRefrigeName(updateRefrigeRequestDto.getRefrigeName());
        RefrigeList updatedRefrigeList = refrigeListRepository.save(refrigeList);


        return CreateUpdateRefrigeResponseDto.builder()
                .refrigeId(updatedRefrigeList.getRefrigeId())
                .refrigeName(updatedRefrigeList.getRefrigeName())
                .build();
    }
}
