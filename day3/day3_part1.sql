CREATE TABLE IF NOT EXISTS diagnostic_report (
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    binary_number bit(12) NOT NULL
);

SELECT CONCAT(
        CASE
            WHEN SUM(GET_BIT(binary_number, 0)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 1)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 2)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 3)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 4)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 5)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 6)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 7)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 8)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 9)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 10)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 11)) > COUNT(*) / 2 THEN 1
            ELSE 0
        END
    )::bit(12)::integer
    * CONCAT(
        CASE
            WHEN SUM(GET_BIT(binary_number, 0)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 1)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 2)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 3)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 4)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 5)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 6)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 7)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 8)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 9)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 10)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END,
        CASE
            WHEN SUM(GET_BIT(binary_number, 11)) < COUNT(*) / 2 THEN 1
            ELSE 0
        END
    )::bit(12)::integer
FROM diagnostic_report
