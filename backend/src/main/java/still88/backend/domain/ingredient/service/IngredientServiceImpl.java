package still88.backend.domain.ingredient.service;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CookieValue;
import still88.backend.dto.ingredient.EditIngredientRequestDTO;
import still88.backend.dto.ingredient.IngredientDetailResponseDTO;
import still88.backend.repository.*;
import still88.backend.dto.ingredient.RegisterIngredientDTO;
import still88.backend.entity.*;
import still88.backend.repository.IngredientRepository;

import java.time.LocalDate;

@Service
@Slf4j
@RequiredArgsConstructor
public class IngredientServiceImpl implements IngredientService {
    private final IngredientRepository ingredientRepository;
    private final RefrigeListRepository refrigeListRepository;
    private final ShareRefrigeRepository shareRefrigeRepository;
    private final UserRepository userRepository;
    private final RefrigeRepository refrigeRepository;

    @Override
    public void registerIngredient(int refrigeId, RegisterIngredientDTO request, String userId) {
        try {
            RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
            String ingredientName = request.getIngredientName();
            Ingredient ingredient = ingredientRepository.findIngredientByIngredientName(ingredientName);
            User user = userRepository.findUserByUserId(Integer.parseInt(userId));
            LocalDate createdDate = request.getCreatedDate();
            int ingredientNum = request.getIngredientNum();
            String ingredientPlace = request.getIngredientPlace();
            LocalDate ingredientDeadline = createdDate.plusDays(14);
            String ingredientMemo = request.getIngredientMemo();

            Refrige existingRefrige = refrigeRepository.findByRefrigeListAndIngredient_IngredientName(refrigeList, ingredientName);

            if (existingRefrige != null) {
                // 이미 등록된 재료가 있는 경우
                int totalIngredientNum = existingRefrige.getIngredientNum() + ingredientNum;
                existingRefrige.updateInfo(createdDate, ingredientDeadline, totalIngredientNum, ingredientPlace, ingredientMemo);
                refrigeRepository.save(existingRefrige);
            } else {
                // 새로운 재료를 등록하는 경우
                Refrige newRefrige = Refrige.builder()
                        .refrigeList(refrigeList)
                        .ingredient(ingredient)
                        .user(user)
                        .createdDate(createdDate)
                        .ingredientNum(ingredientNum)
                        .ingredientPlace(ingredientPlace)
                        .ingredientDeadline(ingredientDeadline)
                        .ingredientMemo(ingredientMemo)
                        .build();
                refrigeRepository.save(newRefrige);
            }

        } catch (Exception e) {
            log.error("Error occurred while registering ingredient: {}", e.getMessage());
            throw new RuntimeException("Failed to register ingredient", e);
        }
    }


    @Override
    @Transactional
    public void deleteIngredient(int refrigeId, int ingredientId, String userId) {
        try {
            RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
            Ingredient ingredient = ingredientRepository.findIngredientByIngredientId(ingredientId);
            User user = userRepository.findUserByUserId(Integer.parseInt(userId));
            refrigeRepository.deleteRefrigeByRefrigeListAndIngredientAndUser(refrigeList, ingredient, user);
        }catch (Exception e){
            throw new RuntimeException(e);
        }
    }

    @Override
    public IngredientDetailResponseDTO ingredientDetail(int refrigeId, String ingredientName, String userId) {
        Ingredient ingredient = ingredientRepository.findIngredientByIngredientName(ingredientName);
        RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
        User user = userRepository.findUserByUserId(Integer.parseInt(userId));

        Refrige refrige = refrigeRepository.findRefrigeByRefrigeListAndIngredientAndUser(refrigeList, ingredient, user);

        String ingredientPlace = refrige.getIngredientPlace();
        LocalDate createdDate = refrige.getCreatedDate();
        LocalDate ingredientDeadline = refrige.getIngredientDeadline();
        int ingredientNum = refrige.getIngredientNum();
        String ingredientMemo = refrige.getIngredientMemo();

        return new IngredientDetailResponseDTO(ingredientPlace, ingredientName, createdDate, ingredientDeadline, ingredientNum, ingredientMemo, ingredient.getIngredientId());
    }

    @Override
    public void editIngredient(int refrigeId, int ingredientId, EditIngredientRequestDTO request, String userId) {
        RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
        Ingredient ingredient = ingredientRepository.findIngredientByIngredientId(ingredientId);
        User user = userRepository.findUserByUserId(Integer.parseInt(userId));

        Refrige refrige = refrigeRepository.findRefrigeByRefrigeListAndIngredientAndUser(refrigeList, ingredient, user);

        LocalDate createdDate = request.getCreatedDate();
        LocalDate ingredientDeadline = request.getIngredientDeadline();
        int ingredientNum = request.getIngredientNum();
        String ingredientPlace = request.getIngredientPlace();
        String ingredientMemo = request.getIngredientMemo();

        refrige.updateInfo(createdDate, ingredientDeadline, ingredientNum, ingredientPlace, ingredientMemo);
        refrigeRepository.save(refrige);
    }
}
