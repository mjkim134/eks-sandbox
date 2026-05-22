package click.mjkim.request.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "event_requests")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor
@Builder
public class RequestEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime requestTime;
}
