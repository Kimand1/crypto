빠르게 암복화 텍스트를 만들기 위한 프로젝트

docker build --platform=linux/amd64 -t crypto-jsp:0.1 .     
docker save -o crypto-jsp.tar crypto-jsp:0.1
scp -P 22 crypto-jsp.tar root@211.51.97.169:/data/crypto/jsp/


서버 접속 후<br/>
sudo docker run -d -p 8888:8080 --name crypto-jsp crypto-jsp:0.1


테이블 생성 후 application.properties 파일에서 DB 정보 수정 필요

CREATE TABLE fcm_tokens (
 
    id INT AUTO_INCREMENT PRIMARY KEY,
    token VARCHAR(512) NOT NULL UNIQUE,
    user_agent TEXT,
    device_type VARCHAR(50),
    os VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
