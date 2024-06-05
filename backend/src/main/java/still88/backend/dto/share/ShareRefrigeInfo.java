package still88.backend.dto.share;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShareRefrigeInfo {
    private int refrigeId;
    private String createUserNickname;
    private String requestUserNickname;
    private String refrigeName;
    private boolean status;
}

