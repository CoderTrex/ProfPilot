package springboot.profpilot.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;

@Controller
public class MainController {

    @GetMapping("/")
    public String main(Principal principal) {
        if (principal != null) {
            return "redirect:/user/login";
        }
        return "redirect:/main/main_page";
    }

    @GetMapping("/main/main_page")
    public String mainPage(Model model) {
        return "main/main_page";
    }
}
