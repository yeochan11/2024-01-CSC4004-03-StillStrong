package still88.backend.domain.refrige.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.*;
import still88.backend.entity.*;
import still88.backend.repository.*;

import java.time.Duration;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
                    List<Integer> ingredientDeadlines = getIngredientDeadlines(refrigeList.getRefrigeId());
                    return RefrigeInfoDto.builder()
                            .refrigeId(refrigeList.getRefrigeId())
                            .refrigeName(refrigeList.getRefrigeName())
                            .share(isShared)
                            .ingredientNames(ingredientNames)
                            .ingredientDeadlines(ingredientDeadlines)
                            .build();
                })
                .collect(Collectors.toList());

        // 공유 냉장고
        List<ShareRefrige> sharedRefriges = shareRefrigeRepository.findByRequestUserIdAndStatus(Optional.ofNullable(user), true);
        List<RefrigeInfoDto> sharedRefrigeInfoList = sharedRefriges.stream()
                .map(shareRefrige -> {
                    RefrigeList refrigeList = shareRefrige.getRefrigeList();
                    List<String> ingredientNames = getIngredientNames(refrigeList.getRefrigeId());
                    List<Integer> ingredientDeadlines = getIngredientDeadlines(refrigeList.getRefrigeId());
                    return RefrigeInfoDto.builder()
                            .refrigeId(refrigeList.getRefrigeId())
                            .refrigeName(refrigeList.getRefrigeName())
                            .share(true)
                            .ingredientNames(ingredientNames)
                            .ingredientDeadlines(ingredientDeadlines)
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
        List<Ingredient> ingredients = ingredientRepository.findIngredientsByIds(ingredientIds);

        Map<Integer, String> ingredientIdNameMap = ingredients.stream()
                .collect(Collectors.toMap(
                        Ingredient::getIngredientId,
                        Ingredient::getIngredientName
                ));

        return ingredientIds.stream()
                .map(ingredientIdNameMap::get)
                .collect(Collectors.toList());
    }


    private List<Integer> getIngredientDeadlines(int refrigeId) {
        List<Refrige> ingredients = refrigeRepository.findByRefrigeList_RefrigeId(refrigeId);
        return ingredients.stream()
                .map(ingredient -> {
                    LocalDate createdDate = ingredient.getCreatedDate();
                    LocalDate ingredientDeadline = ingredient.getIngredientDeadline();
                    Duration duration = Duration.between(createdDate.atStartOfDay(), ingredientDeadline.atStartOfDay());
                    return (int) duration.toDays();
                })
                .collect(Collectors.toList());
    }
}

