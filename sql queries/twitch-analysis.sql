Use twitchdb

-- Understanding our data
SELECT top 10 * 
FROM streamers21

-- How many channels are there?
SELECT COUNT(*) AS total_channels
FROM streamers21

-- Average performance metrics
SELECT 
  AVG(watch_time) AS avg_watch_time,
  AVG(stream_time) AS avg_stream_time, 
  AVG(average_viewers) AS avg_viewers 
FROM streamers21

-- Engagement Analysis

-- Engagement Ratio 
SELECT 
  channel,
  watch_time,
  stream_time,
  (watch_time * 1.0 / stream_time) AS engagement_ratio
FROM streamers21
ORDER BY engagement_ratio DESC


-- Top 10 Most Engaging Channels
SELECT top 10
  channel,
  (watch_time * 1.0 / stream_time) AS engagement_ratio
FROM streamers21
ORDER BY engagement_ratio DESC

-- Growth Analysis

-- Who is Growing Fastest?
SELECT 
  channel,
  followers_gained,
  views_gained
FROM streamers21
ORDER BY followers_gained DESC

-- Growth Efficiency
SELECT 
  channel,
  followers_gained,
  watch_time,
  (followers_gained * 1.0 / watch_time) AS follower_efficiency
FROM streamers21
ORDER BY follower_efficiency DESC

-- Language Analysis

-- Performance by Language
SELECT 
  language,
  AVG(average_viewers) AS avg_viewers,
  AVG(followers_gained) AS avg_growth
FROM streamers21
GROUP BY language
ORDER BY avg_viewers DESC

-- Partnership Analysis

-- Does Partnership Matter?
SELECT 
  partnered,
  AVG(average_viewers) AS avg_viewers,
  AVG(followers_gained) AS avg_followers
FROM streamers21
GROUP BY partnered

-- Real streamer performance
SELECT top 10
  channel,
  watch_time,
  stream_time,
  (watch_time * 1.0 / stream_time) AS engagement_ratio
FROM streamers21
WHERE channel NOT LIKE '%dota%'
  AND channel NOT IN ('LCS', 'LCK', 'LCK_Korea')
  AND stream_time > 0
ORDER BY engagement_ratio DESC

-- How efficiently a channel converts viewer attention into followers?
SELECT top 10
  channel,
  followers_gained,
  watch_time,
  (followers_gained * 1.0 / watch_time) AS growth_efficiency
FROM streamers21
WHERE stream_time > 0
ORDER BY growth_efficiency DESC

-- Rank channels by engagement within language
SELECT 
  channel,
  language,
  (watch_time * 1.0 / stream_time) AS engagement_ratio,
  RANK() OVER (
    PARTITION BY language 
    ORDER BY (watch_time * 1.0 / stream_time) DESC
  ) AS lang_rank
FROM streamers21
WHERE stream_time > 0

-- Percentile ranking (top performers insight)
SELECT 
  channel,
  followers_gained,
  PERCENT_RANK() OVER (
    ORDER BY followers_gained DESC
  ) AS growth_percentile
FROM streamers21;

-- Moving average style insight (advanced storytelling)
SELECT 
  channel,
  average_viewers,
  AVG(average_viewers) OVER () AS global_avg_viewers,
  (average_viewers * 1.0) / AVG(average_viewers) OVER () AS viewer_index
FROM streamers21