package com.eksdemo;

import io.awspring.cloud.sqs.listener.MessageListenerContainerRegistry;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

@SpringBootTest(properties = {
        "sqs.queue.name=eks-demo-test-queue",
        "spring.cloud.aws.sqs.listener.auto-startup=false"
})
class EksDemoApplicationTests {

    // 전체 컨텍스트 테스트에서도 SQS 리스너가 AWS에 연결하지 않도록 대체한다.
    @MockBean
    private MessageListenerContainerRegistry messageListenerContainerRegistry;

    @Test
    void contextLoads() {
    }

}
