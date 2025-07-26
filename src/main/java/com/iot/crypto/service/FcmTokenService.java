package com.iot.crypto.service;

import com.iot.crypto.dto.FcmTokenDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class  FcmTokenService {
    private final JdbcTemplate jdbcTemplate;

    public FcmTokenService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void saveToken(FcmTokenDto dto) {
        String sql = "INSERT INTO fcm_tokens (token, user_agent, device_type, os) VALUES (?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE user_agent=?, device_type=?, os=?";
        jdbcTemplate.update(sql, dto.getToken(), dto.getUser_agent(), dto.getDevice_type(), dto.getOs(),
                dto.getUser_agent(), dto.getDevice_type(), dto.getOs());
    }
}
