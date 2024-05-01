package still88.backend.domain.user.service;

import still88.backend.dto.user.UserRequestDto;
import still88.backend.dto.user.UserResponseDto;

public interface UserService {
    public UserResponseDto createUser(UserRequestDto userRequestDto);
}
