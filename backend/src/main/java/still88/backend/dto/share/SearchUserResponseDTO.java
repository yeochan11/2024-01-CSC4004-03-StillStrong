package still88.backend.dto.share;


import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SearchUserResponseDTO {
    private String searchedUserImage;
    private List<String> refrigeNames;
    private List<Integer> refrigeIds;
}
