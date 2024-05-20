package still88.backend.domain.user.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.GetRefrigeListResponseDto;
import still88.backend.dto.refrige.RefrigeInfoDto;
import still88.backend.dto.user.GetUserDetailResponseDto;
import still88.backend.dto.user.RegisterFavoriteRequestDto;
import still88.backend.dto.user.UpdateUserDetailRequestDto;
import still88.backend.entity.IdPassword;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;
import still88.backend.repository.IdPasswordRepository;
import still88.backend.repository.UserRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final IdPasswordRepository idPasswordRepository;
    private final ObjectMapper objectMapper = new ObjectMapper();

    public GetUserDetailResponseDto getUserDetail(int userId) {
        User user = userRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        IdPassword idPassword = idPasswordRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        return GetUserDetailResponseDto.builder()
                .userId(String.valueOf(user.getUserId()))
                .userNickname(user.getUserNickname())
                .userGender(user.getUserGender())
                .userAge(user.getUserAge())
                .alarm(user.getAlarm())
                .userImage(user.getUserImage())
                .secretEmail(idPassword.getSecretEmail())
                .build();
    }

    public GetUserDetailResponseDto updateUserDetail(int userId, UpdateUserDetailRequestDto updateUserDetailRequestDto) {
        User user = userRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        IdPassword idPassword = idPasswordRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        user.updateInfo(updateUserDetailRequestDto.getUserNickname(),
                updateUserDetailRequestDto.getUserAge(),
                updateUserDetailRequestDto.getUserGender(),
                updateUserDetailRequestDto.getUserImage(),
                updateUserDetailRequestDto.getAlarm());
        idPassword.updateEmail(updateUserDetailRequestDto.getSecretEmail());

        User updatedUser = userRepository.save(user);
        IdPassword updatedIdPassword = idPasswordRepository.save(idPassword);

        return GetUserDetailResponseDto.builder()
                .userId(String.valueOf(updatedUser.getUserId()))
                .userNickname(updatedUser.getUserNickname())
                .userAge(updatedUser.getUserAge())
                .userGender(updatedUser.getUserGender())
                .userImage(updatedUser.getUserImage())
                .alarm(updatedUser.getAlarm())
                .secretEmail(updatedIdPassword.getSecretEmail())
                .build();

    }

    public void registerFavorite(int userId, RegisterFavoriteRequestDto registerFavoriteRequestDto) {
        Optional<User> userO = userRepository.findById((long) userId);
        if (userO.isPresent()) {
            User user = userO.get();
            List<String> favorites = List.of(registerFavoriteRequestDto.getFavorites());

            try {
                String favoritesJson = objectMapper.writeValueAsString(favorites);
                user.registerFavorite(favoritesJson);
                System.out.println(favoritesJson);
                userRepository.save(user);
            } catch (Exception e) {
                throw new RuntimeException("Failed to convert favorites to JSON", e);
            }
        } else {
            throw new IllegalArgumentException("존재하지 않는 사용자입니다!");
        }
    }
}
