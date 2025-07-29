// main.ts or app.ts
import { initializeApp } from "firebase/app";
import { getMessaging, getToken, onMessage } from "firebase/messaging";

const firebaseConfig = {
    apiKey: "AIzaSyAB8-es_c35DqEMEU6Jeuyii3vyDCU7TY8",
    authDomain: "mini-crypto-80bc3.firebaseapp.com",
    projectId: "mini-crypto-80bc3",
    storageBucket: "mini-crypto-80bc3.firebasestorage.app",
    messagingSenderId: "694090253635",
    appId: "1:694090253635:web:89a9513459ed973a7adbf6",
    measurementId: "G-2XRMG36JQH"
};

const app = initializeApp(firebaseConfig);
const messaging = getMessaging(app);
// service worker를 '/crypto/firebase-messaging-sw.js'로 명시 등록
navigator.serviceWorker.register('/crypto/firebase-messaging-sw.js')
    .then((registration) => {
        console.log('Service Worker registered:', registration);

        // messaging에 등록된 serviceWorker를 명시적으로 연결
        messaging.useServiceWorker(registration);
    })
    .catch(err => {
        console.error('Service Worker registration failed:', err);
    });
// 브라우저 권한 요청 + 토큰 획득
export async function requestPermissionAndGetToken() {
    const permission = await Notification.requestPermission();
    if (permission === "granted") {
        const token = await getToken(messaging, {
            vapidKey: "YOUR_PUBLIC_VAPID_KEY"
        });
        console.log("Push Token:", token);
        // TODO: 이 토큰을 서버에 저장
    } else {
        console.warn("Permission not granted for Notification");
    }
}

// 포그라운드 푸시 수신 처리
onMessage(messaging, payload => {
    console.log("Message received in foreground: ", payload);
});
