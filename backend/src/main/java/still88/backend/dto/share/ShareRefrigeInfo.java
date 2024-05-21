package still88.backend.dto.share;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ShareRefrigeInfo {
    private Long shareId;
    private String userNickname;
    private String refrigeName;
    private boolean status;
}
