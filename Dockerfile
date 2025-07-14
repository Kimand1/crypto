# 1. 베이스 이미지 (Java 17 이상 + Tomcat 내장)
FROM eclipse-temurin:17-jdk as build

# 2. 빌드 단계: Maven을 사용해 JAR/WAR 생성
WORKDIR /app
COPY . .
RUN ./mvnw clean package -DskipTests

# 3. 런타임 이미지
FROM eclipse-temurin:17-jre

WORKDIR /app
# 위에서 빌드된 WAR 복사
COPY --from=build /app/target/*.war app.war

# 포트 노출
EXPOSE 8080

# 실행
ENTRYPOINT ["java", "-jar", "app.war"]