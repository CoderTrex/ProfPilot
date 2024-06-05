package springboot.profpilot.model.DTO.Game;


import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class GameState {
    private String gameId;
    private String gameStatus;

    private int ball_x;
    private int ball_y;
    private int player1_x;
    private int player1_y;
    private int player2_x;
    private int player2_y;
    private int score1;
    private int score2;
    private int time;


    public void update(GameAction action) {
        // 게임 상태 업데이트 로직
    }
}