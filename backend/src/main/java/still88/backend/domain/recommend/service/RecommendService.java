package still88.backend.domain.recommend.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import still88.backend.dto.recommend.FeedbackRequestDTO;
import still88.backend.dto.recommend.RecommendResponseDTO;

import java.util.List;

public interface RecommendService {
    RecommendResponseDTO recommend(int userId, List<String> ingredientList) throws JsonProcessingException;

    void feedback(FeedbackRequestDTO dto);
}
