------------------------------------------------------------------------------------------------------------------------
-- Q1 - Top event types
------------------------------------------------------------------------------------------------------------------------
SELECT data.commit.collection AS event,
       count() AS count
FROM bluesky
GROUP BY event
ORDER BY count DESC, event ASC;

------------------------------------------------------------------------------------------------------------------------
-- Q2 - Top event types together with unique users per event type
------------------------------------------------------------------------------------------------------------------------
SELECT data.commit.collection AS event,
       count() AS count,
       count(DISTINCT data.did) AS users
FROM bluesky
WHERE data.kind = 'commit' AND data.commit.operation = 'create'
GROUP BY event
ORDER BY count DESC, event ASC;

------------------------------------------------------------------------------------------------------------------------
-- Q3 - When do people use BlueSky
------------------------------------------------------------------------------------------------------------------------
SELECT data.did::String as user_id,
       min(to_timestamp_micros(arrow_cast(data.time_us, 'Int64'))) AS first_post_ts
FROM bluesky
WHERE data.kind = 'commit'
  AND data.commit.operation = 'create'
  AND data.commit.collection = 'app.bsky.feed.post'
GROUP BY user_id
ORDER BY first_post_ts ASC, user_id DESC
LIMIT 3;

------------------------------------------------------------------------------------------------------------------------
-- Q4 - top 3 post veterans
------------------------------------------------------------------------------------------------------------------------
SELECT data.did::String as user_id,
       min(to_timestamp_micros(arrow_cast(data.time_us, 'Int64'))) AS first_post_ts
FROM bluesky
WHERE data.kind = 'commit'
  AND data.commit.operation = 'create'
  AND data.commit.collection = 'app.bsky.feed.post'
GROUP BY user_id
ORDER BY first_post_ts ASC, user_id DESC
LIMIT 3;

------------------------------------------------------------------------------------------------------------------------
-- Q5 - top 3 users with longest activity
------------------------------------------------------------------------------------------------------------------------
SELECT data.did::String as user_id,
       date_part(
           'epoch',
           max(to_timestamp_micros(arrow_cast(data.time_us, 'Int64'))) -
             min(to_timestamp_micros(arrow_cast(data.time_us, 'Int64')))
       ) AS activity_span
FROM bluesky
WHERE data.kind = 'commit'
  AND data.commit.operation = 'create'
  AND data.commit.collection = 'app.bsky.feed.post'
GROUP BY user_id
ORDER BY activity_span DESC, user_id DESC
LIMIT 3;
