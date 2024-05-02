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
            RefrigeList refirigeList = refrigeListRepository.findByRefrigeId(refrigeId);
            Ingredient ingredient = ingredientRepository.findIngredientByIngredientName(request.getIngredientName());
            User user = userRepository.findUserByUserId(Integer.parseInt(userId));
            LocalDate createdDate = request.getCreatedDate();
            int ingredientNum = request.getIngredientNum();
            String ingredientPlace = request.getIngredientPlace();
            LocalDate ingredientDeadline = request.getCreatedDate().plusDays(14);
            String ingredientMemo = request.getIngredientMemo();

            Refrige refrige = Refrige.builder()
                    .refrigeList(refirigeList)
                    .ingredient(ingredient)
                    .user(user)
                    .createdDate(createdDate)
                    .ingredientNum(ingredientNum)
                    .ingredientPlace(ingredientPlace)
                    .ingredientDeadline(ingredientDeadline)
                    .ingredientMemo(ingredientMemo)
                    .build();

            refrigeRepository.save(refrige);
        }catch (Exception e){
            log.info("error={}", e);
            throw new RuntimeException(e);
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
    public IngredientDetailResponseDTO ingredientDetail(int refrigeId, int ingredientId, String userId) {
        Ingredient ingredient = ingredientRepository.findIngredientByIngredientId(ingredientId);
        RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
        User user = userRepository.findUserByUserId(Integer.parseInt(userId));

        Refrige refrige = refrigeRepository.findRefrigeByRefrigeListAndIngredientAndUser(refrigeList, ingredient, user);

        String ingredientPlace = refrige.getIngredientPlace();
        String ingredientName = ingredient.getIngredientName();
        LocalDate createdDate = refrige.getCreatedDate();
        LocalDate ingredientDeadline = refrige.getIngredientDeadline();
        int ingredientNum = refrige.getIngredientNum();
        String ingredientMemo = refrige.getIngredientMemo();

        IngredientDetailResponseDTO ingredientDetail = new IngredientDetailResponseDTO(ingredientPlace, ingredientName,
                createdDate, ingredientDeadline, ingredientNum, ingredientMemo);

        return ingredientDetail;
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
