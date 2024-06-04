package still88.backend.dto.recommend;

import lombok.Data;

@Data
public class FeedbackRequestDTO {
    private boolean feedback;

    public boolean getFeedback() {
        return feedback;
    }
}
