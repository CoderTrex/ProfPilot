package springboot.profpilot.model.DTO.Game;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GameAction {
    private String gameId;
    private String playerId;
    private String actionType;
}