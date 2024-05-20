package still88.backend.domain.share.service;

import still88.backend.dto.share.InviteRequestDto;

public interface ShareService {
    void inviteUser(int refrigeId, InviteRequestDto inviteRequestDto);
}
