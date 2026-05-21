package click.mjkim.authservice.service;

import click.mjkim.authservice.dto.LoginRequest;
import click.mjkim.authservice.dto.SignUpRequest;
import click.mjkim.authservice.entity.User;
import click.mjkim.authservice.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final StringRedisTemplate redisTemplate;
    private final PasswordEncoder passwordEncoder;

    @Transactional
    public void signUp(SignUpRequest request) {
        if (userRepository.findByUsername(request.getUsername()).isPresent()) {
            throw new RuntimeException("Error: Username은 이미 존재합니다.");
        }

        User user = User.builder()
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword())) // 비밀번호 암호화
                .email(request.getEmail())
                .build();

        userRepository.save(user);
    }

    public String login(LoginRequest request) {
        // 1. MySQL에서 해당 유저가 있는지 조회
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new RuntimeException("Error: 아이디 또는 비밀번호가 틀렸습니다."));

        // 2. 비밀번호 매칭 확인
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new RuntimeException("Error: 아이디 또는 비밀번호가 틀렸습니다.");
        }

        // 3. 로그인 성공 시, 고유한 가짜 토큰(UUID) 생성
        String fakeToken = UUID.randomUUID().toString();

        // 4. Redis에 [Key = 토큰 / Value = 유저이름] 형태로 저장 (TTL 30분)
        String redisKey = "auth:token:" + fakeToken;
        redisTemplate.opsForValue().set(redisKey, request.getUsername(), 30, TimeUnit.MINUTES);

        return fakeToken;
    }
}