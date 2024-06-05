package still88.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = SecurityAutoConfiguration.class)
public class BackendApplication {
	String url = "jdbc:mysql://localhost:3306/still88?&useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&serverTimezone=UTC";

	public static void main(String[] args) {
		SpringApplication.run(BackendApplication.class, args);
	}

}
