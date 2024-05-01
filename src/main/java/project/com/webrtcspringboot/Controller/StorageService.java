package project.com.webrtcspringboot.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import retrofit2.http.Path;

@RequestMapping("/storage")
@Controller
public class StorageService {
    @RequestMapping("/upgrade_plans/{size}")
    public String upgradePlans(@PathVariable Long size, Model model) {
        model.addAttribute("size", size);
        return "toss/storage_service";
    }

}
