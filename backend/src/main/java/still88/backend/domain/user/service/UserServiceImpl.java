package still88.backend.domain.user.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.refrige.GetRefrigeListResponseDto;
import still88.backend.dto.refrige.RefrigeInfoDto;
import still88.backend.dto.user.GetUserDetailResponseDto;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.User;
import still88.backend.repository.UserRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    public GetUserDetailResponseDto getUserDetail(int userId) {
        User user = userRepository.findById((long) userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + userId));

        return GetUserDetailResponseDto.builder()
                .userId(String.valueOf(user.getUserId()))
                .userNickname(user.getUserNickname())
                .userGender(user.getUserGender())
                .userAge(user.getUserAge())
                .alarm(user.getAlarm())
                .userImage(user.getUserImage())
                .build();
    }
}
