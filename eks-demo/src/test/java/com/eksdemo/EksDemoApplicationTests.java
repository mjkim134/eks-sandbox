package com.eksdemo;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.bean.override.mockito.MockitoBean;

// CI에는 AWS 자격 증명/설정/실제 큐가 없으므로
// region을 고정하고 SQS 자동 구성을 끄며 SqsTemplate은 mock으로 대체
@SpringBootTest(properties = {
        "spring.cloud.aws.region.static=ap-northeast-2",
        "spring.cloud.aws.sqs.enabled=false",
        "sqs.queue.name=test-queue"
})
class EksDemoApplicationTests {

    @MockitoBean
    SqsTemplate sqsTemplate;

    @Test
    void contextLoads() {
    }

}
