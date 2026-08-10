package Util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public final class PasswordUtil {
    private static final String SALT = "jdbc";
    public static String hash(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashed = digest.digest((SALT + password).getBytes(StandardCharsets.UTF_8));
            StringBuilder builder = new StringBuilder();
            for (byte value : hashed) {
                builder.append(String.format("%02x", value));
            }
            return builder.toString();
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 is not available", exception);
        }
    }
    public static boolean isStrongPassword(String password) {

        if (password == null || password.length() < 8) {
            return false;
        }

        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        for (char ch : password.toCharArray()) {

            if (Character.isUpperCase(ch)) {
                hasUpperCase = true;
            }
            else if (Character.isLowerCase(ch)) {
                hasLowerCase = true;
            }
            else if (Character.isDigit(ch)) {
                hasDigit = true;
            }
            else {
                hasSpecialChar = true;
            }
        }

        return hasUpperCase
                && hasLowerCase
                && hasDigit
                && hasSpecialChar;
    }
}















