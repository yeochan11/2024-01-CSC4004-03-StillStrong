package still88.backend.dto.refrige;

import lombok.*;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class GetRefrigeListResponseDto {
    private List<RefrigeInfoDto> refrigeList;
}
