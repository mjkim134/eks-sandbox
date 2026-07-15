package com.eksdemo.sqs;

import io.awspring.cloud.sqs.annotation.SqsListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class SqsConsumerWorker {
    private static final Logger logger = LoggerFactory.getLogger(SqsConsumerWorker.class);

    @SqsListener("${sqs.queue.name}")
    public void consumeMessage(String message) {
        logger.info("Received message from SQS: {}", message);
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        logger.info("Finished processing message: {}", message);
    }
}