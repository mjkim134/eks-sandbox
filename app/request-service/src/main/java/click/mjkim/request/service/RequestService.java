package click.mjkim.request.service;

import click.mjkim.request.entity.RequestEntity;
import click.mjkim.request.repository.RequestRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
@Slf4j
public class RequestService {
    private final RequestRepository requestRepository;
    private final KafkaTemplate<String, String> kafkaTemplate;

    @Transactional
    public void submitRequest() {
        // 1. Save to Database
        RequestEntity request = RequestEntity.builder()
                .requestTime(LocalDateTime.now())
                .build();
        requestRepository.save(request);
        log.info("Event Request saved to MySQL with ID: {}", request.getId());

        // 2. Publish Event to Kafka
        kafkaTemplate.send("event-requests", "NEW_REQUEST_ID:" + request.getId());
        log.info("Event Request sent to Kafka for ID: {}", request.getId());
    }
}
