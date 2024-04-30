package still88.backend.domain.ingredient.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.ingredient.service.IngredientService;
import still88.backend.dto.ingredient.RegisterIngredientDTO;

@RestController
@Slf4j
@RequestMapping("/refrige/ingredient")
public class IngredientController {
    @Autowired
    IngredientService ingredientService;

    /**
     * Ingredient를 저장하는 함수
     * @param refrigeId : 사용중인 냉장고 번호
     * @param request : 재료이름,수량,구매일,유통기한,메모 저장한 DTO
     * @return
     */
    @PostMapping("/register/{refrigeId}")
    public ResponseEntity<?> registerIngredient(@PathVariable("refrigeId") int refrigeId,
                                                @RequestParam RegisterIngredientDTO request){
        try{
            ingredientService.registerIngredient(refrigeId, request);
            return ResponseEntity.ok("재료 등록 완료");
        }catch(Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

}
