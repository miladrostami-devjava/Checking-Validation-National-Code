package com.example;

public class NationalCodeValidator {

    public static String checkNationalCode(String nationalCode) {

        // step 1: national code should be 10 digit
        // regular expression \\d+ : d>>> check 0 to 9 and + repeat the pattern 0 to 9 number
        //  \\d: represents any digit from 0 to 9.
        if (nationalCode == null && nationalCode.length() != 10 && nationalCode.matches("\\d+")) {
            System.out.println("valid national code");
        } else {
            System.out.println("invalid national code");
        }


        //step 2: convert national code to array digits
        int[] codeDigits = new int[10];
        for (int i = 0; i < 10; i++) {
            codeDigits[i] = Character.getNumericValue(nationalCode.charAt(i));
        }

        //step-3: calculate the sum of digits
        int sum_value_digits = 0;
        for (int i = 0; i < 9; i++) {
            sum_value_digits += codeDigits[i] * (10 - i);
        }

        //step-4: calculate control digit
        int remainder = sum_value_digits % 11;
        int control_digit = remainder < 2 ? 0 : (11 - remainder);

        //step_5 : checking validate national code
        if (control_digit == codeDigits[9]) {
            System.out.println("valid national code");
        }
        return "invalid national code";

    }

}





