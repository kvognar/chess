Self_join
9.

SELECT
  s2.name,
  r1.company,
  r1.num
FROM
  stops s1
JOIN
  route r1
ON
  s1.id = r1.stop
JOIN
  route r2
ON
  r2.company = r1.company AND r1.num = r2.num
JOIN
  stops s2
ON
  s2.id = r2.stop
WHERE
  s1.name = 'Craiglockhart'
  
10.

SELECT
r1.company,
r1.num,
s2.name,
r3.company,
r3.num
FROM
(SELECT
  *
  FROM
  route first_leg_starts
  WHERE
  first_leg_starts.stop = (
    SELECT
    stops.id
    FROM
    stops
    WHERE
    stops.name = 'Craiglockhart'
  )
) AS r1
JOIN
route r2
ON
r2.company = r1.company AND r2.num = r1.num
JOIN
stops s2
ON
s2.id = r2.stop
JOIN
route r3
ON
r3.stop = s2.id
JOIN
route r4
ON
r4.company = r3.company AND r4.num = r3.num
JOIN
stops s3
ON
s3.id = r4.stop
WHERE
s3.name = 'Sighthill'