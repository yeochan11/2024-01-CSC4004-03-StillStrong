package still88.backend.domain.recipe.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import still88.backend.domain.recipe.service.RecipeService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/recommend")
@Slf4j
public class RecipeController {

    private final RecipeService recipeService;

    // 랜덤 레시피 조회
    @GetMapping("/mainPage")
    public ResponseEntity<?> getRandomRecipes() {
        log.info("메인페이지 요청");
        return ResponseEntity.ok().body(recipeService.getRandomRecipes(5));
    }
}
