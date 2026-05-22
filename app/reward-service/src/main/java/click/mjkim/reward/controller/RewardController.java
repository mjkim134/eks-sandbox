package click.mjkim.reward.controller;

import click.mjkim.reward.service.RewardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/rewards")
@RequiredArgsConstructor
public class RewardController {
    private final RewardService rewardService;

    @GetMapping
    public String getRewardCount() {
        return "Total rewards issued: " + rewardService.getTotalCount();
    }
}
