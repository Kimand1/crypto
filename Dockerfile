# 1. 베이스 이미지 (Java 17 이상 + Tomcat 내장)
FROM eclipse-temurin:17-jdk as build

# 3. 런타임 이미지
FROM eclipse-temurin:17-jre

ENV TZ=Asia/Seoul
ENV FIREBASE_CONFIG_PATH=/app/firebase-service-key.json

WORKDIR /app
# 위에서 빌드된 WAR 복사
COPY ../target/*.war /app/app.war
COPY ../src/main/resources/firebase-service-key.json /app/firebase-service-key.json

# 포트 노출
EXPOSE 8080

# 실행
ENTRYPOINT ["java", "-jar", "app.war"]