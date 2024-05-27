package still88.backend.domain.recipe.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.recipe.RandomRecipeResponseDto;
import still88.backend.dto.recipe.RecipeInfoDto;
import still88.backend.entity.Recipe;
import still88.backend.repository.RecipeRepository;

import java.util.*;

@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;

    public RandomRecipeResponseDto getRandomRecipes(int recipeNum) {
        List<RecipeInfoDto> randomRecipes = new ArrayList<>();
        // 중복 없이 랜덤 정수를 생성하기 위해 HashSet 사용
        Set<Integer> selectedRecipeIds = new HashSet<>();

        // 랜덤으로 recipeNum 개수만큼의 레시피 ID를 생성
        while (selectedRecipeIds.size() < recipeNum) {
            int randomRecipeId = getRandomRecipeId();
            selectedRecipeIds.add(randomRecipeId);
        }

        // 선택된 레시피 ID에 해당하는 레시피 정보를 가져와서 DTO에 추가
        for (Integer recipeId : selectedRecipeIds) {
            Recipe recipe = recipeRepository.findById(Long.valueOf(recipeId)).orElse(null);
            if (recipe != null) {
                RecipeInfoDto recipeInfoDto = RecipeInfoDto.builder()
                        .recipeId(recipe.getRecipeId())
                        .recipeName(recipe.getRecipeName())
                        .recipeCategory(recipe.getRecipeCategory())
                        .recipeMainImage(recipe.getRecipeMainImage())
                        .build();
                randomRecipes.add(recipeInfoDto);
            }
        }

        return RandomRecipeResponseDto.builder().recipeList(randomRecipes).build();
    }

    // 997까지의 레시피 ID 중 랜덤으로 선택하는 메서드
    private int getRandomRecipeId() {
        int totalRecipes = 997;
        Random random = new Random();
        return random.nextInt(totalRecipes) + 1; // 1부터 시작하도록
    }
}
