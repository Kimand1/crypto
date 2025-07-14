package com.iot.crypto.controller;

import com.iot.crypto.util.PBEUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
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
}