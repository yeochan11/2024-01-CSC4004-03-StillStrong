package still88.backend.domain.refrige;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.entity.RefrigeList;

@Service
@RequiredArgsConstructor
public class RefrigeServiceImpl implements RefrigeService {

    private final RefrigeRepository refrigeRepository;

    public int createRefrige(String userId, CreateRefrigeRequestDto createRefrigeRequestDto) {
        RefrigeList refrigeList = refrigeRepository.save(RefrigeList.builder()
                .refrigeName(createRefrigeRequestDto.getRefrigeName())
                .build());
        return refrigeList.getRefrigeId();
    }
}
