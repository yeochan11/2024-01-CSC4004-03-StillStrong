package still88.backend.domain.ingredient.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.coyote.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.ingredient.service.IngredientService;
import still88.backend.dto.ingredient.EditIngredientRequestDTO;
import still88.backend.dto.ingredient.RegisterIngredientDTO;

@RestController
@Slf4j
@RequestMapping("/refrige/ingredient")
public class IngredientController {
    @Autowired
    IngredientService ingredientService;

    @PostMapping("/register/{refrigeId}")
    public ResponseEntity<?> registerIngredient(@PathVariable("refrigeId") int refrigeId,
                                                @RequestBody RegisterIngredientDTO request,
                                                @CookieValue String userId){
        try{
            ingredientService.registerIngredient(refrigeId, request, userId);
            return ResponseEntity.ok("재료 등록 완료");
        }catch(Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @DeleteMapping("/delete/{refrigeId}/{ingredientId}")
    public ResponseEntity<?> deleteIngredient(@PathVariable("refrigeId") int refrigeId,
                                              @PathVariable("ingredientId") int ingredientId,
                                              @CookieValue String userId) {
        try{
            ingredientService.deleteIngredient(refrigeId, ingredientId, userId);
            return ResponseEntity.ok("재료 삭제 완료");
        }catch (Exception e)
        {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{refrigeId}/{ingredientId}")
    public ResponseEntity<?> showIngredientDetail(@PathVariable("refrigeId") int refrigeId,
                                                  @PathVariable("ingredientId") int ingredientId) {
        try{
            return ResponseEntity.ok(ingredientService.ingredientDetail(refrigeId, ingredientId));
        }catch(Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PatchMapping("/edit/{refrigeId}/{ingredientId}")
    public ResponseEntity<?> editIngredient(@PathVariable("refrigeId") int refrigeId,
                                            @PathVariable("ingredientId") int ingredientId,
                                            @RequestBody EditIngredientRequestDTO request) {
        try{
            ingredientService.editIngredient(refrigeId, ingredientId, request);
            return ResponseEntity.ok("수정완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
