package still88.backend.domain.recipe.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    @GetMapping("/recipe/search")
    public ResponseEntity<?> getRecipeDetail(@RequestParam String searching){
        try {
            log.info("{} 에 대해 검색 시작합니다", searching);
            return ResponseEntity.ok(recipeService.serachRecipe(searching));
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
