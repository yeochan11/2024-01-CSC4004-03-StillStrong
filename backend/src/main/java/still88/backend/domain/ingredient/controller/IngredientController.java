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
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{refrigeId}")
    public ResponseEntity<?> showIngredientDetail(@PathVariable("refrigeId") int refrigeId,
                                                  @RequestParam("ingredientName") String ingredientName,
                                                  HttpServletRequest request) {
        try {
            String userId = null;

            // 요청에서 쿠키 배열을 가져옵니다.
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                // 쿠키 배열을 반복하여 'userId' 쿠키를 찾습니다.
                for (Cookie cookie : cookies) {
                    if ("userId".equals(cookie.getName())) {
                        // 'userId' 쿠키를 찾으면 값을 가져옵니다.
                        userId = cookie.getValue();
                        break;
                    }
                }
            }

            log.info("userId = {}", userId);
            // userId가 없을 경우에 대한 처리
            if (userId == null) {
                return ResponseEntity.badRequest().body("Required cookie 'userId' is not present");
            }

            // userId가 있을 경우 요청을 처리합니다.
            log.info("조회 시도, refrigeId = {}. userId = {}", refrigeId, userId);
            return ResponseEntity.ok(ingredientService.ingredientDetail(refrigeId, ingredientName, userId));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PatchMapping("/{refrigeId}/{ingredientId}/edit")
    public ResponseEntity<?> editIngredient(@PathVariable("refrigeId") int refrigeId,
                                            @PathVariable("ingredientId") int ingredientId,
                                            @RequestBody EditIngredientRequestDTO request,
                                            @CookieValue String userId) {
        try{
            ingredientService.editIngredient(refrigeId, ingredientId, request, userId);
            return ResponseEntity.ok("수정완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}

