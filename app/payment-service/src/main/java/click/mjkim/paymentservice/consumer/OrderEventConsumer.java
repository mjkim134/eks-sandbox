package click.mjkim.paymentservice.consumer;

import click.mjkim.paymentservice.dto.OrderEvent;
import click.mjkim.paymentservice.entity.Payment;
import click.mjkim.paymentservice.repository.PaymentRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
@Slf4j
public class OrderEventConsumer {

    private final PaymentRepository paymentRepository;
    private final ObjectMapper objectMapper;

    @KafkaListener(topics = "order-topic", groupId = "payment-group")
    @Transactional
    public void consumeOrderEvent(String message) {
        try {
            log.info("Kafka Message Received in Payment-Service: {}", message);
            OrderEvent orderEvent = objectMapper.readValue(message, OrderEvent.class);

            // 결제 로직 시뮬레이션 (간단하게 성공으로 처리)
            Payment payment = Payment.builder()
                    .orderId(orderEvent.getOrderId())
                    .amount(orderEvent.getPrice() * orderEvent.getQuantity())
                    .status("SUCCESS")
                    .build();

            paymentRepository.save(payment);
            log.info("Payment Processed and Saved for OrderId: {}", orderEvent.getOrderId());

        } catch (Exception e) {
            log.error("Error processing order event in Payment-Service", e);
        }
    }
}