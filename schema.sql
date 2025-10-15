-- Drop the table if it already exists to ensure a clean setup for a new import.
DROP TABLE IF EXISTS public.spotify_chart;

-- Create the table structure for the Spotify chart data.
CREATE TABLE public.spotify_chart (
    title       TEXT,
    rank        INT,
    date_chart  DATE,
    artist      TEXT,
    url         TEXT,
    region      VARCHAR(150),
    chart       VARCHAR(150),
    trend       VARCHAR(50),
    streams     BIGINT -- Using BIGINT as stream counts can exceed the standard integer limit.
);

-- Note: The 'streams' column will have NULL values for the 'viral50' chart type,
-- which is expected behavior for this dataset.