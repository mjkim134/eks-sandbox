package click.mjkim.orderservice.service;

import click.mjkim.orderservice.dto.OrderCreateRequest;
import click.mjkim.orderservice.dto.OrderEvent;
import click.mjkim.orderservice.entity.Order;
import click.mjkim.orderservice.producer.OrderEventProducer;
import click.mjkim.orderservice.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderEventProducer orderEventProducer;

    @Transactional
    public Long createOrder(OrderCreateRequest request) {
        // 1. 엔티티 인스턴스 생성 및 초기 상태(PENDING) 부여
        Order order = Order.builder()
                .productName(request.getProductName())
                .quantity(request.getQuantity())
                .price(request.getPrice())
                .status("PENDING")
                .build();

        // 2. MySQL 데이터베이스 영속화 (INSERT 실행 및 PK 할당받음)
        Order savedOrder = orderRepository.save(order);

        // 3. Kafka 전송용 이벤트를 조립 (DB에 저장되어 발급된 실시간 PK id 사용)
        OrderEvent orderEvent = OrderEvent.builder()
                .orderId(savedOrder.getId())
                .productName(savedOrder.getProductName())
                .quantity(savedOrder.getQuantity())
                .price(savedOrder.getPrice())
                .status(savedOrder.getStatus())
                .build();

        // 4. Kafka Producer 컴포넌트를 호출하여 비동기 메시지 큐 전송
        orderEventProducer.sendOrderEvent(orderEvent);

        return savedOrder.getId();
    }
}