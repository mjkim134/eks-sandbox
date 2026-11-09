package com.eksdemo;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

// CI에는 AWS 자격 증명/실제 큐가 없으므로 SQS 자동 구성을 끄고 SqsTemplate은 mock으로 대체
@SpringBootTest(properties = {
        "spring.cloud.aws.sqs.enabled=false",
        "sqs.queue.name=test-queue"
})
class EksDemoApplicationTests {

    @MockBean
    SqsTemplate sqsTemplate;

    @Test
    void contextLoads() {
    }

}
