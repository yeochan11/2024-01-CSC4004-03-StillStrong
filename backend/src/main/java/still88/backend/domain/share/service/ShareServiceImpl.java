package still88.backend.domain.share.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import still88.backend.dto.share.AcceptRequestDto;
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
@Transactional
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

    public void acceptShare(int refrigeId, AcceptRequestDto acceptRequestDto) {
        int requestUserId = acceptRequestDto.getRequestUserId();
        boolean accept = acceptRequestDto.isAccept();

        Optional<RefrigeList> refrigeList = refrigeListRepository.findById((long) refrigeId);
        Optional<User> requestUser = userRepository.findById((long) requestUserId);
        if (refrigeList.isPresent() && requestUser.isPresent()) {
            Optional<ShareRefrige> shareRefrige = shareRefrigeRepository.findByRequestUserIdAndRefrigeList(requestUser.get(), refrigeList.get());

            if (shareRefrige.isPresent()) {
                ShareRefrige shareRequest = shareRefrige.get();
                if (accept) {
                    // 요청 수락
                    shareRequest.updateStatus(true);
                } else {
                    // 요청 거절
                    shareRefrigeRepository.delete(shareRequest);
                }
            } else {
                throw new IllegalArgumentException("해당 요청이 존재하지 않습니다.");
            }
        } else {
            throw new IllegalArgumentException("올바르지 않은 응답입니다.");
        }
    }
}