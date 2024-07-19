package springboot.profpilot.model.DTO.Game;


import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class GameState {
    private String gameId;
    private String gameStatus;

    private double direction_x;
    private double direction_y;
    private double ball_x;
    private double ball_y;


    private double player1_x;
    private double player1_y;
    private double player2_x;
    private double player2_y;


    private int score1;
    private int score2;
    private int time;


    public void update(GameAction action) {
        // 게임 상태 업데이트 로직
    }
}