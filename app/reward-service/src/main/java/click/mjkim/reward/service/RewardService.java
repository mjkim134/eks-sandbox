package click.mjkim.reward.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class RewardService {
    private final StringRedisTemplate redisTemplate;
    private static final String REDIS_KEY = "total_rewards_count";

    public void incrementRewardCount() {
        redisTemplate.opsForValue().increment(REDIS_KEY);
        log.info("Reward count incremented in Redis");
    }

    public String getTotalCount() {
        String count = redisTemplate.opsForValue().get(REDIS_KEY);
        return count != null ? count : "0";
    }
}
