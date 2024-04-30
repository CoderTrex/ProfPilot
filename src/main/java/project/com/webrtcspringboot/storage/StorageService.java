package project.com.webrtcspringboot.storage;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Path;
import java.util.stream.Stream;

public interface StorageService {

	void init();

	void store(MultipartFile file, Long id, String prof_name);

	Stream<Path> loadAll(Long id, String prof_name);

	Stream<Path> loadAll2(String prof_name);

	Path load(String filename);

	Resource loadAsResource(String filename);

	void deleteAll();

	Long sizeStorageByUser(String prof_name);

//	Stream<Path> loadAllByUser(String prof_name);
}
