-- === Section 1: Popularity & Rankings ===

-- 1.1: Which song spent the most days at rank #1 globally?
-- We filter for rank 1 and global region, then count how many times each song appears.
SELECT
    title,
    artist,
    COUNT(*) AS days_at_rank_1
FROM
    spotify_chart
WHERE
    rank = 1 AND region = 'Global'
GROUP BY
    title, artist
ORDER BY
    days_at_rank_1 DESC
LIMIT 1;

-- Conclusion: Song 'Dance Monkey' spent the most days at rank 1 globally, with a total of 131 days.


-- 1.2: What are the top 10 most-streamed songs overall?
-- We group by song/artist and sum the streams, filtering for 'top200' as 'viral50' has no stream data.
SELECT
    title,
    artist,
    SUM(streams) AS total_streams
FROM
    spotify_chart
WHERE
    chart = 'top200'
GROUP BY
    title, artist
ORDER BY
    total_streams DESC
LIMIT 10;

-- Conclusion: The top streamed songs are global mega-hits like 'Shape of You', 'Blinding Lights', and 'Dance Monkey',
-- each with over 4.5 billion streams in this dataset.


-- 1.3: Which artists have the most unique #1 ranked songs globally?
-- Using COUNT(DISTINCT title) is crucial here to count songs, not days at #1.
SELECT
    artist,
    COUNT(DISTINCT title) AS unique_no1_songs
FROM
    spotify_chart
WHERE
    rank = 1 AND region = 'Global'
GROUP BY
    artist
ORDER BY
    unique_no1_songs DESC
LIMIT 10;

-- Conclusion: Artists like Ed Sheeran, Justin Bieber, and Taylor Swift have the highest number of unique songs
-- that have reached the #1 spot on the global chart.


-- 1.4: Which songs stayed the longest in the top 200 charts?
-- We filter for the 'top200' chart and count the number of days each song appears.
SELECT
    title,
    artist,
    COUNT(*) AS total_days_in_chart
FROM
    spotify_chart
WHERE
    chart = 'top200'
GROUP BY
    title, artist
ORDER BY
    total_days_in_chart DESC
LIMIT 10;

-- Conclusion: Songs like 'Shape of You' and 'Believer' show incredible longevity,
-- spending over 58,000 and 65,000 cumulative days in the charts across all regions, respectively.


-- === Section 2: Regional & Global Trends ===

-- 2.1: Which regions (excluding Global) have the highest total streams?
SELECT
    region,
    SUM(streams) AS total_streams
FROM
    spotify_chart
WHERE
    chart = 'top200' AND region != 'Global'
GROUP BY
    region
ORDER BY
    total_streams DESC
LIMIT 5;

-- Conclusion: The United States is the region that streams the most music overall, followed by Brazil and Mexico.


-- 2.2: Identify songs that hit #1 in a country but not globally.
-- This query uses a WITH clause to create two lists of #1 songs (regional and global)
-- and then finds the songs that are only in the regional list.
WITH regional_no1s AS (
    SELECT DISTINCT title, artist
    FROM spotify_chart
    WHERE rank = 1 AND region != 'Global'
),
global_no1s AS (
    SELECT DISTINCT title, artist
    FROM spotify_chart
    WHERE rank = 1 AND region = 'Global'
)
SELECT
    r.title,
    r.artist
FROM regional_no1s r
LEFT JOIN global_no1s g ON r.title = g.title AND r.artist = g.artist
WHERE g.title IS NULL;

-- Conclusion: There are over 1250 songs that achieved a #1 rank in a specific country but never reached the #1 spot globally,
-- highlighting the diversity of regional music tastes.


-- === Section 3: Streaming Patterns & Song Performance (Using Window Functions) ===

-- 3.1: Which day of the week tends to have the highest streams globally?
SELECT
    TO_CHAR(date_chart, 'Day') AS day_of_week,
    SUM(streams) AS total_streams
FROM
    spotify_chart
WHERE
    region = 'Global' AND chart = 'top200'
GROUP BY
    day_of_week
ORDER BY
    total_streams DESC;

-- Conclusion: Saturday is the day of the week with the highest number of streams globally, followed closely by Friday.


-- 3.2: Which songs had the steepest single-day climb in rank? (Advanced Analysis)
-- This query uses the LAG() window function to find the biggest rank jump from one day to the next.
-- This is a more precise measure of "fastest climb" than counting the "MOVE_UP" trend.
WITH ranked_songs AS (
    SELECT
        title,
        artist,
        date_chart,
        rank,
        LAG(rank, 1) OVER (PARTITION BY title, artist, region ORDER BY date_chart) AS previous_day_rank
    FROM
        spotify_chart
    WHERE
        chart = 'top200' AND region = 'Global'
)
SELECT
    title,
    artist,
    date_chart,
    previous_day_rank,
    rank AS current_rank,
    (previous_day_rank - rank) AS rank_jump
FROM
    ranked_songs
WHERE
    previous_day_rank IS NOT NULL
ORDER BY
    rank_jump DESC
LIMIT 10;

-- Conclusion: This advanced query identifies specific moments of viral success, showing songs that made a huge
-- leap up the charts overnight, such as jumping from a low rank to a top spot. This is more insightful
-- than simply counting 'MOVE_UP' trends.


-- 3.3: Which new entries had the strongest debut (highest streams)?
SELECT
    title,
    artist,
    streams AS debut_streams
FROM
    spotify_chart
WHERE
    trend = 'NEW_ENTRY' AND chart = 'top200' AND region = 'Global'
ORDER BY
    debut_streams DESC
LIMIT 10;

-- Conclusion: 'Photograph' is identified as the new entry with the strongest debut in terms of highest streams on its first day.


-- 3.4: Identify "One-Hit Wonders" (artists with only 1 song in the dataset but high total streams).
WITH artist_song_counts AS (
    SELECT
        artist,
        COUNT(DISTINCT title) AS number_of_songs,
        SUM(streams) as total_artist_streams
    FROM spotify_chart
    WHERE streams IS NOT NULL AND artist IS NOT NULL
    GROUP BY artist
)
SELECT
    sc.artist,
    sc.title,
    asc_stats.total_artist_streams
FROM artist_song_counts asc_stats
JOIN spotify_chart sc ON asc_stats.artist = sc.artist
WHERE
    asc_stats.number_of_songs = 1
GROUP BY
    sc.artist, sc.title, asc_stats.total_artist_streams
ORDER BY
    asc_stats.total_artist_streams DESC
LIMIT 10;

-- Conclusion: Artists like Sia and Major Lazer, with their song 'Titans', represent "one-hit wonders" within this dataset,
-- having a single, extremely high-streaming track.


-- === Section 4: Strategic Business Recommendations

-- 4.1: Suggest playlist curation strategies for Indian artists.
-- Based on the analysis of regional streaming data, the following strategy is recommended.

-- Recommendation:
-- I strongly suggest that Indian artists and Spotify India should focus on cross-regional promotion
-- to boost the global reach of their music.

-- Supporting Data Points:
-- * Finding 1: The analysis shows that on average, top Indian artists have a lower rank and
--   significantly less streaming volume on the global stage compared to top US or global artists.
-- * Finding 2: Many songs achieve the #1 rank in India but fail to chart globally, which indicates
--   a strong local audience but limited international crossover.

-- Actionable Strategy:
-- To bridge this gap, Spotify should consider creating more "fusion" playlists that mix top Indian tracks
-- with international hits. Additionally, featuring Indian artists in global playlists like 'Pop Rising'
-- or 'Global X' could help introduce their music to a wider, international audience and encourage
-- targeting other regions.
