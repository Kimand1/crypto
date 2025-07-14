빠르게 암복화 텍스트를 만들기 위한 프로젝트


docker build --platform=linux/amd64 -t crypto-jsp:0.1 .     
docker save -o crypto-jsp.tar crypto-jsp:0.1
scp -P 22 crypto-jsp.tar root@211.51.97.169:/data/crypto/jsp/


서버 접속 후
sudo docker run -d -p 8888:8080 --name crypto-jsp crypto-jsp:0.1
