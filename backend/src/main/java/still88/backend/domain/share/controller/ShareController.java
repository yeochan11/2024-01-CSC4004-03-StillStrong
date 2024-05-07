package still88.backend.domain.share.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import still88.backend.domain.share.service.ShareService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/share")
public class ShareController {

    private final ShareService shareService;


}
