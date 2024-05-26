package still88.backend.domain.share.service;

import still88.backend.dto.share.AcceptRequestDto;
import still88.backend.dto.share.CancelRequestDto;
import still88.backend.dto.share.GetShareListResponseDto;
import still88.backend.dto.share.InviteRequestDto;

public interface ShareService {
    void inviteUser(int refrigeId, InviteRequestDto inviteRequestDto);

    void shareStatusUpdate(int refrigeId, AcceptRequestDto acceptRequestDto);

    GetShareListResponseDto getShareList(int userId);

    void cancelShare(int refrigeId, CancelRequestDto cancelRequestDto);
}
