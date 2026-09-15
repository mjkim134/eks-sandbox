package com.eksdemo.load;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

/**
 * HTTP 요청/응답 계약만 빠르게 확인하는 controller slice test 예제입니다.
 * 실제 웹 서버를 열지 않고 MockMvc로 요청을 보냅니다.
 */
@WebMvcTest(LoadController.class)
class LoadControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("CPU 부하 API는 성공 상태와 결과 메시지를 반환한다")
    void generateCpuLoad_returnsSuccessResponse() throws Exception {
        mockMvc.perform(get("/api/v1/load/cpu"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.status").value("SUCCESS"))
                .andExpect(jsonPath("$.message").value("CPU Load Generated"))
                .andExpect(jsonPath("$.hash").isNotEmpty());
    }
}
