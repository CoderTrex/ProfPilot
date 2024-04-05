package com.korea.WebRTC.service;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.validation.BindingResult;

public interface MainService {
    ModelAndView displayMainPage(Long id, String uuid);
    ModelAndView processRoomSelection(String sid, String uuid, BindingResult bindingResult);
    ModelAndView displaySelectedRoom(String sid, String uuid);
    ModelAndView processRoomExit(String sid, String uuid);
    ModelAndView requestRandomRoomNumber(String uuid);
}
