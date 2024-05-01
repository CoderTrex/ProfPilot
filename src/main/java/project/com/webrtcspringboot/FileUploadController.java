package project.com.webrtcspringboot;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.com.webrtcspringboot.Model.Lecture.Lecture;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.flight.FlightRepository;
import project.com.webrtcspringboot.Model.User.Users;
import project.com.webrtcspringboot.Model.flight.Flight;
import project.com.webrtcspringboot.storage.StorageFileNotFoundException;
import project.com.webrtcspringboot.storage.StorageService;


@RequiredArgsConstructor
@Controller
@RequestMapping("/upload")
public class FileUploadController {

	private final StorageService storageService;
	private final FlightRepository FlightRepository;
	private final UserService userService;

	@GetMapping("/files/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serveFile(@PathVariable String filename, @RequestParam("flightId") Long flightId) {
		Flight flight = FlightRepository.findById(flightId).orElseThrow(() -> new IllegalArgumentException("Invalid flight Id:" + flightId));
		String prof_name = flight.getPilot().getName();
		filename = prof_name + "/" + flightId + "/" + filename;
		Resource file = storageService.loadAsResource(filename);
		if (file == null)
			return ResponseEntity.notFound().build();

		try {
			// 파일 이름을 UTF-8로 인코딩하여 헤더에 설정
			String encodedFilename = URLEncoder.encode(file.getFilename(), "UTF-8").replace("+", "%20");
			return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
					"attachment; filename=\"" + encodedFilename + "\"").body(file);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace(); // 적절한 예외 처리를 해 주세요.
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@PostMapping("/{flightId}")
	public String handleFileUpload(@PathVariable("flightId") Long flightId,
								   @RequestParam("file") MultipartFile file,
								   RedirectAttributes redirectAttributes) {
		Flight flight = FlightRepository.findById(flightId).orElseThrow(() -> new IllegalArgumentException("Invalid flight Id:" + flightId));
		Lecture lecture = flight.getLecture();
		String prof_name = flight.getPilot().getName();
		Users user = userService.findByName(prof_name);
		long size = this.storageService.sizeStorageByUser(user.getName()) / (1024 * 1024);
		long totalSize = size + file.getSize() / (1024 * 1024);
		if (totalSize > 2048) {
			redirectAttributes.addFlashAttribute("message", "You have exceeded the storage limit of 2GB");
			return "redirect:/storage/upgrade_plans/" + size;
		} else {
			storageService.store(file, flightId, prof_name);
			return "redirect:/lecture/enter_flight/professor?id=" + lecture.getId();
		}
	}

//	th:href="@{|/upload/delete/${user.name}/${flight.id}/${file}|}"
	@GetMapping("/delete/{prof_name}/{flightId}/{filename:.+}")
	public String deleteFile(@PathVariable("prof_name") String prof_name,
							 @PathVariable("flightId") Long flightId,
							 @PathVariable("filename") String filename) {
		Flight flight = FlightRepository.findById(flightId).orElseThrow(() -> new IllegalArgumentException("Invalid flight Id:" + flightId));
		Lecture lecture = flight.getLecture();
		storageService.deleteFile(prof_name, flightId, filename);
		return "redirect:/lecture/enter_flight/professor?id=" + lecture.getId();
	}

	@ExceptionHandler(StorageFileNotFoundException.class)
	public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
		return ResponseEntity.notFound().build();
	}

}
