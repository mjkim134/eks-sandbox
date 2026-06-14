package com.example.eksdemo.api.sample.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/sample")
public class SampleController {

    @Value("${sample.id}")
    private String sampleId;

    @Value("${sample.password}")
    private String samplePassword;

    @GetMapping("/hello")
    @ResponseStatus(HttpStatus.OK)
    public String getHello() {
        return "<h1>Hello EKS</h1>";
    }

    @GetMapping("/testSecrets")
        @ResponseStatus(HttpStatus.OK)
        public String getSecrets() {
            return "ID: " + sampleId + " / Password: " + samplePassword;
        }
}
