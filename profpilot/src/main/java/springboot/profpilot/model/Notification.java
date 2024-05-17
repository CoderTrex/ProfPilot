package springboot.profpilot.model;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;
    private String format;
    private String sendTime;
    private Long senderId;
    private String senderRole;
    private Long receiverId;
    private String receiverRole;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Passenger passenger;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonBackReference
    private Pilot pilot;
}
