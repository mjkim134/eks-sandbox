package click.mjkim.count.listener;

import click.mjkim.count.service.CountService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class CountListener {
    private final CountService countService;

    @KafkaListener(topics = "order-events", groupId = "count-group")
    public void handleOrderEvent(String message) {
        log.info("Received Kafka Message: {}", message);
        countService.incrementOrderCount();
    }
}
