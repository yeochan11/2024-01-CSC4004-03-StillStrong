package still88.backend.domain.recommend.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import still88.backend.dto.recommend.*;
import still88.backend.entity.Recipe;
import still88.backend.repository.RecipeRepository;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class RecommendServiceImpl implements RecommendService{
    private final RecipeRepository recipeRepository;
    private static final ObjectMapper objectMapper = new ObjectMapper();
    @Override
    public RecommendResponseDTO recommend(int userId, List<String> ingredientList) throws JsonProcessingException {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://54.180.135.103:5000/recommend/ingredient";
        RecommendFlaskDTO requestBody = RecommendFlaskDTO.builder().userId(userId).ingredientList(ingredientList).build();
        FlaskResponseDTO response = restTemplate.postForEntity(url, requestBody, FlaskResponseDTO.class).getBody();
        List<Integer> recipeId = response.getRecipeId();

        List<String> recipeNames = new ArrayList<>();
        List<String> recipeImages = new ArrayList<>();
        List<List<String>> recipeIngredients = new ArrayList<>();

        for (Integer id : recipeId) {
            log.info("recipeId = {}", id);
            Recipe recipe = recipeRepository.findByRecipeId(id);
            recipeNames.add(recipe.getRecipeName());
            recipeImages.add(recipe.getRecipeMainImage());
            recipeIngredients.add(jsonToArray(recipe.getRecipeIngredient()));
        }
        return RecommendResponseDTO.builder()
                .recipeNames(recipeNames)
                .recipeIngredients(recipeIngredients)
                .recipeMainImages(recipeImages)
                .build();
    }

    @Override
    public void feedback(FeedbackRequestDTO dto) {
        boolean feedback = dto.getFeedback();
        String url = "http://54.180.135.103/recommend/feedback";
        FeedbackFlaskRequestDTO requestBody = FeedbackFlaskRequestDTO.builder().feedback(feedback).build();

        RestTemplate restTemplate = new RestTemplate();
        FeedbackFlaskResponseDTO Response = restTemplate.postForEntity(url, requestBody, FeedbackFlaskResponseDTO.class).getBody();

        log.info(Response.getStatus());
    }

    private List<String> jsonToArray(String json) throws JsonProcessingException {
        return objectMapper.readValue(json.replace(", ", ","), new TypeReference<List<String>>() {});
    }
}
