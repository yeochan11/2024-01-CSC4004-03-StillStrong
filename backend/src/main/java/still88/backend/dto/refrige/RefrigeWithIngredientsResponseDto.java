package still88.backend.dto.refrige;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
@AllArgsConstructor
public class RefrigeWithIngredientsResponseDto {
    private List<RefrigeInfoDto> refrigeList;

}
