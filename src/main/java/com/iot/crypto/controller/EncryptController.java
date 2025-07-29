package com.iot.crypto.controller;

import com.iot.crypto.util.PBEUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.google.firebase.messaging.*;

import java.io.IOException;

@Controller
@RequestMapping("/crypto")
public class EncryptController {

    @PostMapping("/encrypt")
    public String encrypt(@RequestParam String inputText, @RequestParam String password, Model model) {
        try {
            String result = PBEUtil.encrypt(inputText, password);
            model.addAttribute("result", result);
        } catch (Exception e) {
            model.addAttribute("result", "암호화 실패: " + e.getMessage());
        }
        model.addAttribute("inputText", inputText);
        return "encrypt";
    }

    @PostMapping("/decrypt")
    public String decrypt(@RequestParam String inputDec, @RequestParam String password, Model model) {
        try {
            String result = PBEUtil.decrypt(inputDec, password);
            model.addAttribute("result", result);
        } catch (Exception e) {
            model.addAttribute("result", "복호화 실패: " + e.getMessage());
        }
        model.addAttribute("inputDec", inputDec);
        return "encrypt";
    }

    @GetMapping("/")
    public String showForm() {
        return "encrypt";
    }

    @GetMapping("/push-form")
    public String showPushForm() {
        return "push"; // push.jsp
    }

    @RequestMapping("/push")
    public String sendPushMessage(
            @RequestParam String token,
            @RequestParam String title,
            @RequestParam String body,
            Model model
    ) {
        model.addAttribute("result", sendPush(token, title, body));
        return "push";
    }


    public String sendPush(@RequestParam String token,
                         @RequestParam String title,
                         @RequestParam String body) {
        Notification notification = Notification.builder()
                .setTitle(title)
                .setBody(body)
                .build();

        Message message = Message.builder()
                .setToken(token)
                .setNotification(notification)
                .build();

        try {
            String response = FirebaseMessaging.getInstance().send(message);
            return "Push sent successfully: " + response;
        } catch (FirebaseMessagingException e) {
            e.printStackTrace();
            return "Push failed: " + e.getMessage();
        }
        // This registration token comes from the client FCM SDKs.
        /*String registrationToken = "YOUR_REGISTRATION_TOKEN";

// See documentation on defining a message payload.
        Message message = Message.builder()
                .putData("score", "850")
                .putData("time", "2:45")
                .setToken(registrationToken)
                .build();

// Send a message to the device corresponding to the provided
// registration token.
        String response = FirebaseMessaging.getInstance().send(message);
// Response is a message ID string.
        System.out.println("Successfully sent message: " + response);*/
    }
}