package still88.backend.domain.recommend.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import still88.backend.dto.recommend.MainPageResponseDTO;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class RecommendServiceImpl implements RecommendService{
    @Override
    public MainPageResponseDTO mainPage() {
        int MainRecipe_id = generateRandomNumber();
        List<Integer> SubRecipe_id = new ArrayList<>();
        for (int i = 0; i<5; i++){
            SubRecipe_id.add(generateRandomNumber());
        }

        return null;
    }

    private int generateRandomNumber() {
        return (int) (Math.random() * 997) + 1;
    }
}
