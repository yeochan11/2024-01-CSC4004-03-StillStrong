package still88.backend.domain.user;

import still88.backend.dto.user.UserRequestDto;
import still88.backend.dto.user.UserResponseDto;

public interface UserService {
    public UserResponseDto createUser(UserRequestDto userRequestDto);
}
