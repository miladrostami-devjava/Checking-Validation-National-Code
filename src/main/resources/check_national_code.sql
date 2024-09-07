CREATE OR REPLACE FUNCTION check_national_code(national_code IN VARCHAR2)
    RETURN VARCHAR2
    IS
    sum_value_digits  NUMBER := 0;
    control_digit     NUMBER;
    remainder         NUMBER;
BEGIN
    -- Step 1: Check if the national code is null, not 10 digits long, or contains non-numeric characters
    IF national_code IS NULL OR LENGTH(national_code) != 10 OR NOT REGEXP_LIKE(national_code, '^\d+$') THEN
        RETURN 'invalid national code';
END IF;

    -- Step 2: Convert national code to individual digits and calculate the weighted sum
FOR i IN 1..9 LOOP
            sum_value_digits := sum_value_digits + TO_NUMBER(SUBSTR(national_code, i, 1)) * (11 - i);
END LOOP;

    -- Step 3: Calculate the remainder and control digit
    remainder := MOD(sum_value_digits, 11);
    IF remainder < 2 THEN
        control_digit := 0;
ELSE
        control_digit := 11 - remainder;
END IF;

    -- Step 4: Check if the control digit matches the last digit of the national code
    IF control_digit = TO_NUMBER(SUBSTR(national_code, 10, 1)) THEN
        RETURN 'valid national code';
ELSE
        RETURN 'invalid national code';
END IF;

END check_national_code;







SELECT check_national_code('2281228703') FROM dual;
SELECT check_national_code('1231231230') FROM dual;

