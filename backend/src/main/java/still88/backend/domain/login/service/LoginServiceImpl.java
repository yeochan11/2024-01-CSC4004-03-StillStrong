package still88.backend.domain.login.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import still88.backend.dto.IdPassword.*;
import still88.backend.entity.IdPassword;
import still88.backend.entity.User;
import still88.backend.repository.IdPasswordRepository;
import still88.backend.repository.UserRepository;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Service
@Slf4j
@RequiredArgsConstructor
public class LoginServiceImpl implements LoginService{
    private final UserRepository userRepository;
    private final IdPasswordRepository idPasswordRepository;

    @Override
    public LoginSucessResponseDTO login(String email, String password) {
        User user = idPasswordRepository.findIdUserBySecretEmail(email);
        if(user == null)
            throw new IllegalArgumentException("유효한 이메일이 아닙니다.");

        IdPassword matchedUser = idPasswordRepository.findIdPasswordByUser(user);
        if(matchedUser == null)
            throw new IllegalArgumentException("유효한 이메일이 아닙니다.");

        String enc_password = toSHA256(password);

        if(enc_password.equals(matchedUser.getSecretPassword())) {
            return new LoginSucessResponseDTO(user.getUserId());
        }

        throw new IllegalArgumentException("비밀번호가 틀립니다.");
    }

    @Override
    public JoinResponseDTO join(JoinInfoRequestDTO request) {
        Boolean gender = request.getGender();
        int userAge = request.getUserAge();
        String userNickname = request.getUserNickname();
        String secretEmail = request.getSecretEmail();
        String secretPassword = toSHA256(request.getSecretPassword());

        IdPassword checkDuplicate = idPasswordRepository.findIdPasswordBySecretEmail(secretEmail);
        if(checkDuplicate != null){
            throw new IllegalArgumentException("중복된 이메일입니다.");
        }

        User user = User.builder().userAge(userAge).userGender(gender).userNickname(userNickname).build();
        IdPassword idPassword = IdPassword.builder().user(user)
                .secretEmail(secretEmail).secretPassword(secretPassword).build();

        userRepository.save(user);
        idPasswordRepository.save(idPassword);
        return new JoinResponseDTO(user.getUserId(), user.getUserNickname());
    }

    @Override
    public LogoutResponseDTO logout(String userId) {
        User user = userRepository.findUserByUserId(Integer.parseInt(userId));
        if(user == null)
            throw new IllegalArgumentException("사용자 인식 불가");

        Cookie cookie = new Cookie("userId", null);
        cookie.setMaxAge(0);
        return new LogoutResponseDTO(user.getUserNickname(), cookie);
    }

    @Override
    public Cookie findPasswordValidate(FindPasswordRequestDTO request) {
        User user = userRepository.findUserByUserNickname(request.getUserNickname());
        if(user == null)
            throw new IllegalArgumentException("해당 닉네임을 가진 사용자가 없습니다.");

        IdPassword idPassword = idPasswordRepository.findIdPasswordBySecretEmailAndUser(request.getSecretEmail(), user);

        if(idPassword == null)
            throw new IllegalArgumentException("이메일과 닉네임이 매칭되는 사용자가 없습니다");

        Cookie cookie = new Cookie("userId", Integer.toString(user.getUserId()));
        cookie.setMaxAge(3600);
        return cookie;
    }

    @Override
    public void updatePassword(UpdatePasswordRequestDTO request, String userId) {
        if(!request.getUpdatePassword().equals(request.getConfirmPassword()))
            throw new IllegalArgumentException("재비밀번호가 일치하지 않습니다");

        User user = userRepository.findUserByUserId(Integer.parseInt(userId));
        IdPassword idPassword = idPasswordRepository.findIdPasswordByUser(user);
        idPassword.updateSecretPassword(toSHA256(request.getUpdatePassword()));
        idPasswordRepository.save(idPassword);
    }

    private String toSHA256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuilder hexString = new StringBuilder();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch(NoSuchAlgorithmException | UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

}
