package com.iot.crypto.controller;

import com.iot.crypto.dto.FcmTokenDto;
import com.iot.crypto.service.FcmTokenService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FcmTokenController {

    private final FcmTokenService fcmTokenService;

    public FcmTokenController(FcmTokenService fcmTokenService) {
        this.fcmTokenService = fcmTokenService;
    }

    @PostMapping("/register-fcm-token")
    public ResponseEntity<String> registerToken(@RequestBody FcmTokenDto tokenDto) {
        fcmTokenService.saveToken(tokenDto);
        return ResponseEntity.ok("Token registered");
    }
}
