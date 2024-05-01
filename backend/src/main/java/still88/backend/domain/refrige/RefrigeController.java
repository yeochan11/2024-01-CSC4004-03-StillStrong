package still88.backend.domain.refrige;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.UpdateRefrigeRequestDto;

@Controller
@RequiredArgsConstructor
@RequestMapping("/refrige")
public class RefrigeController {

    private final RefrigeService refrigeService;

    // 냉장고 생성하기
    @PostMapping("/create")
    public ResponseEntity<?> createRefrige(@CookieValue String userId, @RequestBody CreateRefrigeRequestDto createRefrigeRequestDto) {
        return ResponseEntity.ok(refrigeService.createRefrige(userId, createRefrigeRequestDto));
    }

    // 냉장고 수정하기
    @PatchMapping("/update/{refrigeId}")
    public ResponseEntity<?> updateRefrige(@PathVariable int refrigeId, @RequestBody UpdateRefrigeRequestDto updateRefrigeRequestDto) {
        return ResponseEntity.ok(refrigeService.updateRefrige(refrigeId, updateRefrigeRequestDto));
    }
}
