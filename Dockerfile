# 1. 빌드 단계: Maven + JDK 8
FROM maven:3.8.5-jdk-8 AS build
WORKDIR /app

# 소스 복사
COPY . /app

# Maven 빌드 (테스트는 생략)
RUN mvn clean package -P MySQL -DskipTests

#2. 배포 단계: Tomcat 9.0.53 + JDK 8
FROM tomcat:9.0.53-jdk8-openjdk

# 기존 루트 앱 삭제
RUN rm -rf /usr/local/tomcat/webapps/*

# 빌드된 WAR 복사
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# 톰캣 포트 (기본 8080)
EXPOSE 8080