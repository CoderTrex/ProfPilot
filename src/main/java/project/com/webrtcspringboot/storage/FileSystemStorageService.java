package project.com.webrtcspringboot.storage;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.Objects;
import java.util.stream.Stream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.web.multipart.MultipartFile;

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
	public void deleteFile(String prof_name, Long flightId, String filename) {
		try {
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name, flightId.toString());
			Path destinationFile = destinationFolder.resolve(Paths.get(filename)).normalize().toAbsolutePath();
			if (Files.exists(destinationFile)) {
				Files.delete(destinationFile);
			}
		}
		catch (IOException e) {
			throw new StorageException("Failed to delete file.", e);
		}
	}

	@Override
	public void store(MultipartFile file, Long id, String prof_name) {
		try {
			if (file.isEmpty()) {
				throw new StorageException("Failed to store empty file.");
			}
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name, id.toString());
//			Path destinationFile = destinationFolder.resolve(Paths.get(Objects.requireNonNull(file.getOriginalFilename())))
//					.normalize().toAbsolutePath();
			Path destinationFile = destinationFolder.resolve(Paths.get(
							new String(Objects.requireNonNull(file.getOriginalFilename()).getBytes(), StandardCharsets.UTF_8)))
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
	public Stream<Path> loadAll2(String prof_name) {
		try {
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name);
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
			if (resource.exists() || resource.isReadable()) {
				return resource;
			}
			else {
				throw new StorageFileNotFoundException("Could not read file: " + filename);
			}
		}
		catch (MalformedURLException e) {
			throw new StorageFileNotFoundException("Could not read file: " + filename, e);
		}
	}


	private Long calculateFolderSize(Path folder) throws IOException {
		final long[] size = {0}; // 배열을 사용하여 내부에서 값을 변경할 수 있도록 함
		Files.walkFileTree(folder, new SimpleFileVisitor<Path>() {
			@Override
			public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
				size[0] += attrs.size(); // 파일 크기를 합산
				return FileVisitResult.CONTINUE;
			}

			@Override
			public FileVisitResult visitFileFailed(Path file, IOException exc) throws IOException {
				// 파일에 접근할 수 없을 때의 예외 처리
				System.err.println("Failed to access file: " + file + " - " + exc);
				return FileVisitResult.CONTINUE;
			}

			@Override
			public FileVisitResult postVisitDirectory(Path dir, IOException exc) throws IOException {
				if (exc != null) {
					// 디렉토리에 접근할 수 없을 때의 예외 처리
					System.err.println("Failed to access directory: " + dir + " - " + exc);
				}
				return FileVisitResult.CONTINUE;
			}
		});
		return size[0]; // 계산된 전체 폴더 크기 반환
	}

	@Override
	public Long sizeStorageByUser(String prof_name) {
		try {
			Path destinationFolder = Paths.get(this.rootLocation.toString(), prof_name);
			return calculateFolderSize(destinationFolder);
		}
		catch (IOException e) {
			throw new StorageException("Failed to read stored files", e);
		}
	}


	@Override
	public void deleteAll() {
		FileSystemUtils.deleteRecursively(rootLocation.toFile());
	}


//	public void delete()
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
