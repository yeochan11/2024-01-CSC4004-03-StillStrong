package still88.backend.domain.user.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.user.service.UserService;
import still88.backend.dto.user.RegisterAllergyRequestDto;
import still88.backend.dto.user.RegisterFavoriteRequestDto;
import still88.backend.dto.user.UpdateUserDetailRequestDto;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    // 사용자 정보 조회
    @GetMapping("/get/detail/{userId}")
    public ResponseEntity<?> getUserDetail(@PathVariable int userId) {
        return ResponseEntity.ok(userService.getUserDetail(userId));
    }

    // 사용자 정보 수정
    @PatchMapping("/update/{userId}")
    public ResponseEntity<?> updateUserDetail(@PathVariable int userId, @RequestBody UpdateUserDetailRequestDto updateUserDetailRequestDto) {
        return ResponseEntity.ok(userService.updateUserDetail(userId, updateUserDetailRequestDto));
    }

    // 취향 등록
    @PatchMapping("/register/favorite")
    public ResponseEntity<?> registerUserFavorites(@CookieValue int userId, @RequestBody RegisterFavoriteRequestDto registerFavoriteRequestDto) {
        try {
            userService.registerFavorite(userId, registerFavoriteRequestDto);
            return ResponseEntity.ok("취향 등록 완료");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 알러지 등록
    @PatchMapping("/register/allergy")
    public ResponseEntity<?> registerUserAllergies(@CookieValue int userId, @RequestBody RegisterAllergyRequestDto registerAllergyRequestDto) {
        try {
            userService.registerAllergy(userId, registerAllergyRequestDto);
            return ResponseEntity.ok("알러지 등록 완료");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
