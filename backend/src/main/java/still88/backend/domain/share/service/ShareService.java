package still88.backend.domain.share.service;

import still88.backend.dto.share.*;

public interface ShareService {
    void inviteUser(int refrigeId, InviteRequestDto inviteRequestDto);

    void shareStatusUpdate(int refrigeId, AcceptRequestDto acceptRequestDto);

    GetShareListResponseDto getShareList(int userId);

    void cancelShare(int refrigeId, CancelRequestDto cancelRequestDto);

    SearchUserResponseDTO searchUser(int userId, String userName);
}
