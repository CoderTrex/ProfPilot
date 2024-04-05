package com.korea.WebRTC.service;


import com.korea.WebRTC.utils.Parser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.ModelAndView;
import java.util.Optional;


@Service
public class MainServicelmpl implements MainService {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    private static final String REDIRECT_TO_ROOT = "redirect:/";

    private final Parser parser;

    public MainServicelmpl(Parser parser) {
        this.parser = parser;
    }


    // Main Page : model and view에는 id, room, uuid를 추가한다.
    @Override
    public ModelAndView displayMainPage(Long id, String uuid) {
        final ModelAndView modelAndView = new ModelAndView("main");
        modelAndView.addObject("id", id);
        modelAndView.addObject("room", null);
        modelAndView.addObject("uuid", uuid);
        return modelAndView;
    }

    @Override
    public ModelAndView processRoomSelection(String sid, String uuid, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            logger.error("Binding Result has errors");
            return new ModelAndView(REDIRECT_TO_ROOT);
        }

        Optional<Long> optionalId = parser.parseId(sid);
//        optionalId.ifPresent(id -> Optional.ofNullable(uuid).ifPresent(
////                name->roomService.addRoom(new Room(id));
//        ));
//        return this.displayMainPage(optionalId.orElse(null), uuid);
        return null;
    }

    @Override
    public ModelAndView displaySelectedRoom(String sid, String uuid) {
        return null;
    }

    @Override
    public ModelAndView processRoomExit(String sid, String uuid) {
        return null;
    }

    @Override
    public ModelAndView requestRandomRoomNumber(String uuid) {
        return null;
    }
}
