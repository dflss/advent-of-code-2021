CREATE TABLE IF NOT EXISTS commands(id int, direction varchar(255), unit int);

WITH direction_sums AS (
	SELECT 
		direction,
		SUM(unit) as total
	FROM commands
	GROUP BY direction
),
final_position AS(
	SELECT
		SUM
		(CASE
			WHEN direction = 'down' THEN total
			WHEN direction = 'up' THEN total * -1
			ELSE 0
			END
		) AS vertical,
		SUM
		(CASE
			WHEN direction = 'forward' THEN total
			ELSE 0
			END
		) AS horizontal
	FROM direction_sums
)
SELECT
	vertical * horizontal
FROM final_position
