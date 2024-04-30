package still88.backend.domain.ingredient.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.CookieValue;
import still88.backend.domain.ingredient.repository.IngredientRepository;
import still88.backend.domain.ingredient.repository.RefrigeListRepository;
import still88.backend.domain.ingredient.repository.ShareRefrigeRepository;
import still88.backend.dto.ingredient.RegisterIngredientDTO;
import still88.backend.entity.Ingredient;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;

import java.time.LocalDate;
import java.util.List;

@Service
public class IngredientServiceImpl implements IngredientService {
    @Autowired
    private IngredientRepository ingredientRepository;
    @Autowired
    RefrigeListRepository refrigeListRepository;
    @Autowired
    ShareRefrigeRepository shareRefrigeRepository;

    @Override
    public void registerIngredient(int refrigeId, RegisterIngredientDTO request) {
        try {
            Ingredient ingredient = ingredientRepository.findIngredientByIngredientName(request.getIngredientName());
            int ingredientNum = request.getIngredientNum();
            LocalDate createdDate = request.getCreatedDate();
            String ingredientMemo = request.getIngredientMemo();
            LocalDate ingredientDeadline = request.getCreatedDate().plusDays(14);
        }catch (Exception e){

        }

    }
}
