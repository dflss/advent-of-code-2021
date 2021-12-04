CREATE TABLE IF NOT EXISTS measurements(id int, depth int);

WITH measurements_with_delta AS (
    SELECT 
	depth,
	depth - LAG(depth) OVER(ORDER BY id) as delta
    FROM measurements
)
SELECT 
    COUNT(delta) AS increasing_rows_count
FROM measurements_with_delta
WHERE delta > 0
