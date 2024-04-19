package project.com.webrtcspringboot;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import project.com.webrtcspringboot.storage.StorageProperties;
import project.com.webrtcspringboot.storage.StorageService;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class WebrtcSpringbootApplication {

	public static void main(String[] args) {
		SpringApplication.run(WebrtcSpringbootApplication.class, args);
	}

}
