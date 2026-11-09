# syntax=docker/dockerfile:1

############################
# 1) Build stage
############################
FROM eclipse-temurin:17-jdk-noble AS build
WORKDIR /workspace

# 의존성 레이어 캐싱: 소스보다 빌드 스크립트를 먼저 복사
COPY gradlew settings.gradle build.gradle ./
COPY gradle ./gradle
RUN --mount=type=cache,target=/root/.gradle \
    ./gradlew dependencies --no-daemon > /dev/null

# 소스 복사 후 실행 jar 빌드 (테스트는 CI에서 별도 실행)
COPY src ./src
RUN --mount=type=cache,target=/root/.gradle \
    ./gradlew bootJar -x test --no-daemon \
 && cp build/libs/*-SNAPSHOT.jar app.jar \
 && java -Djarmode=tools -jar app.jar extract --layers --launcher --destination extracted

############################
# 2) Runtime stage
############################
FROM eclipse-temurin:17-jre-noble
WORKDIR /app

# root가 아닌 전용 사용자로 실행
RUN groupadd --system --gid 10001 app \
 && useradd --system --uid 10001 --gid app --no-create-home app

# 변경 빈도가 낮은 순서대로 레이어 복사 → 코드만 바뀌면 마지막 레이어만 교체
COPY --from=build /workspace/extracted/dependencies/ ./
COPY --from=build /workspace/extracted/spring-boot-loader/ ./
COPY --from=build /workspace/extracted/snapshot-dependencies/ ./
COPY --from=build /workspace/extracted/application/ ./

USER 10001:10001

# 컨테이너 메모리 limit 기준으로 힙 크기 결정 (limit 1Gi → 힙 최대 약 768Mi)
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=75.0 -XX:+ExitOnOutOfMemoryError"

EXPOSE 8080
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
