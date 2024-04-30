package still88.backend.domain.refrige;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.user.UserRepository;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.refrige.CreateRefrigeResponseDto;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;

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



}
