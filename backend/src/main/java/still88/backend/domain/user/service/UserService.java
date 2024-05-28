package still88.backend.domain.user.service;

import still88.backend.dto.user.*;

import java.util.List;

public interface UserService {
    GetUserDetailResponseDto getUserDetail(int userId);

    GetUserDetailResponseDto updateUserDetail(int userId, UpdateUserDetailRequestDto updateUserDetailRequestDto);

    void registerFavorite(int userId, RegisterFavoriteRequestDto registerFavoriteRequestDto);

    void registerAllergy(int userId, RegisterAllergyRequestDto registerAllergyRequestDto);

    GetAllergyResponseDto getUserAllergry(int userId);

    GetAllergyListResponseDTO getAllergyList();
}
