package project.com.webrtcspringboot.storage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;
import project.com.webrtcspringboot.Model.flight.FlightRepository;

@Service
public class FileSystemStorageService implements StorageService {

	private final Path rootLocation;

	@Autowired
	public FileSystemStorageService(StorageProperties properties) {
        
        if(properties.getLocation().trim().isEmpty()){
            throw new StorageException("File upload location can not be Empty."); 
        }

		this.rootLocation = Paths.get(properties.getLocation());
	}

	@Override
	public void store(MultipartFile file, Long id, String prof_name) {
		try {
			if (file.isEmpty()) {
				throw new StorageException("Failed to store empty file.");
			}
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name, id.toString());
			Path destinationFile = destinationFolder.resolve(Paths.get(Objects.requireNonNull(file.getOriginalFilename())))
					.normalize().toAbsolutePath();
			if (!Files.exists(destinationFile)) {
				Files.createDirectories(destinationFile);
			}
			try (InputStream inputStream = file.getInputStream()) {
				// 매개변수 1. 파일의 InputStream, 2. 저장될 파일의 경로, 3. 파일이 이미 존재할 경우 덮어쓸지 여부
				Files.copy(inputStream, destinationFile, StandardCopyOption.REPLACE_EXISTING);
			}
		}
		catch (IOException e) {
			throw new StorageException("Failed to store file.", e);
		}
	}

	@Override
	public Stream<Path> loadAll(Long id, String prof_name) {
		try {
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name, id.toString());
			if (!Files.exists(destinationFolder)) {
				return Stream.empty();
			}
			return Files.walk(destinationFolder, 1)
					.filter(path -> !path.equals(destinationFolder))
					.map(destinationFolder::relativize);
		}
		catch (IOException e) {
			throw new StorageException("Failed to read stored files", e);
		}

	}

	@Override
	public Path load(String filename) {
		return rootLocation.resolve(filename);
	}

	@Override
	public Resource loadAsResource(String filename) {
		try {
			Path file = load(filename);

			Resource resource = new UrlResource(file.toUri());
			System.out.println("resource: " + resource);
			if (resource.exists() || resource.isReadable()) {
				System.out.println("resource: 222" + resource);
				return resource;
			}
			else {
				throw new StorageFileNotFoundException(
						"Could not read file: " + filename);

			}
		}
		catch (MalformedURLException e) {
			throw new StorageFileNotFoundException("Could not read file: " + filename, e);
		}
	}

	@Override
	public void deleteAll() {
		FileSystemUtils.deleteRecursively(rootLocation.toFile());
	}

	@Override
	public void init() {
		try {
			Files.createDirectories(rootLocation);
		}
		catch (IOException e) {
			throw new StorageException("Could not initialize storage", e);
		}
	}
}
