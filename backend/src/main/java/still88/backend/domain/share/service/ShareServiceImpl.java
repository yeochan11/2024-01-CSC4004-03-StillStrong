package still88.backend.domain.share.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import still88.backend.dto.share.InviteRequestDto;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;
import still88.backend.entity.User;
import still88.backend.repository.RefrigeListRepository;
import still88.backend.repository.ShareRefrigeRepository;
import still88.backend.repository.UserRepository;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ShareServiceImpl implements ShareService {
    private final ShareRefrigeRepository shareRefrigeRepository;
    private final UserRepository userRepository;
    private final RefrigeListRepository refrigeListRepository;

    public void inviteUser(int refrigeId, InviteRequestDto inviteRequestDto) {
        Long createUserId = (long) inviteRequestDto.getCreateUserId();
        String requestUserNickname = inviteRequestDto.getRequestUserNickname();

        Optional<User> createUser = userRepository.findById(createUserId);
        Optional<User> requestUser = Optional.ofNullable(userRepository.findUserByUserNickname(requestUserNickname));
        Optional<RefrigeList> refrigeList = refrigeListRepository.findById((long) refrigeId);

        if (createUser.isPresent() && requestUser.isPresent() && refrigeList.isPresent()) {
            // 중복 요청 방지
            Optional<ShareRefrige> existingRequest = shareRefrigeRepository.findByCreateUserIdAndRequestUserIdAndRefrigeList(createUser.get(), requestUser.get(), refrigeList.get());
            if (existingRequest.isPresent()) {
                throw new IllegalArgumentException("중복 요청입니다!");
            }

            ShareRefrige shareRefrige = ShareRefrige.builder()
                    .createUserId(createUser.get())
                    .requestUserId(requestUser.get())
                    .refrigeList(refrigeList.get())
                    .status(false)
                    .build();
            shareRefrigeRepository.save(shareRefrige);
        } else {
            throw new IllegalArgumentException("요청 데이터가 없습니다!");
        }
    }
}
