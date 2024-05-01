package still88.backend.domain.ingredient.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CookieValue;
import still88.backend.repository.*;
import still88.backend.dto.ingredient.RegisterIngredientDTO;
import still88.backend.entity.*;
import still88.backend.repository.IngredientRepository;

import java.time.LocalDate;
import java.util.List;

@Service
@Slf4j
public class IngredientServiceImpl implements IngredientService {
    private final IngredientRepository ingredientRepository;
    private final RefrigeListRepository refrigeListRepository;
    private final ShareRefrigeRepository shareRefrigeRepository;
    private final UserRepository userRepository;
    private final RefrigeRepository refrigeRepository;

    @Autowired
    public IngredientServiceImpl(IngredientRepository ingredientRepository,
                                 RefrigeListRepository refrigeListRepository,
                                 ShareRefrigeRepository shareRefrigeRepository,
                                 UserRepository userRepository, RefrigeRepository refrigeRepository) {
        this.ingredientRepository = ingredientRepository;
        this.refrigeListRepository = refrigeListRepository;
        this.shareRefrigeRepository = shareRefrigeRepository;
        this.userRepository = userRepository;
        this.refrigeRepository = refrigeRepository;
    }

    @Override
    public void registerIngredient(int refrigeId, RegisterIngredientDTO request, @CookieValue String userId) {
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
    public void deleteIngredient(int refrigeId, int ingredientId, @CookieValue String userId) {
        try {
            RefrigeList refrigeList = refrigeListRepository.findByRefrigeId(refrigeId);
            Ingredient ingredient = ingredientRepository.findIngredientByIngredientId(ingredientId);
            User user = userRepository.findUserByUserId(Integer.parseInt(userId));
            refrigeRepository.deleteRefrigeByRefrigeListAndIngredientAndUser(refrigeList, ingredient, user);
        }catch (Exception e){
            throw new RuntimeException(e);
        }

    }
}
