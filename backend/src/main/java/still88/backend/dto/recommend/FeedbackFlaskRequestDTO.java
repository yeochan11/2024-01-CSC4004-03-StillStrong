package still88.backend.dto.recommend;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FeedbackFlaskRequestDTO {
    private boolean feedback;
}
