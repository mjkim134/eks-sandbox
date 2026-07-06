package com.eksdemo.load;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/load")
public class LoadController {
    private static final Logger logger = LoggerFactory.getLogger(LoadController.class);

    @GetMapping("/cpu")
    @ResponseStatus(HttpStatus.OK)
    public Map<String, String> generateCpuLoad() {
        logger.info("Generating CPU load...");
        String hash = "loadtest";
        for (int i = 0; i < 1_000_000; i++) {
            hash = String.valueOf(hash.hashCode());
        }
        
        Map<String, String> response = new HashMap<>();
        response.put("status", "SUCCESS");
        response.put("message", "CPU Load Generated");
        response.put("hash", hash);
        return response;
    }
}