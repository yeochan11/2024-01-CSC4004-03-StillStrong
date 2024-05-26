package still88.backend.dto.refrige;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CreateUpdateRefrigeResponseDto {
    private int refrigeId;
    private String refrigeName;
}
