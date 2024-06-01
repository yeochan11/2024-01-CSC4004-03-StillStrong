package still88.backend.domain.share.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.share.service.ShareService;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.share.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/share")
@Slf4j
public class ShareController {

    private final ShareService shareService;

    // 냉장고 공유 초대
    @PostMapping("/invite/{refrigeId}")
    public ResponseEntity<?> inviteUser(@PathVariable int refrigeId, @RequestBody InviteRequestDto inviteRequestDto) {
        try{
            shareService.inviteUser(refrigeId, inviteRequestDto);
            log.info("refrigeId = {}로 초대 완료", refrigeId);
            return ResponseEntity.ok("초대 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 냉장고 공유 수락/거절
    @PatchMapping("/accept/{refrigeId}")
    public ResponseEntity<?> shareStatusUpdate(@PathVariable int refrigeId, @RequestBody AcceptRequestDto acceptRequestDto) {
        try{
            shareService.shareStatusUpdate(refrigeId, acceptRequestDto);
            log.info("refrigeId = {}로 수락/거절 완료", refrigeId);
            return ResponseEntity.ok("수락/거절 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 냉장고 공유 요청 현황 조회
    @GetMapping("/get/shareList")
    public ResponseEntity<?> getShareList(@RequestBody int userid) {
        GetShareListResponseDto getShareListResponseDto = shareService.getShareList(userid);
        log.info("refrigeId = {}로 초대 완료");
        return ResponseEntity.ok(getShareListResponseDto);
    }

    @PostMapping("/invite/search")
    public ResponseEntity<?> serachUser(@RequestParam int userId, @RequestBody SearchUserRequestDTO dto){
        try{
            log.info("userId = {} 의 검색 수행", userId);
            return ResponseEntity.ok().body(shareService.searchUser(userId, dto.getSearchName()));
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    // 냉장고 공유 요청 취소
    @DeleteMapping("/cancel/{refrigeId}")
    public ResponseEntity<?> cancelShareRequest(@PathVariable int refrigeId, @RequestBody CancelRequestDto cancelRequestDto) {
        try{
            shareService.cancelShare(refrigeId, cancelRequestDto);
            log.info("refrige = {} 의 냉장고 공유 삭제", refrigeId);
            return ResponseEntity.ok("공유 요청 취소 완료");
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
