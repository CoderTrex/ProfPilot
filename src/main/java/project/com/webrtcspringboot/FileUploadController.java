package project.com.webrtcspringboot;


import java.io.IOException;
import java.util.stream.Collectors;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@GetMapping("/")
	public String listUploadedFiles(Model model) throws IOException {

//		model.addAttribute("files", storageService.loadAll().map(
//				path -> MvcUriComponentsBuilder.fromMethodName(FileUploadController.class,
//						"serveFile", path.getFileName().toString()).build().toUri().toString())
//				.collect(Collectors.toList()));
		return "uploadForm";
	}

	@GetMapping("/files/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serveFile(@PathVariable String filename, @RequestParam("flightId") Long flightId) {
		Flight flight = FlightRepository.findById(flightId).orElseThrow(() -> new IllegalArgumentException("Invalid flight Id:" + flightId));
		String prof_name = flight.getPilot().getName();
		System.out.println("prof_name: " + prof_name);
		filename = prof_name + "/" + flightId + "/" + filename;
		Resource file = storageService.loadAsResource(filename);
		if (file == null)
			return ResponseEntity.notFound().build();
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"" + file.getFilename() + "\"").body(file);
	}

	@PostMapping("/{flightId}")
	public void handleFileUpload(@PathVariable("flightId") Long flightId,
								   @RequestParam("file") MultipartFile file,
								   RedirectAttributes redirectAttributes) {
		Flight flight = FlightRepository.findById(flightId).orElseThrow(() -> new IllegalArgumentException("Invalid flight Id:" + flightId));
		String prof_name = flight.getPilot().getName();
		storageService.store(file, flightId, prof_name);
	}

	@ExceptionHandler(StorageFileNotFoundException.class)
	public ResponseEntity<?> handleStorageFileNotFound(StorageFileNotFoundException exc) {
		return ResponseEntity.notFound().build();
	}

}
