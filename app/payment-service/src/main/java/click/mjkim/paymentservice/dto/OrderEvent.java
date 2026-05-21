package click.mjkim.paymentservice.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderEvent {
    private Long orderId;
    private String productName;
    private Integer quantity;
    private Long price;
    private String status;
}