package com.iot.crypto.dto;

import lombok.Data;

@Data
public class FcmTokenDto {
    private String token;
    private String user_agent;
    private String device_type;
    private String os;
}
