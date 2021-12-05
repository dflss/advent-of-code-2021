CREATE TABLE IF NOT EXISTS measurements(id int, depth int);

WITH
measurements_with_moving_sum AS (
    SELECT
        id,
        depth,
        SUM(depth) OVER(ORDER BY id
            ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING )
        AS moving_sum
    FROM measurements
),

measurements_with_deltas AS (
    SELECT moving_sum - LAG(moving_sum) OVER(ORDER BY id) AS delta
    FROM measurements_with_moving_sum
)

SELECT COUNT(delta) AS increasing_rows_count
FROM measurements_with_deltas
WHERE delta > 0
