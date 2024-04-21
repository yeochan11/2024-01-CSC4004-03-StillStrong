package still88.backend.dto.likes;

import lombok.Data;

@Data
public class LikesRequestDto {
    private int userId;
    private int recipeId;
}
