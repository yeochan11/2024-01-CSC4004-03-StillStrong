package still88.backend.dto.share;

import lombok.Data;

@Data
public class AcceptRequestDto {
    private int requestUserId;
    private boolean accept;
}
