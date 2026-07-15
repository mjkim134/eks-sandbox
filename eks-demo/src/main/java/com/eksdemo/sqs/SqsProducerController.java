package com.eksdemo.sqs;

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
@RequestMapping("/api/v1/sqs")
public class SqsProducerController {
    private static final Logger logger = LoggerFactory.getLogger(SqsProducerController.class);
    
    private final SqsTemplate sqsTemplate;
    
    @Value("${sqs.queue.name}")
    private String queueName;

    public SqsProducerController(SqsTemplate sqsTemplate) {
        this.sqsTemplate = sqsTemplate;
    }

    @PostMapping("/publish")
    @ResponseStatus(HttpStatus.ACCEPTED)
    public Map<String, String> publishMessage() {
        String messageId = UUID.randomUUID().toString();
        
        sqsTemplate.send(queueName, "Dummy Message: " + messageId);
        logger.info("Sent dummy message to SQS: {}", messageId);
        
        Map<String, String> response = new HashMap<>();
        response.put("status", "ACCEPTED");
        response.put("messageId", messageId);
        response.put("message", "Dummy message successfully pushed to SQS");
        return response;
    }
}