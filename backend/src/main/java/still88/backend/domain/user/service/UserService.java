package still88.backend.domain.user.service;

import still88.backend.dto.user.GetUserDetailResponseDto;
import still88.backend.dto.user.RegisterFavoriteRequestDto;
import still88.backend.dto.user.UpdateUserDetailRequestDto;

public interface UserService {
    GetUserDetailResponseDto getUserDetail(int userId);

    GetUserDetailResponseDto updateUserDetail(int userId, UpdateUserDetailRequestDto updateUserDetailRequestDto);

    void registerFavorite(int userId, RegisterFavoriteRequestDto registerFavoriteRequestDto);
}
