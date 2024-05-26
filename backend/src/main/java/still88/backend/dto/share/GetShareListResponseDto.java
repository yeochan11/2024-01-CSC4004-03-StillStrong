package still88.backend.dto.share;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@AllArgsConstructor
@Builder
public class GetShareListResponseDto {
    private List<ShareRefrigeInfo> pendingRequests;
    private List<ShareRefrigeInfo> receivedRequests;
    private List<ShareRefrigeInfo> acceptedRequests;
}
