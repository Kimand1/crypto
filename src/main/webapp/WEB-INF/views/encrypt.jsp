<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>PBEWithMD5AndDES 암복호화 도구</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            box-sizing: border-box;
        }

        .container {
            display: flex;
            flex-direction: row;
            gap: 30px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 1100px;
        }

        .form-section {
            flex: 1;
            max-width: 600px;
        }

        .result-section {
            width: 400px;
            position: relative;
        }

        h2 {
            color: #333;
            margin-bottom: 30px;
            font-size: 2em;
            text-align: center;
        }

        form {
            background-color: #e8f0fe;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: left;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        textarea, input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
            resize: vertical;
        }

        textarea {
            min-height: 100px;
        }

        button[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        button[type="submit"]:hover {
            background-color: #45a049;
        }

        .result-section h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.8em;
            text-align: center;
        }

        .result-area {
            background-color: #f0f0f0;
            padding: 20px;
            border-radius: 8px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
            margin-top: 10px;
            position: relative;
        }

        .result-area textarea {
            background-color: #ffffff;
            border: 1px solid #ddd;
            width: 100%;
            min-height: 200px;
            font-family: 'Courier New', Courier, monospace;
            color: #333;
            resize: vertical;
        }

        .copy-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 6px 12px;
            font-size: 0.9em;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .copy-btn:hover {
            background-color: #0056b3;
        }
    </style>
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#0d47a1">

    <!-- iOS 지원용 -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="apple-touch-icon" href="/icons/icon-192x192.png">

    <!-- Service Worker 등록 -->
    <script>
        if ("serviceWorker" in navigator) {
            window.addEventListener("load", () => {
                navigator.serviceWorker.register("/service-worker.js").then(
                    (registration) => {
                        console.log("ServiceWorker 등록 성공:", registration.scope);
                    },
                    (err) => {
                        console.log("ServiceWorker 등록 실패:", err);
                    }
                );
            });
        }
    </script>
</head>
<body>
<div class="container">
    <div class="form-section">
        <h2>암복호화 도구 (PBEWithMD5AndDES)</h2>
        <button id="installBtn" style="display:none;">앱 설치하기</button>
        <form method="post" action="/encrypt">
            <label for="encryptText">텍스트:</label>
            <textarea id="encryptText" name="inputText" rows="5" cols="50"><c:if test="${not empty inputText}">${inputText}</c:if></textarea>
            <label for="encryptPassword">비밀번호:</label>
            <input type="text" id="encryptPassword" name="password" value="kiotPlatform"/>
            <button type="submit">암호화</button>
        </form>

        <form method="post" action="/decrypt">
            <label for="decryptText">암호문:</label>
            <textarea id="decryptText" name="inputDec" rows="5" cols="50"><c:if test="${not empty inputDec}">${inputDec}</c:if></textarea>
            <label for="decryptPassword">비밀번호:</label>
            <input type="text" id="decryptPassword" name="password" value="kiotPlatform"/>
            <button type="submit">복호화</button>
        </form>
    </div>

    <div class="result-section">
        <c:if test="${not empty result}">
            <h3>결과</h3>
            <div class="result-area">
                <button class="copy-btn" onclick="copyResult()">복사</button>
                <textarea id="resultText" readonly>${result}</textarea>
            </div>
        </c:if>
    </div>
</div>

<script>
    function copyResult() {
        const textarea = document.getElementById('resultText');
        textarea.select();
        document.execCommand('copy');
        alert("결과가 클립보드에 복사되었습니다.");
    }
</script>
<script>
    let deferredPrompt;
    const installBtn = document.getElementById('installBtn');

    // 설치 가능할 때 발생하는 이벤트
    window.addEventListener('beforeinstallprompt', (e) => {
        e.preventDefault(); // 자동 설치 방지
        deferredPrompt = e; // 나중에 사용
        installBtn.style.display = 'inline-block'; // 버튼 표시
    });

    // 버튼 클릭 시 설치 창 띄우기
    installBtn.addEventListener('click', () => {
        if (deferredPrompt) {
            deferredPrompt.prompt(); // 설치 대화상자 띄우기
            deferredPrompt.userChoice.then((choiceResult) => {
                if (choiceResult.outcome === 'accepted') {
                    console.log('사용자가 앱을 설치했습니다');
                } else {
                    console.log('사용자가 앱 설치를 취소했습니다');
                }
                deferredPrompt = null; // 초기화
            });
        }
    });
</script>
<script type="module">
    // Import the functions you need from the SDKs you need
    import { initializeApp } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-app.js";
    import { getAnalytics } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-analytics.js";
    import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/12.0.0/firebase-messaging.js";

    // TODO: Add SDKs for Firebase products that you want to use
    // https://firebase.google.com/docs/web/setup#available-libraries

    // Your web app's Firebase configuration
    // For Firebase JS SDK v7.20.0 and later, measurementId is optional
    const firebaseConfig = {
        apiKey: "AIzaSyAB8-es_c35DqEMEU6Jeuyii3vyDCU7TY8",
        authDomain: "mini-crypto-80bc3.firebaseapp.com",
        projectId: "mini-crypto-80bc3",
        storageBucket: "mini-crypto-80bc3.firebasestorage.app",
        messagingSenderId: "694090253635",
        appId: "1:694090253635:web:89a9513459ed973a7adbf6",
        measurementId: "G-2XRMG36JQH"
    };

    // Initialize Firebase
    const app = initializeApp(firebaseConfig);
    const analytics = getAnalytics(app);

    const messaging = getMessaging(app);

    Notification.requestPermission().then((permission) => {
        if (permission === "granted") {
            getToken(messaging, {
                vapidKey: "BAlwwwzYs_0esS-zz94PBx7zbG6Mq57102bvMFV5omZXm1pYpLjbG4doyCbwIeIsplZPce2xQ2nK16ErN8DUpEo"
            }).then((currentToken) => {
                if (currentToken) {
                    console.log("FCM Token:", currentToken);
                    // TODO: 서버에 토큰 전송
                    // 디바이스 정보 수집
                    const userAgent = navigator.userAgent;
                    const isMobile = /Mobi|Android/i.test(userAgent);
                    const os = /Android/.test(userAgent)
                        ? 'Android'
                        : /iPhone|iPad|iPod/.test(userAgent)
                            ? 'iOS'
                            : /Win/.test(userAgent)
                                ? 'Windows'
                                : /Mac/.test(userAgent)
                                    ? 'MacOS'
                                    : 'Unknown';

                    // 서버로 전송
                    fetch('/register-fcm-token', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            token: currentToken,
                            user_agent: userAgent,
                            device_type: isMobile ? 'Mobile' : 'Desktop',
                            os: os
                        })
                    }).then(res => res.text()).then(console.log);
                } else {
                    console.warn("No token available.");
                }
            }).catch((err) => {
                console.error("An error occurred while retrieving token. ", err);
            });
        }
    });
</script>
</body>
</html>