package click.mjkim.apigatewayservice.filter;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@Slf4j
public class GlobalLoggingFilter extends AbstractGatewayFilterFactory<GlobalLoggingFilter.Config> {

    public GlobalLoggingFilter() {
        super(Config.class);
    }

    @Data
    public static class Config {
        private String baseMessage;
        private boolean preLogger;
        private boolean postLogger;
    }

    @Override
    public GatewayFilter apply(Config config) {
        return (exchange, chain) -> {
            // Pre Filter: 요청이 들어올 때 실행
            if (config.isPreLogger()) {
                log.info("Global Filter Start: request id -> {}", exchange.getRequest().getId());
                log.info("Global Filter Start: request uri -> {}", exchange.getRequest().getURI());
            }

            // Post Filter: 응답이 나갈 때 실행
            return chain.filter(exchange).then(Mono.fromRunnable(() -> {
                if (config.isPostLogger()) {
                    log.info("Global Filter End: response code -> {}", exchange.getResponse().getStatusCode());
                }
            }));
        };
    }
}