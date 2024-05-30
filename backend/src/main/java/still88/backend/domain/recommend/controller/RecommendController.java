package still88.backend.domain.recommend.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import still88.backend.domain.recommend.service.RecommendService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/123123")
@Slf4j
public class RecommendController {
    private final RecommendService recommendService;

}
