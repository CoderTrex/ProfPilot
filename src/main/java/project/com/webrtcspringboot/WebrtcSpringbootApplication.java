package project.com.webrtcspringboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import project.com.webrtcspringboot.Storage.StorageProperties;

@SpringBootApplication
@EnableConfigurationProperties(StorageProperties.class)
public class WebrtcSpringbootApplication {

	public static void main(String[] args) {
		SpringApplication.run(WebrtcSpringbootApplication.class, args);
	}

}
