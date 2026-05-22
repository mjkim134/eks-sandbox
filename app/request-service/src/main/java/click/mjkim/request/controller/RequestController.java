package click.mjkim.request.controller;

import click.mjkim.request.service.RequestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/requests")
@RequiredArgsConstructor
public class RequestController {
    private final RequestService requestService;

    @PostMapping
    public String createRequest() {
        requestService.submitRequest();
        return "Success";
    }
}
