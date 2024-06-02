package still88.backend.domain.recommend.service;

import still88.backend.dto.recommend.FeedbackRequestDTO;
import still88.backend.dto.recommend.RecommendResponseDTO;

import java.util.List;

public interface RecommendService {
    RecommendResponseDTO recommend(int userId, List<String> ingredientList);

    void feedback(FeedbackRequestDTO dto);
}
