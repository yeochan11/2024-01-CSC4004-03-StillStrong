package still88.backend.domain.login.controller;

import jakarta.servlet.http.Cookie;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.login.service.LoginService;
import still88.backend.dto.IdPassword.*;

@RestController
@Slf4j
@RequiredArgsConstructor
public class LoginController {
    private final LoginService loginService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginInfoRequestDTO loginInfoRequestDTO)
    {
        try {
            LoginSucessResponseDTO response = loginService.login(loginInfoRequestDTO.getSecretEmail(),
                    loginInfoRequestDTO.getSecretPassword());
            Cookie cookie = new Cookie("userId", response.getCookieValue());
            return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString()).body(response);
        }catch (Exception e)
        {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/join")
    public ResponseEntity<?> join(@RequestBody JoinInfoRequestDTO request){
        try{
            JoinResponseDTO response = loginService.join(request);
            Cookie cookie = new Cookie("userId", response.getCookieValue());
            return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString()).body(response);
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/logout")
    public ResponseEntity<?> logout(@CookieValue String userId){
        try {
            LogoutResponseDTO response = loginService.logout(userId);
            return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, response.getCookie().toString()).body(response.getUserNickname() + "님 안녕히 가세요!");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/find-pw")
    public ResponseEntity<?> find_pw(@RequestBody FindPasswordRequestDTO request){
        try {
            Cookie cookie = loginService.findPasswordValidate(request);
            log.info("cookie value = {}", cookie.getValue());
            return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString()).body("비밀번호 수정으로 이동합니다");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/update-pw")
    public ResponseEntity<?> update_pw(@RequestBody UpdatePasswordRequestDTO request,
                                       @CookieValue String userId){
        try {
            loginService.updatePassword(request, userId);
            return ResponseEntity.ok("비밀번호 업데이트 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
