//package springboot.profpilot.model.chat;


//import lombok.extern.slf4j.Slf4j;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.messaging.handler.annotation.MessageMapping;
//import org.springframework.messaging.handler.annotation.Payload;
//import org.springframework.messaging.handler.annotation.SendTo;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.CrossOrigin;

//@CrossOrigin(origins = "*")
//@Controller
//@Slf4j
//public class ChatController {
//
//    @MessageMapping("/gifts")
//    @SendTo("/topic/messages")
//    public ChatMessageModel send(@Payload ChatMessageModel chatMessageModel) {
//        log.info("Message: " + chatMessageModel.getContent());
//        return chatMessageModel;
//    }
//}
