package project.com.webrtcspringboot.Storage;

import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import project.com.webrtcspringboot.Model.User.UserService;
import project.com.webrtcspringboot.Model.User.Users;

import java.security.Principal;
import java.util.Map;

@RequestMapping("/storage")
@Controller
@RequiredArgsConstructor
public class StorageController {
    private final StorageService storageService;
    private final UserService userService;

    @RequestMapping("/upgrade_plans/{storage_size}/{file_size}")
    public String upgradePlans(@PathVariable long storage_size, @PathVariable long file_size, Model model) {
        model.addAttribute("version", 1);
        model.addAttribute("storage_size", storage_size);
        model.addAttribute("file_size", file_size);
        return "storage/storage_service";
    }

    @RequestMapping("/upgrade")
    public String upgrade(Principal principal, Model model) {
        long storage_size = (this.storageService.sizeStorageByUser(principal.getName()) / (1024 * 1024));
        model.addAttribute("version", 2);
        model.addAttribute("storage_size", storage_size);
        return "storage/storage_service";
    }

    @RequestMapping("/purchase/{version}")
    public String purchase(@PathVariable int version, Model model, Principal principal) {
        model.addAttribute("version", version);
        Users user = this.userService.findByEmail(principal.getName());
        if (version == 1) {
            model.addAttribute("amount", 10000);
            model.addAttribute("orderName", "Storage Service: 20GB");
            model.addAttribute("customerName", principal.getName());
            model.addAttribute("status", "Premium");
            model.addAttribute("user_id", user.getId());
        }
        if (version == 2) {
            model.addAttribute("amount", 20000);
            model.addAttribute("orderName", "Storage Service: 50GB");
            model.addAttribute("customerName", principal.getName());
            model.addAttribute("status", "superPremium");
            model.addAttribute("user_id", user.getId());
        }
        return "toss/checkout";
    }

    @PostMapping("/update")
    public ResponseEntity<String> updateStorage(@RequestBody Map<String, String> requestBody, Principal principal) {
        String userStatus = requestBody.get("user_status");
        try {
            Users user = this.userService.findByEmail(principal.getName());
            if (user != null) {
                user.setStatus(userStatus);
                user.setPurchaseDate(java.time.LocalDate.now().toString());
                this.userService.save(user);
                return ResponseEntity.ok("User status updated successfully");
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (NumberFormatException e) {
            return ResponseEntity.badRequest().body("Invalid user_id format");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred while updating user status");
        }
    }

}
