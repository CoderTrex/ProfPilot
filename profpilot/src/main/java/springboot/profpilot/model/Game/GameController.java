package springboot.profpilot.model.Game;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import springboot.profpilot.model.DTO.Game.GameAction;
import springboot.profpilot.model.DTO.Game.GameState;

@Controller
public class GameController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private GameService gameService;

    @MessageMapping("/game/action")
    public void handleAction(GameAction action) throws Exception {
        GameState gameState = gameService.processAction(action);
        messagingTemplate.convertAndSend("/topic/game/" + action.getGameId(), gameState);
    }
}