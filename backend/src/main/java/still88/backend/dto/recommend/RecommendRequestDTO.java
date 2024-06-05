package still88.backend.dto.recommend;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class RecommendRequestDTO {
    private int userId;
    private List<String> ingredientList;
}
