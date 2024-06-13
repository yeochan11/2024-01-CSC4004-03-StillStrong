package still88.backend.domain.ingredient.controller;


import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.ingredient.service.IngredientService;
import still88.backend.dto.ingredient.EditIngredientRequestDTO;
import still88.backend.dto.ingredient.RegisterIngredientDTO;

@RestController
@Slf4j
@RequestMapping("/refrige/ingredient")
@RequiredArgsConstructor
public class IngredientController {
    private final IngredientService ingredientService;

    @PostMapping("/register/{refrigeId}")
    public ResponseEntity<?> registerIngredient(@PathVariable("refrigeId") int refrigeId,
                                                @RequestBody RegisterIngredientDTO request,
                                                @RequestParam("userId") String userId){
        try{
            ingredientService.registerIngredient(refrigeId, request, userId);
            return ResponseEntity.ok("재료 등록 완료");
        }catch(Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/register")
    public ResponseEntity<?> showIngredientList(){
        try {
            return ResponseEntity.ok(ingredientService.ingredientList());
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @DeleteMapping("/delete/{refrigeId}/{ingredientId}")
    public ResponseEntity<?> deleteIngredient(@PathVariable("refrigeId") int refrigeId,
                                              @PathVariable("ingredientId") int ingredientId) {
        try{
            ingredientService.deleteIngredient(refrigeId, ingredientId);
            return ResponseEntity.ok("재료 삭제 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{refrigeId}")
    public ResponseEntity<?> showIngredientDetail(@PathVariable("refrigeId") int refrigeId,
                                                  @RequestParam("ingredientName") String ingredientName) {
        try {
            log.info("조회 시도, refrigeId = {}", refrigeId);
            return ResponseEntity.ok(ingredientService.ingredientDetail(refrigeId, ingredientName));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PatchMapping("/{refrigeId}/{ingredientId}/edit")
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

