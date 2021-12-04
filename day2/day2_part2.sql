CREATE TABLE IF NOT EXISTS commands(id int, direction varchar(255), unit int);

WITH 
direction_with_aim_change AS (
	SELECT
		id,
		direction,
		unit,
		CASE
			WHEN direction = 'down' THEN unit
			WHEN direction = 'up' THEN unit * -1
			ELSE 0
		END
		AS aim_change
	FROM commands
),
direction_with_aim AS (
	SELECT
		id,
		direction,
		unit,
		SUM(aim_change) OVER(ORDER BY id
						ROWS UNBOUNDED PRECEDING)
						AS aim
	FROM direction_with_aim_change
),
direction_with_vertical_change AS (
	SELECT
		id,
		direction,
		unit,
		SUM(aim * unit) OVER(ORDER BY id
						ROWS UNBOUNDED PRECEDING)
						AS vertical
	FROM direction_with_aim
	WHERE direction = 'forward'
)
SELECT
	SUM
		(CASE
			WHEN direction = 'forward' THEN unit
			ELSE 0
			END
		)
	*
	(MAX(ARRAY[id, vertical]))[2]
FROM direction_with_vertical_change

