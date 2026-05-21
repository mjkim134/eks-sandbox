package click.mjkim.orderservice.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderCreateRequest {
    private String productName;
    private Integer quantity;
    private Long price;
}