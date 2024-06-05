package still88.backend.dto.recommend;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RecommendFlaskDTO {
    private int userId;
    private List<String> ingredientList;
}
