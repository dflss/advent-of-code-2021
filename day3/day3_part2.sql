CREATE TABLE IF NOT EXISTS diagnostic_report (
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
    binary_number bit(12) NOT NULL
);

WITH RECURSIVE rating AS (
    SELECT
        0 AS bit_position,
        GET_BIT(
            binary_number, 0
        ) = CASE
            WHEN count_1 >= count_0 THEN 1 ELSE 0
        END AS is_oxygen_generator,
        binary_number
    FROM (
            SELECT
                binary_number,
                COUNT(
                    binary_number
                ) FILTER (WHERE GET_BIT(binary_number, 0) = 0) OVER() AS count_0,
                COUNT(
                    binary_number
                ) FILTER (WHERE GET_BIT(binary_number, 0) = 1) OVER() AS count_1
            FROM diagnostic_report
    ) AS _
    UNION ALL
    SELECT
        bit_position,
        is_oxygen_generator,
        binary_number
    FROM (
            SELECT
                is_oxygen_generator,
                binary_number,
                bit_position + 1 AS bit_position,
                COUNT(
                    binary_number
                ) FILTER (
                    WHERE GET_BIT(binary_number, bit_position + 1) = 0
                ) OVER(PARTITION BY bit_position, is_oxygen_generator) AS count_0,
                COUNT(
                    binary_number
                ) FILTER (
                    WHERE GET_BIT(binary_number, bit_position + 1) = 1
                ) OVER(PARTITION BY bit_position, is_oxygen_generator) AS count_1
            FROM rating
            WHERE bit_position + 1 < 12
    ) AS _
    WHERE (is_oxygen_generator = TRUE AND GET_BIT(binary_number, bit_position)
        = CASE WHEN count_1 >= count_0 THEN 1 ELSE 0 END)
        OR (is_oxygen_generator = FALSE AND GET_BIT(binary_number, bit_position)
            = CASE WHEN count_1 >= count_0 THEN 0 ELSE 1 END)
)

SELECT MAX(total_rating) * MIN(total_rating)
FROM (
    SELECT
	(MAX(ARRAY[bit_position, binary_number::integer]))[2] AS total_rating
    FROM rating
    GROUP BY is_oxygen_generator
) AS _
