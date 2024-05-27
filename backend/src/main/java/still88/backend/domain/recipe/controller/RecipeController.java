package still88.backend.domain.recipe.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import still88.backend.domain.recipe.service.RecipeService;
import still88.backend.dto.recipe.RandomRecipeResponseDto;
import still88.backend.entity.Recipe;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/recipe/recommend")
public class RecipeController {

    private final RecipeService recipeService;

    // 랜덤 레시피 조회
    @GetMapping("/random")
    public ResponseEntity<?> getRandomRecipes() {
        return ResponseEntity.ok(recipeService.getRandomRecipes(10));
    }
}
