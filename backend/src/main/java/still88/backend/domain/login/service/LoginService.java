package still88.backend.domain.login.service;

import jakarta.servlet.http.Cookie;
import still88.backend.dto.IdPassword.*;
import still88.backend.entity.User;

public interface LoginService {
    LoginSucessResponseDTO login(String email, String password);
    JoinResponseDTO join(JoinInfoRequestDTO request);

    LogoutResponseDTO logout(String userId);

    Cookie findPasswordValidate(FindPasswordRequestDTO request);

    void updatePassword(UpdatePasswordRequestDTO request, String userId);
}
