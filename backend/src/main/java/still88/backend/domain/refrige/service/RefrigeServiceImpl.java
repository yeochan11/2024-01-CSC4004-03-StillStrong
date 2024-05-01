package still88.backend.domain.refrige.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.*;
import still88.backend.entity.Refrige;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;
import still88.backend.repository.IngredientRepository;
import still88.backend.repository.RefrigeListRepository;
import still88.backend.repository.RefrigeRepository;
import still88.backend.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class RefrigeServiceImpl implements RefrigeService {

    private final RefrigeListRepository refrigeListRepository;
    private final UserRepository userRepository;
    private final RefrigeRepository refrigeRepository;
    private final IngredientRepository ingredientRepository;

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

    public GetRefrigeListResponseDto getRefrigeList(int userId) {
        User user = userRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        List<RefrigeList> refrigeLists = refrigeListRepository.findByUser(user);
        List<RefrigeInfoDto> refrigeInfoList = refrigeLists.stream()
                .map(refrigeList -> RefrigeInfoDto.builder()
                        .refrigeId(refrigeList.getRefrigeId())
                        .refrigeName(refrigeList.getRefrigeName())
                        .build())
                .collect(Collectors.toList());

        return GetRefrigeListResponseDto.builder()
                .refrigeList(refrigeInfoList)
                .build();
    }

    public GetRefrigeIngredientResponseDto getRefrigeIngredient(int refrigeId) {
        List<Integer> ingredientIds = refrigeRepository.findIngredientIdsByRefrigeId(refrigeId);
        List<String> ingredientNames = ingredientRepository.findIngredientNamesByIngredientIds(ingredientIds);
        return new GetRefrigeIngredientResponseDto(ingredientNames);
    }
}
