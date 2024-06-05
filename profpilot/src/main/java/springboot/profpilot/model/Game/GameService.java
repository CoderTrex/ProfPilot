package springboot.profpilot.model.Game;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import springboot.profpilot.model.DTO.Game.GameAction;
import springboot.profpilot.model.DTO.Game.GameState;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class GameService {
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // 게임 상태를 저장하는 맵 (단순 예시, 실제로는 더 복잡할 수 있음)
    private Map<String, GameState> games = new ConcurrentHashMap<>();

    public GameState startGame(String gameId) {
        GameState gameState = new GameState();
        gameState.setGameId(gameId);
        gameState.setGameStatus("STARTED");
        gameState.setBall_x(0);
        gameState.setBall_y(0);
        gameState.setPlayer1_x(0);
        gameState.setPlayer1_y(0);
        gameState.setPlayer2_x(0);
        gameState.setPlayer2_y(0);
        gameState.setScore1(0);
        gameState.setScore2(0);
        gameState.setTime(0);

        games.put(gameId, gameState);
        return gameState;
    }

    public GameState processAction(GameAction action) {
        GameState gameState = games.get(action.getGameId());
        if (gameState == null) {
            gameState = new GameState();
            games.put(action.getGameId(), gameState);
        }

        // 게임 로직 처리 (예: 플레이어의 이동, 점수 업데이트 등)
        gameState.update(action);

        return gameState;
    }


    @Scheduled(fixedRate = 500) // 0.5초마다 실행 (단위: ms) (1000ms = 1초)
    public void updateGameStates() {
        games.forEach((gameId, gameState) -> {
            gameState.setBall_x(gameState.getBall_x() + 1);
            gameState.setBall_y(gameState.getBall_y() + 1);
            messagingTemplate.convertAndSend("/topic/game/" + gameId, gameState);
        });
    }
}