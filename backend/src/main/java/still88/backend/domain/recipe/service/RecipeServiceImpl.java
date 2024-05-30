package still88.backend.domain.recipe.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.recipe.MainPageResponseDTO;
import still88.backend.dto.recipe.RecipeDetailResponseDTO;
import still88.backend.dto.recipe.RecipeInfoDto;
import still88.backend.dto.recipe.SearchResponseDTO;
import still88.backend.entity.Recipe;
import still88.backend.repository.RecipeRepository;

import java.util.*;

@Service
@RequiredArgsConstructor
public class RecipeServiceImpl implements RecipeService {

    private final RecipeRepository recipeRepository;
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public MainPageResponseDTO getRandomRecipes(int recipeNum) {
        List<RecipeInfoDto> randomRecipes = new ArrayList<>();
        Set<Integer> selectedRecipeIds = new HashSet<>();

        int MainRecipeId = getRandomRecipeId();
        Recipe MainRecipe = recipeRepository.findById(Long.valueOf(MainRecipeId)).orElse(null);
        List<String> SubRecipeName = new ArrayList<>();
        List<String> SubRecipeCategory = new ArrayList<>();
        List<String> SubRecipeImage = new ArrayList<>();

        // 랜덤으로 recipeNum 개수만큼의 레시피 ID를 생성
        while (selectedRecipeIds.size() < recipeNum) {
            int randomRecipeId = getRandomRecipeId();
            if (!selectedRecipeIds.contains(randomRecipeId));
                selectedRecipeIds.add(randomRecipeId);
                Recipe subRecipe = recipeRepository.findById(Long.valueOf(randomRecipeId)).orElse(null);
                SubRecipeName.add(subRecipe.getRecipeName());
                SubRecipeCategory.add((subRecipe.getRecipeCategory()));
                SubRecipeImage.add(subRecipe.getRecipeMainImage());
        }


        return MainPageResponseDTO.builder()
                .MainRecipeImage(MainRecipe.getRecipeMainImage())
                .MainRecipeName(MainRecipe.getRecipeName())
                .SubRecipeName(SubRecipeName)
                .SubRecipeImage(SubRecipeImage)
                .SubRecipeCategory(SubRecipeCategory)
                .build();
    }

    @Override
    public SearchResponseDTO serachRecipe(String seraching) throws JsonProcessingException {
        List<Recipe> recipes = recipeRepository.findAllByRecipeNameContaining(seraching);
        List<String> recipeNames = new ArrayList<>();
        List<String> recipeMainImages = new ArrayList<>();
        List<List<String>> recipeIngredients = new ArrayList<>();

        for (Recipe recipe : recipes){
            recipeNames.add(recipe.getRecipeName());
            recipeMainImages.add(recipe.getRecipeMainImage());
            recipeIngredients.add(jsonToArray(recipe.getRecipeIngredient()));
        }
        return SearchResponseDTO.builder()
                                .recipeNames(recipeNames)
                                .recipeMainImages(recipeMainImages)
                                .recipeIngredients(recipeIngredients).build();
    }

    private List<String> jsonToArray(String json) throws JsonProcessingException {
        return objectMapper.readValue(json.replace(", ", ","), new TypeReference<List<String>>() {});
    }

    // 997까지의 레시피 ID 중 랜덤으로 선택하는 메서드
    private int getRandomRecipeId() {
        int totalRecipes = 997;
        Random random = new Random();
        return random.nextInt(totalRecipes) + 1; // 1부터 시작하도록
    }


}
