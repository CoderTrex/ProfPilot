package springboot.profpilot.model.Chatting;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

@Controller
@RequiredArgsConstructor
public class MessageController {
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/message")
    public void greeting(Message message) throws Exception {
        Thread.sleep(30); // simulated delay
        messagingTemplate.convertAndSend("/topic/message/" + message.getChattingId(), message);
    }
}