package still88.backend.domain.recommend.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import still88.backend.domain.recommend.service.RecommendService;
import still88.backend.dto.recommend.FeedbackRequestDTO;
import still88.backend.dto.recommend.RecommendRequestDTO;

@Controller
@RequiredArgsConstructor
@Slf4j
public class RecommendController {
    private final RecommendService recommendService;

    @PostMapping("/recommend/recipe/ingredient")
    public ResponseEntity<?> recommend(@RequestBody RecommendRequestDTO dto){
        try{
            return ResponseEntity.ok(recommendService.recommend(dto.getUserId(), dto.getIngredientList()));
        }catch (Exception e){
            log.info("실패");
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
    @PostMapping("/recommend/recipe/feedback")
    public ResponseEntity<?> feedback(@RequestBody FeedbackRequestDTO dto){
        try{
            recommendService.feedback(dto);
            log.info("feedback 완료");
            return ResponseEntity.ok("피드백 완료");
        }catch (Exception e){
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
