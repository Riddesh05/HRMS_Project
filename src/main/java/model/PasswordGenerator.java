package model;

import java.util.Random;

public class PasswordGenerator {
    public static String generatePassword(String fullName) {

        String name = fullName.replaceAll("\\s+", "");
        if (name.length() >= 4) {
            name = name.substring(0, 4);
        }
        Random random = new Random();
        int number = 1000 + random.nextInt(9000);
        return name + number;
    }
}
