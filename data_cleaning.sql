-- The FILTER clause provides a clean and efficient way to count NULLs per column.

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE title IS NULL) AS title_nulls,
    COUNT(*) FILTER (WHERE rank IS NULL) AS rank_nulls,
    COUNT(*) FILTER (WHERE date_chart IS NULL) AS date_nulls,
    COUNT(*) FILTER (WHERE artist IS NULL) AS artist_nulls,
    COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE chart IS NULL) AS chart_nulls,
    COUNT(*) FILTER (WHERE trend IS NULL) AS trend_nulls,
    COUNT(*) FILTER (WHERE streams IS NULL) AS streams_nulls
FROM
    spotify_chart;

-- Conclusion from cleaning:
-- The only column with a significant number of NULLs is 'streams'.
-- This is intentional, as the dataset description states that streams are not provided
-- for the 'viral50' chart. The data is otherwise clean and complete.