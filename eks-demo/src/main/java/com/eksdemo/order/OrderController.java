package com.eksdemo.order;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/order")
public class OrderController {
    private static final Logger logger = LoggerFactory.getLogger(OrderController.class);
    
    private final SqsTemplate sqsTemplate;
    
    @Value("${sqs.queue.name}")
    private String queueName;

    public OrderController(SqsTemplate sqsTemplate) {
        this.sqsTemplate = sqsTemplate;
    }

    @PostMapping
    @ResponseStatus(HttpStatus.ACCEPTED)
    public Map<String, String> createOrder() {
        String orderId = UUID.randomUUID().toString();
        
        sqsTemplate.send(queueName, "Order Created: " + orderId);
        logger.info("Sent order to SQS: {}", orderId);
        
        Map<String, String> response = new HashMap<>();
        response.put("status", "ACCEPTED");
        response.put("orderId", orderId);
        response.put("message", "Order successfully pushed to SQS");
        return response;
    }
}