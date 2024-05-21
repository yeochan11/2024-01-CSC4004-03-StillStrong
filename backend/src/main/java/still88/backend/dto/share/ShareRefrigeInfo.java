package still88.backend.dto.share;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Builder
public class ShareRefrigeInfo {
    private Long shareId;
    private String createUserNickname;
    private String requestUserNickname;
    private String refrigeName;
    private boolean status;
}
