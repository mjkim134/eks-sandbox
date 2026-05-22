package click.mjkim.order.service;

import click.mjkim.order.entity.OrderEntity;
import click.mjkim.order.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderService {
    private final OrderRepository orderRepository;
    private final KafkaTemplate<String, String> kafkaTemplate;

    @Transactional
    public void placeOrder() {
        // 1. Save to Database
        OrderEntity order = OrderEntity.builder()
                .orderTime(LocalDateTime.now())
                .build();
        orderRepository.save(order);
        log.info("Order saved to MySQL with ID: {}", order.getId());

        // 2. Publish Event to Kafka
        kafkaTemplate.send("order-events", "NEW_ORDER_ID:" + order.getId());
        log.info("Order event sent to Kafka for ID: {}", order.getId());
    }
}
