package still88.backend.domain.recommend.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import still88.backend.dto.recommend.FlaskResponseDTO;
import still88.backend.dto.recommend.RecommendFlaskDTO;
import still88.backend.dto.recommend.RecommendResponseDTO;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class RecommendServiceImpl implements RecommendService{
    @Override
    public RecommendResponseDTO recommend(int userId, List<String> ingredientList) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:5000/recommend/ingredient";
        RecommendFlaskDTO requestBody = RecommendFlaskDTO.builder().userId(userId).ingredientList(ingredientList).build();
        ResponseEntity<FlaskResponseDTO> Response = restTemplate.postForEntity(url, requestBody, FlaskResponseDTO.class);
        return null;
    }
}
