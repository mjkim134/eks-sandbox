package click.mjkim.orderservice.producer;

import click.mjkim.orderservice.dto.OrderEvent;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class OrderEventProducer {

    private final KafkaTemplate<String, String> kafkaTemplate;
    private final ObjectMapper objectMapper;

    // 타겟 카프카 토픽 이름 정의
    private static final String TOPIC = "order-topic";

    public void sendOrderEvent(OrderEvent event) {
        try {
            // 1. OrderEvent 자바 객체를 JSON 형태의 문자열로 직렬화(Serialization)
            String jsonMessage = objectMapper.writeValueAsString(event);

            // 2. Kafka 브로커로 메시지 전송 (Key: OrderId 문자열, Value: JSON 데이터)
            kafkaTemplate.send(TOPIC, event.getOrderId().toString(), jsonMessage);

            log.info("Kafka로 주문 이벤트 전송 완료 -> Topic: {}, OrderId: {}", TOPIC, event.getOrderId());
        } catch (JsonProcessingException e) {
            log.error("Kafka 메시지 직렬화 에러 발생", e);
            throw new RuntimeException(e);
        }
    }
}