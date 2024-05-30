package still88.backend.domain.refrige.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.*;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;
import still88.backend.entity.User;
import still88.backend.repository.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RefrigeServiceImpl implements RefrigeService {

    private final RefrigeListRepository refrigeListRepository;
    private final UserRepository userRepository;
    private final RefrigeRepository refrigeRepository;
    private final IngredientRepository ingredientRepository;
    private final ShareRefrigeRepository shareRefrigeRepository;

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
                .share(null)
                .ingredientNames(null)
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

    public RefrigeWithIngredientsResponseDto getRefrigeWithIngredients(int userId) {
        User user = userRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));
        // 내가 생성한 냉장고
        List<RefrigeList> refrigeLists = refrigeListRepository.findByUser(user);
        String currentRefrigeName = refrigeLists.get(0).getRefrigeName();
        List<RefrigeInfoDto> refrigeInfoList = refrigeLists.stream()
                .map(refrigeList -> {
                    boolean isShared = shareRefrigeRepository.findByRefrigeListAndStatus(refrigeList, true).size() > 0;
                    List<String> ingredientNames = getIngredientNames(refrigeList.getRefrigeId());
                    return RefrigeInfoDto.builder()
                            .refrigeId(refrigeList.getRefrigeId())
                            .refrigeName(refrigeList.getRefrigeName())
                            .share(isShared)
                            .ingredientNames(ingredientNames)
                            .build();
                })
                .collect(Collectors.toList());

        // 공유 냉장고
        List<ShareRefrige> sharedRefriges = shareRefrigeRepository.findByRequestUserIdAndStatus(Optional.ofNullable(user), true);
        List<RefrigeInfoDto> sharedRefrigeInfoList = sharedRefriges.stream()
                .map(shareRefrige -> {
                    RefrigeList refrigeList = shareRefrige.getRefrigeList();
                    List<String> ingredientNames = getIngredientNames(refrigeList.getRefrigeId());
                    return RefrigeInfoDto.builder()
                            .refrigeId(refrigeList.getRefrigeId())
                            .refrigeName(refrigeList.getRefrigeName())
                            .share(true)
                            .ingredientNames(ingredientNames)
                            .build();
                })
                .collect(Collectors.toList());

        // 모든 냉장고 합치기
        refrigeInfoList.addAll(sharedRefrigeInfoList);

        return RefrigeWithIngredientsResponseDto.builder()
                .refrigeList(refrigeInfoList)
                .currentRefrigeName(currentRefrigeName)
                .build();
    }

    private List<String> getIngredientNames(int refrigeId) {
        List<Integer> ingredientIds = refrigeRepository.findIngredientIdsByRefrigeId(refrigeId);
        return ingredientRepository.findIngredientNamesByIngredientIds(ingredientIds);
    }
}

