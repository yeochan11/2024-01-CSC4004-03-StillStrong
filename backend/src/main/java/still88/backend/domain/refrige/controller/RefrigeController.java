package still88.backend.domain.refrige.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.refrige.service.RefrigeService;
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

    // 냉장고 목록 조회
    @GetMapping("/get/refrigeList")
    public ResponseEntity<?> getRefrigeList(@CookieValue int userId) {
        return ResponseEntity.ok(refrigeService.getRefrigeList(userId));
    }

    // 냉장고 안 재료 조회
    @GetMapping("/get/{refrigeId}")
    public ResponseEntity<?> getRefrigeIngredient(@PathVariable int refrigeId) {
        return ResponseEntity.ok(refrigeService.getRefrigeIngredient(refrigeId));
    }
}
