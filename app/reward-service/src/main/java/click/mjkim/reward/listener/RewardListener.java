package click.mjkim.reward.listener;

import click.mjkim.reward.service.RewardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
@Slf4j
public class RewardListener {
    private final RewardService rewardService;

    @KafkaListener(topics = "event-requests", groupId = "reward-group")
    public void handleRequestEvent(String message) {
        log.info("Received Kafka Message: {}", message);
        rewardService.incrementRewardCount();
    }
}
