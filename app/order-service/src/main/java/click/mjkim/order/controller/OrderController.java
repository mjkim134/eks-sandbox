package click.mjkim.order.controller;

import click.mjkim.order.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;

    @PostMapping
    public String createOrder() {
        orderService.placeOrder();
        return "Success";
    }
}
