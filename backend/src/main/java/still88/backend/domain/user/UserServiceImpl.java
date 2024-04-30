package still88.backend.domain.user;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.user.UserRequestDto;
import still88.backend.dto.user.UserResponseDto;
import still88.backend.entity.User;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    public UserResponseDto createUser(UserRequestDto userRequestDto) {
        User user = userRepository.save(User.builder()
                .userNickname(userRequestDto.getUserNickname())
                .userAge(userRequestDto.getUserAge())
                .userGender(userRequestDto.getUserGender())
                .userImage(userRequestDto.getUserImage())
                .userAllergy(userRequestDto.getUserAllergy())
                .userFavorite(userRequestDto.getUserFavorite())
                .build());
        return UserResponseDto.builder()
                .userId(user.getUserId())
                .build();
    }
}
