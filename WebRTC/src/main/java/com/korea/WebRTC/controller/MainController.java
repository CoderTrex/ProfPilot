package com.korea.WebRTC.controller;

import com.korea.WebRTC.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@ControllerAdvice
public class MainController {
    private final MainService mainService;

    @Autowired // Authowired는 의존성 주입을 위한 어노테이션
    public MainController(final MainService mainService) {
        this.mainService = mainService;
    }

    @GetMapping({"/", "/index", "/home", "/main"})
    public ModelAndView displayMainPage(Long id, String uuid) {
        return this.mainService.displayMainPage(id, uuid);
    }

    @PostMapping(value = "/room", params = "action=create")
    public ModelAndView processRoomSelection(@ModelAttribute("sid") final String sid,
                                             @PathVariable("uuid") final String uuid,
                                             final BindingResult bindingResult) {
        return this.mainService.processRoomSelection(sid, uuid, bindingResult);
    }

    @GetMapping("/room/{sid}/user/{uuid}")
    public ModelAndView displaySelectedRoom(@PathVariable("sid") final String sid,
                                            @PathVariable("uuid") final String uuid) {
        return this.mainService.displaySelectedRoom(sid, uuid);
    }

    @GetMapping("/room/{sid}/user/{uuid}/exit")
    public ModelAndView processRoomExit(@PathVariable("sid") final String sid,
                                        @PathVariable("uuid") final String uuid) {
        return this.mainService.processRoomExit(sid, uuid);
    }

    @GetMapping("/room/random")
    public ModelAndView requestRandomRoomNumber(@PathVariable("uuid") final String uuid) {
        return this.mainService.requestRandomRoomNumber(uuid);
    }

    @GetMapping("/offer")
    public ModelAndView displayOfferPage() {
        return new ModelAndView("sdp_offer");
    }

    @GetMapping("/stream")
    public ModelAndView displayStreamPage() {
        return new ModelAndView("streaming");
    }
}
