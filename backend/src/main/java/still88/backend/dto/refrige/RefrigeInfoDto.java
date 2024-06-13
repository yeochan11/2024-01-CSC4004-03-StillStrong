package still88.backend.dto.refrige;

import lombok.*;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class RefrigeInfoDto {
    private int refrigeId;
    private String refrigeName;
    private boolean share;
    private List<String> ingredientNames;
    private List<Integer> ingredientDeadlines;
}
