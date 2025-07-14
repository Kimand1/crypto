package com.iot.crypto.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.KeySpec;
import java.util.Base64;


import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class PBEUtil {
    private static final byte[] salt = {
            (byte) 0xA9, (byte) 0x9B, (byte) 0xC8, (byte) 0x32,
            (byte) 0x56, (byte) 0x34, (byte) 0xE3, (byte) 0x03
    };
    private static final int iterationCount = 19;

    public static String encrypt(String plainText, String password) throws Exception {
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        pbeEnc.setAlgorithm("PBEWithMD5AndDES");
        pbeEnc.setPassword(password);

        return pbeEnc.encrypt(plainText);
    }

    public static String decrypt(String encryptedText, String password) throws Exception {
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        pbeEnc.setAlgorithm("PBEWithMD5AndDES");
        pbeEnc.setPassword(password);

        return pbeEnc.decrypt(encryptedText);
    }
}