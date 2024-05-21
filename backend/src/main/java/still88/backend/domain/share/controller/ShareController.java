package still88.backend.domain.share.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.share.service.ShareService;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
import still88.backend.dto.share.AcceptRequestDto;
import still88.backend.dto.share.CancelRequestDto;
import still88.backend.dto.share.GetShareListResponseDto;
import still88.backend.dto.share.InviteRequestDto;

@Controller
@RequiredArgsConstructor
@RequestMapping("/share")
public class ShareController {

    private final ShareService shareService;

    // 냉장고 공유 초대
    @PostMapping("/invite/{refrigeId}")
    public ResponseEntity<?> inviteUser(@PathVariable int refrigeId, @RequestBody InviteRequestDto inviteRequestDto) {
        try{
            shareService.inviteUser(refrigeId, inviteRequestDto);
            return ResponseEntity.ok("초대 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    // 냉장고 공유 수락/거절
    @PatchMapping("/accept/{refrigeId}")
    public ResponseEntity<?> acceptShare(@PathVariable int refrigeId, @RequestBody AcceptRequestDto acceptRequestDto) {
        try{
            shareService.acceptShare(refrigeId, acceptRequestDto);
            return ResponseEntity.ok("수락/거절 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }


    // 냉장고 공유 요청 현황 조회
    @GetMapping("/get/shareList/{userid}")
    public ResponseEntity<?> getShareList(@PathVariable int userid) {
        GetShareListResponseDto getShareListResponseDto = shareService.getShareList(userid);
        return ResponseEntity.ok(getShareListResponseDto);
    }

    // 냉장고 공유 요청 취소
    @DeleteMapping("/cancel/{refrigeId}")
    public ResponseEntity<?> cancelShareRequest(@PathVariable int refrigeId, @RequestBody CancelRequestDto cancelRequestDto) {
        try{
            shareService.cancelShare(refrigeId, cancelRequestDto);
            return ResponseEntity.ok("공유 요청 취소 완료");
        } catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
