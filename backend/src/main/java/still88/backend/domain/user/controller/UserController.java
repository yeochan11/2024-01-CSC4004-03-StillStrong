package still88.backend.domain.user.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.user.service.UserService;
import still88.backend.dto.user.GetAllergyResponseDto;
import still88.backend.dto.user.RegisterAllergyRequestDto;
import still88.backend.dto.user.RegisterFavoriteRequestDto;
import still88.backend.dto.user.UpdateUserDetailRequestDto;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
@Slf4j
public class UserController {

    private final UserService userService;

    @GetMapping("/get/detail")
    public ResponseEntity<?> getUserDetail(@RequestParam int userId) {
        log.info("userId = {}의 회원 정보 조회", userId);
        return ResponseEntity.ok(userService.getUserDetail(userId));
    }

    @PatchMapping("/update")
    public ResponseEntity<?> updateUserDetail(@RequestParam int userId, @RequestBody UpdateUserDetailRequestDto updateUserDetailRequestDto) {
        log.info("userId = {}의 회원 정보 수정", userId);
        return ResponseEntity.ok(userService.updateUserDetail(userId, updateUserDetailRequestDto));
    }

    @PatchMapping("/register/favorite")
    public ResponseEntity<?> registerUserFavorites(@RequestParam int userId, @RequestBody RegisterFavoriteRequestDto registerFavoriteRequestDto) {
        try {
            userService.registerFavorite(userId, registerFavoriteRequestDto);
            return ResponseEntity.ok("취향 등록 완료");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PatchMapping("/register/allergy")
    public ResponseEntity<?> registerUserAllergies(@RequestParam int userId, @RequestBody RegisterAllergyRequestDto registerAllergyRequestDto) {
        try {
            userService.registerAllergy(userId, registerAllergyRequestDto);
            return ResponseEntity.ok("알러지 등록 완료");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/get/allergy")
    public ResponseEntity<?> getUserAllergy(@RequestParam int userId) {
        try {
            GetAllergyResponseDto getAllergyResponseDto = userService.getUserAllergry(userId);
            return ResponseEntity.ok(getAllergyResponseDto);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/get/allergyList")
    public ResponseEntity<?> getAllergy(){
        try{
            return ResponseEntity.ok(userService.getAllergyList());
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
