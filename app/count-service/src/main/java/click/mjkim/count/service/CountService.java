package click.mjkim.count.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Slf4j
public class CountService {
    private final StringRedisTemplate redisTemplate;
    private static final String REDIS_KEY = "total_orders_count";

    public void incrementOrderCount() {
        redisTemplate.opsForValue().increment(REDIS_KEY);
        log.info("Order count incremented in Redis");
    }

    public String getTotalCount() {
        String count = redisTemplate.opsForValue().get(REDIS_KEY);
        return count != null ? count : "0";
    }
}
