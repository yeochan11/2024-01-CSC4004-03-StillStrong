package still88.backend.domain.share.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import still88.backend.dto.share.*;
import still88.backend.entity.RefrigeList;
import still88.backend.entity.ShareRefrige;
import still88.backend.entity.User;
import still88.backend.repository.RefrigeListRepository;
import still88.backend.repository.ShareRefrigeRepository;
import still88.backend.repository.UserRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
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

    public void shareStatusUpdate(int refrigeId, AcceptRequestDto acceptRequestDto) {
        int requestUserId = acceptRequestDto.getRequestUserId();
        boolean accept = acceptRequestDto.isAccept();

        Optional<RefrigeList> refrigeList = refrigeListRepository.findById((long) refrigeId);
        Optional<User> requestUser = userRepository.findById((long) requestUserId);
        if (refrigeList.isPresent() && requestUser.isPresent()) {
            Optional<ShareRefrige> shareRefrige = shareRefrigeRepository.findByRequestUserIdAndRefrigeList(requestUser.get(), refrigeList.get());

            if (shareRefrige.isPresent()) {
                ShareRefrige shareRequest = shareRefrige.get();
                if (accept) {
                    shareRequest.updateStatus(true);
                } else {
                    shareRefrigeRepository.delete(shareRequest);
                }
            } else {
                throw new IllegalArgumentException("해당 요청이 존재하지 않습니다.");
            }
        } else {
            throw new IllegalArgumentException("올바르지 않은 응답입니다.");
        }
    }

    public GetShareListResponseDto getShareList(int userId) {
        Optional<User> user = userRepository.findById((long) userId);
        if (user.isEmpty()) {
            throw new IllegalArgumentException("유효하지 않은 사용자입니다.");
        }
        String userNickname = user.get().getUserNickname();

        List<ShareRefrigeInfo> pendingRequests = shareRefrigeRepository.findByCreateUserIdAndStatus(user.get(), false)
                .stream()
                .map(shareRefrige -> ShareRefrigeInfo.builder()
                        .refrigeId(shareRefrige.getRefrigeList().getRefrigeId())
                        .createUserNickname(shareRefrige.getCreateUserId().getUserNickname())
                        .requestUserNickname(shareRefrige.getRequestUserId().getUserNickname())
                        .refrigeName(shareRefrige.getRefrigeList().getRefrigeName())
                        .status(shareRefrige.isStatus())
                        .build())
                .collect(Collectors.toList());
        log.info("pending request");

        List<ShareRefrigeInfo> receivedRequests = shareRefrigeRepository.findByRequestUserIdAndStatus(Optional.of(user.get()), false)
                .stream()
                .map(shareRefrige -> ShareRefrigeInfo.builder()
                        .refrigeId(shareRefrige.getRefrigeList().getRefrigeId())
                        .createUserNickname(shareRefrige.getCreateUserId().getUserNickname())
                        .requestUserNickname(shareRefrige.getRequestUserId().getUserNickname())
                        .refrigeName(shareRefrige.getRefrigeList().getRefrigeName())
                        .status(shareRefrige.isStatus())
                        .build())
                .collect(Collectors.toList());
        log.info("received request");

        List<ShareRefrigeInfo> acceptedRequests = shareRefrigeRepository.findByCreateUserIdAndStatusOrRequestUserIdAndStatus(user.get(), true, user.get(), true)
                .stream()
                .map(shareRefrige -> ShareRefrigeInfo.builder()
                        .refrigeId(shareRefrige.getRefrigeList().getRefrigeId())
                        // create와 request 중 현재 로그인한 사용자의 닉네임과 다른 닉네임 가져오기
                        .createUserNickname(shareRefrige.getCreateUserId().getUserNickname())
                        .requestUserNickname(shareRefrige.getRequestUserId().getUserNickname())
                        .refrigeName(shareRefrige.getRefrigeList().getRefrigeName())
                        .status(shareRefrige.isStatus())
                        .build())
                .collect(Collectors.toList());
        log.info("accepted request");
        return new GetShareListResponseDto(pendingRequests, receivedRequests, acceptedRequests);
    }

    public void cancelShare(int refrigeId, CancelRequestDto cancelRequestDto) {
        Long createUserId = (long) cancelRequestDto.getCreateUserId();
        String requestUserNickname = cancelRequestDto.getRequestUserNickname();

        Optional<User> createUser = userRepository.findById(createUserId);
        Optional<User> requestUser = Optional.ofNullable(userRepository.findUserByUserNickname(requestUserNickname));
        Optional<RefrigeList> refrigeList = refrigeListRepository.findById((long) refrigeId);

        if (createUser.isPresent() && requestUser.isPresent() && refrigeList.isPresent()) {
            Optional<ShareRefrige> shareRefrige = shareRefrigeRepository.findByCreateUserIdAndRequestUserIdAndRefrigeList(createUser.get(), requestUser.get(), refrigeList.get());
            if (shareRefrige.isPresent()) {
                shareRefrigeRepository.delete(shareRefrige.get());
            } else {
                throw new IllegalArgumentException("해당 요청이 존재하지 않습니다.");
            }
        } else {
            throw new IllegalArgumentException("요청 데이터가 없습니다!");
        }
    }

    @Override
    public SearchUserResponseDTO searchUser(int userID, String userName) {
        List<String> refrigeNames = new ArrayList<>();
        List<Integer> refrigeIds = new ArrayList<>();

        User searchedUser = userRepository.findUserByUserNickname(userName);
        User user = userRepository.findUserByUserId(userID);
        List<RefrigeList> userRefrige = refrigeListRepository.findByUser(user);
        log.info("searchedUser = {}", searchedUser);

        if (searchedUser == null)
            return SearchUserResponseDTO.builder()
                    .searchedUserImage(null)
                    .refrigeNames(null)
                    .refrigeIds(null)
                    .build();

        for (RefrigeList refrigeList : userRefrige) {
            refrigeNames.add(refrigeList.getRefrigeName());
            refrigeIds.add((refrigeList.getRefrigeId()));
        }


        return SearchUserResponseDTO.builder()
                .searchedUserImage(searchedUser.getUserImage())
                .refrigeNames(refrigeNames)
                .refrigeIds(refrigeIds)
                .build();
    }
}