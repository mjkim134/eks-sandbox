package click.mjkim.count.controller;

import click.mjkim.count.service.CountService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/count")
@RequiredArgsConstructor
public class CountController {
    private final CountService countService;

    @GetMapping
    public String getCount() {
        return "Total orders processed: " + countService.getTotalCount();
    }
}
