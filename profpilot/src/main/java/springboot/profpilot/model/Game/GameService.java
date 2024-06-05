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
    private long lastUpdateTime = System.currentTimeMillis();

    // 게임 상태를 저장하는 맵 (단순 예시, 실제로는 더 복잡할 수 있음)
    private Map<String, GameState> games = new ConcurrentHashMap<>();

    public GameState startGame(String gameId) {
        GameState gameState = new GameState();
        gameState.setGameId(gameId);
        gameState.setGameStatus("STARTED");

        gameState.setDirection_x(0.5f);
        gameState.setDirection_y(0.5f);

        gameState.setBall_x(1);
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

    public GameState getGameState(String gameId) {
        return games.get(gameId);
    }

    public GameState updateGameState(String gameId, GameState gameState, double deltaTime) {
        double direction_x = gameState.getDirection_x();
        double direction_y = gameState.getDirection_y();
        double ball_x = gameState.getBall_x();
        double ball_y = gameState.getBall_y();
        double leftover_x = 0, leftover_y = 0;

        // 1. 정규화
        double magnitude = Math.sqrt(direction_x * direction_x + direction_y * direction_y);
        if (magnitude != 0) {
            direction_x = direction_x / magnitude;
            direction_y = direction_y / magnitude;
        }
        gameState.setDirection_x(direction_x);
        gameState.setDirection_y(direction_y);

        // 2. 공 이동 [deltaTime 을 곱하는 이유: deltaTime 만큼 이동해야 1초에 5의 속도로 이동함]
        ball_x += direction_x * deltaTime * 5;
        ball_y += direction_y * deltaTime * 5;

        if (ball_x < 0 ) {
            leftover_x = 0 - ball_x;
            ball_x = 0;
        }
        if (ball_x > 10) {
            leftover_x = 10 - ball_x;
            ball_x = 10;
        }
        if (ball_y < 0 ) {
            leftover_y = 0 - ball_y;
            ball_y = 0;
        }
        if (ball_y > 10) {
            leftover_y = 10 - ball_y;
            ball_y = 10;
        }

        if (ball_x <= 0 || ball_x >= 10) {
            direction_x = -direction_x;
            if (leftover_x != 0) {
                ball_x += direction_x * deltaTime * 5;
            }
            gameState.setDirection_x(direction_x);
        } else if (ball_y <= 0 || ball_y >= 10) {
            direction_y = -direction_y;
            if (leftover_y != 0) {
                ball_y += direction_y * deltaTime * 5;
            }
            gameState.setDirection_y(direction_y);
        }

        gameState.setBall_x(ball_x);
        gameState.setBall_y(ball_y);
        return gameState;
    }

    @Scheduled(fixedRate = 16) // 약 60 FPS (16ms)
    public void updateGameStates() {
        long currentTime = System.currentTimeMillis();
        double deltaTime = (currentTime - lastUpdateTime) / 1000.0; // 초 단위로 변환
        lastUpdateTime = currentTime;

        games.forEach((gameId, gameState) -> {
            // 게임 상태 업데이트 로직
            gameState = updateGameState(gameId, gameState, deltaTime);
            messagingTemplate.convertAndSend("/topic/game/" + gameId, gameState);
        });
    }
}