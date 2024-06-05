package still88.backend;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")  // 모든 도메인 허용(보안상 주의 필요)
                .allowedMethods("GET", "POST", "PUT", "DELETE", "PATCH")
                .allowedHeaders("*")  // 모든 헤더 허용
                .allowCredentials(true)  // 쿠키와 같은 인증 정보 허용
                .maxAge(3600);  // pre-flight 요청의 결과를 캐시하는 시간
    }
}
