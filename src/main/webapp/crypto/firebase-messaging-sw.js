// firebase-messaging-sw.js
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyAB8-es_c35DqEMEU6Jeuyii3vyDCU7TY8",
    authDomain: "mini-crypto-80bc3.firebaseapp.com",
    projectId: "mini-crypto-80bc3",
    storageBucket: "mini-crypto-80bc3.firebasestorage.app",
    messagingSenderId: "694090253635",
    appId: "1:694090253635:web:89a9513459ed973a7adbf6",
    measurementId: "G-2XRMG36JQH"
});

const messaging = firebase.messaging();

// 백그라운드 메시지 수신 핸들러
// 앱이 포그라운드에 있지 않을 때 FCM으로부터 메시지가 도착하면 이 함수가 실행됩니다.
messaging.onBackgroundMessage((payload) => {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);

    // 알림 페이로드가 있는지 확인
    const notificationTitle = payload.notification ? payload.notification.title : '새 메시지';
    const notificationOptions = {
        body: payload.notification ? payload.notification.body : '내용 없음',
        icon: '/crypto/icons/icon-192x192.png' // 앱 아이콘 경로. Nginx에서 이 경로의 정적 파일을 서빙해야 함
    };

    // 알림 표시
    self.registration.showNotification(notificationTitle, notificationOptions);
});

// 이 파일 자체는 navigator.serviceWorker.register()를 호출하지 않습니다.
// Service Worker는 메인 스크립트(HTML 파일 또는 메인 JavaScript 파일)에서 등록되어야 합니다.
// 예시:
// if ('serviceWorker' in navigator) {
//     navigator.serviceWorker.register('/firebase-messaging-sw.js')
//         .then((registration) => {
//             console.log('Service Worker registered with scope:', registration.scope);
//             // 메인 스레드에서 Firebase Messaging을 초기화한 경우,
//             // useServiceWorker를 사용하여 명시적으로 연결할 수 있습니다.
//             // const messaging = firebase.messaging();
//             // messaging.useServiceWorker(registration);
//         })
//         .catch((err) => {
//             console.error('Service Worker registration failed:', err);
//         });
// }
