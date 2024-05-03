package still88.backend.domain.user.service;

import still88.backend.dto.user.GetUserDetailResponseDto;

public interface UserService {
    public GetUserDetailResponseDto getUserDetail(int userId);
}
