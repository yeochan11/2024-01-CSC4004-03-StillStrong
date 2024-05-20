package still88.backend.domain.share.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import still88.backend.domain.share.service.ShareService;
import still88.backend.dto.refrige.CreateRefrigeRequestDto;
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
}
