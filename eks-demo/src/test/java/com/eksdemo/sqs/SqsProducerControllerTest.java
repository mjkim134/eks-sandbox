package com.eksdemo.sqs;

import io.awspring.cloud.sqs.operations.SqsTemplate;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.ArgumentMatchers.startsWith;
import static org.mockito.Mockito.verify;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * 외부 AWS에 연결하지 않고 SqsTemplate을 mock으로 대체한 controller test 예제입니다.
 */
@WebMvcTest(value = SqsProducerController.class, properties = "sqs.queue.name=eks-demo-test-queue")
class SqsProducerControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private SqsTemplate sqsTemplate;

    @Test
    @DisplayName("메시지 발행 요청은 SQS 전송 후 202 Accepted를 반환한다")
    void publishMessage_sendsMessageToConfiguredQueue() throws Exception {
        mockMvc.perform(post("/api/v1/sqs/publish"))
                .andExpect(status().isAccepted())
                .andExpect(jsonPath("$.status").value("ACCEPTED"))
                .andExpect(jsonPath("$.messageId").isNotEmpty())
                .andExpect(jsonPath("$.message").value("Dummy message successfully pushed to SQS"));

        verify(sqsTemplate).send(
                eq("eks-demo-test-queue"),
                startsWith("Dummy Message: ")
        );
    }
}
