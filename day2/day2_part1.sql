CREATE TABLE IF NOT EXISTS commands(id int, direction varchar(255), unit int);

SELECT SUM(CASE
        WHEN direction = 'down' THEN unit
        WHEN direction = 'up' THEN unit * -1
        ELSE 0
        END
    ) * SUM(CASE
        WHEN direction = 'forward' THEN unit
        ELSE 0
        END
    )
FROM commands
