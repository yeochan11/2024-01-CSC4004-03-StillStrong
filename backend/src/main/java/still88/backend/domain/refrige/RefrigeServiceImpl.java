package still88.backend.domain.refrige;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.domain.user.UserRepository;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.CreateRefrigeResponseDto;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;

@Service
@RequiredArgsConstructor
public class RefrigeServiceImpl implements RefrigeService {

    private final RefrigeRepository refrigeRepository;
    private final UserRepository userRepository;

    public CreateRefrigeResponseDto createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto) {
        User user = userRepository.findById(Long.parseLong(userId))
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        RefrigeList refrigeList = refrigeRepository.save(RefrigeList.builder()
                .refrigeName(createRefrigeRequestDto.getRefrigeName())
                .user(user)
                .build());

        return CreateRefrigeResponseDto.builder()
                .refrigeId(refrigeList.getRefrigeId())
                .build();
    }
}
