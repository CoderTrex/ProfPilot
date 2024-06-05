package springboot.profpilot.model.Chatting;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import springboot.profpilot.model.DTO.Game.GameState;
import springboot.profpilot.model.Game.GameService;

@Controller
@RequiredArgsConstructor
public class MessageController {
    private final GameService gameService;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/message")
    public void greeting(Message message) throws Exception {
        Thread.sleep(30); // simulated delay
        if (message.getContent().equals("GAME")) {
            GameState gameState = gameService.startGame(message.getChattingId());
            messagingTemplate.convertAndSend("/topic/game/" + message.getChattingId(), gameState);
        }
        messagingTemplate.convertAndSend("/topic/message/" + message.getChattingId(), message);
    }
}