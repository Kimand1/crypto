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

messaging.onBackgroundMessage(payload => {
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: '/icon-192.png'
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
});
