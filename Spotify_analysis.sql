------------------- Spotify Analysis----------------------------
-------- This Project focuses on different aspects and feartures of spotify which could be useful in getting your favourite song ---------
-------- This dataset include spotify data from 2000 to 2022 -------
-------- Analysis Performed by Syed Sarfaraz Ahmed ---------

--- Check the entire dataset---

SELECT * FROM Spotify.dbo.Spotify_data

---- Number of songs on Spotify for each artist -----

SELECT artist_name, COUNT(*) AS Number_of_Songs FROM Spotify.dbo.Spotify_data
GROUP BY artist_name
ORDER BY COUNT(*) DESC

---- Top 10 songs based on popularity ------

SELECT DISTINCT TOP 10 track_name, album, artist_name, year, track_popularity AS popularity FROM Spotify.dbo.Spotify_data ORDER BY popularity DESC

---- Total number of songs on spotify based on year -----

SELECT year, COUNT(track_name) AS Number_of_Songs FROM Spotify.dbo.Spotify_data GROUP BY year ORDER BY year DESC

---- Top song for each year (2000-2022) based on popularity

SELECT year, track_name, album, artist_name, track_popularity AS popularity
FROM (
  SELECT year, track_name, album, artist_name, track_popularity,
    ROW_NUMBER() OVER (PARTITION BY year ORDER BY track_popularity DESC) AS rank
  FROM Spotify.dbo.Spotify_data
) ranked_songs
WHERE rank = 1

---- Analysis based on Tempo ----

SELECT AVG(tempo) AS Avg_tempo FROM Spotify.dbo.Spotify_data

SELECT track_name, tempo,
             (CASE 
             WHEN tempo > 121.08 THEN 'Above Average Tempo'
             WHEN tempo = 121.08 THEN 'Average Tempo'
             WHEN tempo < 121.08 THEN 'Below Average Tempo'
             END) AS TempoAverage
FROM Spotify.dbo.Spotify_data

---- Songs with Highest Tempo ----

SELECT TOP 10 track_name, tempo FROM Spotify.dbo.Spotify_data ORDER BY tempo DESC

---- Number of Songs for different Tempo Range ----

SELECT
      SUM(CASE
          WHEN tempo BETWEEN 60.00 AND 100.00 THEN 1
          ELSE 0
      END) AS Classical_Music,
      SUM(CASE
          WHEN (tempo BETWEEN 100.001 AND 120.00) THEN 1
          ELSE 0
      END) AS Modern_Music,
      SUM(CASE
          WHEN (tempo BETWEEN 120.001 AND 150.01) THEN 1
          ELSE 0
      END) AS Dance_Music,
      SUM(CASE
          WHEN (tempo < 150.01) THEN 1
          ELSE 0
      END) AS HighTempo_Music
FROM Spotify.dbo.Spotify_data

---- Energy Analysis ----

SELECT AVG(energy) AS Average_Energy FROM Spotify.dbo.Spotify_data

-- Another Way of doing it
--SELECT TOP 10 track_name, energy,
--(CASE
--     WHEN energy > 0.64 THEN 'Above Average'
--     WHEN energy = 0.64 THEN 'Average'
--     WHEN energy < 0.64 THEN 'Below Average'
--END) AS CompareAverage
--FROM Spotify.dbo.Spotify_data



SELECT track_name, energy,
(CASE 
     WHEN energy BETWEEN 0.1 AND 0.3 THEN 'Calm Music'
     WHEN (energy BETWEEN 0.3 AND 0.6) THEN 'Moderate Music'
     ELSE 'Energetic Music'
END) AS EnergyAverage
FROM Spotify.dbo.Spotify_data

---- Number of Songs for different energy ranges ----
SELECT
SUM(CASE
    WHEN (energy BETWEEN 0.0 AND 0.3) THEN 1
    ELSE 0
END) AS Calm_Music,
SUM(CASE
    WHEN (energy BETWEEN 0.3 AND 0.6) THEN 1
    ELSE 0
END) AS Moderate_Music,
SUM(CASE
    WHEN (energy BETWEEN 0.6 AND 1) THEN 1
    ELSE 0
END) AS Energetic_Music
FROM Spotify.dbo.Spotify_data

---- Danceability Analysis ----

SELECT AVG(danceability) AS Avg_danceability FROM Spotify.dbo.Spotify_data

SELECT TOP 10 track_name, danceability, track_popularity AS popularity,
(CASE 
     WHEN energy > 0.68 THEN 'Above Average'
     WHEN energy = 0.68 THEN 'Average'
     WHEN energy < 0.68 THEN 'Below Average'
END) AS CompareAverage
FROM Spotify.dbo.Spotify_data
ORDER BY popularity DESC

SELECT TOP 20 track_name, danceability, 
             (CASE 
             WHEN danceability BETWEEN 0.69 AND 0.79 THEN 'Low Danceability'
             WHEN (danceability BETWEEN 0.49 AND 0.68) OR (danceability BETWEEN 0.79 AND 0.89) THEN 'Moderate Danceability'
             WHEN (danceability BETWEEN 0.39 AND 0.49) OR (danceability BETWEEN 0.89 AND 0.99) THEN 'High Danceability'
             ELSE 'Cant Dance on this one'
             END) AS CompareAverage
             FROM Spotify.dbo.Spotify_data
             ORDER BY track_popularity DESC

SELECT
      SUM(CASE
          WHEN danceability BETWEEN 0.59 AND 0.79 THEN 1
          ELSE 0
      END) AS LowDanceability,
      SUM(CASE
          WHEN (danceability BETWEEN 0.49 AND 0.59) OR (danceability BETWEEN 0.79 AND 0.89) THEN 1
          ELSE 0
      END) AS ModerateDanceability,
      SUM(CASE
          WHEN (danceability BETWEEN 0.39 AND 0.49) OR (danceability BETWEEN 0.89 AND 1.00) THEN 1
          ELSE 0
      END) AS HighDanceability,
      SUM(CASE
          WHEN (danceability < 0.39) OR (danceability > 0.99) THEN 1
          ELSE 0
      END) AS Cant_dance_on_this_one
FROM Spotify.dbo.Spotify_data

---- Loudness Analysis ----

SELECT MIN(loudness) FROM Spotify.dbo.Spotify_data

SELECT track_name, loudness,
             (CASE 
             WHEN loudness > -5.80 THEN 'Above Average'
             WHEN loudness = -5.80 THEN 'Average'
             WHEN loudness < -5.80 THEN 'Below Average'
             END) AS CompareAverage
FROM Spotify.dbo.Spotify_data

SELECT track_name, loudness,
             (CASE 
             WHEN loudness BETWEEN -23.00 AND -15.00 THEN 'Low Loudness'
             WHEN loudness BETWEEN -14.99 AND -6.00 THEN 'Below Average Loudness'
             WHEN loudness BETWEEN -5.99 AND -2.90 THEN 'Above Average Loudness'
             ELSE 'Peak Loudness'
             END) AS CompareAverage_DB
FROM Spotify.dbo.Spotify_data

SELECT
      SUM(CASE WHEN loudness BETWEEN -23.00 AND -15.00 THEN 1
          ELSE 0
      END) AS Low_Loudness,
      SUM(CASE WHEN loudness BETWEEN -14.99 AND -6.00 THEN 1
          ELSE 0
      END) AS Below_Avg_loudness,
      SUM(CASE WHEN loudness BETWEEN -5.99 AND -2.90 THEN 1
          ELSE 0
      END) AS Above_Avg_loudness,
      SUM(CASE WHEN loudness BETWEEN -2.89 AND -1.00 THEN 1
          ELSE 0
      END) AS High_loudness
FROM Spotify.dbo.Spotify_data

---- Valence Analysis ----

SELECT AVG(valence) AS Avg_Valence FROM Spotify.dbo.Spotify_data

SELECT track_name, valence,
(CASE 
     WHEN valence > 0.535 THEN 'Above Average'
     WHEN valence = 0.535 THEN 'Average'
     WHEN valence < 0.535 THEN 'Below Average'
END) AS CompareAverage
FROM Spotify.dbo.Spotify_data

SELECT track_name, valence, track_popularity AS popularity,
             (CASE 
                WHEN valence BETWEEN 0.00 AND 0.250 THEN 'Low Valence'
                WHEN valence BETWEEN 0.251 AND 0.500 THEN 'Below Avg Valence'
                WHEN valence BETWEEN 0.501 AND 0.750 THEN 'Above Avg Valence'
                ELSE 'High Valence'
             END) AS Valence_Avg
FROM Spotify.dbo.Spotify_data
ORDER BY popularity DESC

SELECT
      SUM(CASE WHEN valence BETWEEN 0.000 AND 0.250 THEN 1
          ELSE 0
      END) AS Within4,
      SUM(CASE WHEN valence BETWEEN 0.251 AND 0.500 THEN 1
          ELSE 0
      END) AS Below_Avg_Valence,
      SUM(CASE
          WHEN valence BETWEEN 0.501 AND 0.750 THEN 1
          ELSE 0
      END) AS Above_avg_Valence,
      SUM(CASE
          WHEN (liveness < 1.000) OR (liveness >= 0.751) THEN 1
          ELSE 0
      END) AS High_Valence
FROM Spotify.dbo.Spotify_data

---- Speechiness Analsis ----

SELECT AVG(speechiness) FROM Spotify.dbo.Spotify_data

SELECT track_name, speechiness, tempo,
(CASE 
     WHEN speechiness > 0.081 THEN 'Above Average'
     WHEN speechiness = 0.081 THEN 'Average'
     WHEN speechiness < 0.081 THEN 'Below Average'
END) AS CompareAverage
FROM Spotify.dbo.Spotify_data
ORDER BY tempo DESC

SELECT track_name, speechiness, track_popularity AS popularity,
(CASE 
     WHEN speechiness > 0.081 THEN 'Above Average'
     WHEN speechiness = 0.081 THEN 'Average'
     WHEN speechiness < 0.081 THEN 'Below Average'
END) AS CompareAverage
FROM Spotify.dbo.Spotify_data
ORDER BY popularity DESC

---- Acoustic Analysis ----

SELECT DISTINCT TOP 25 track_name, album, artist_name, acousticness FROM Spotify.dbo.Spotify_data ORDER BY acousticness DESC

SELECT track_name, acousticness, track_popularity AS popularity,
             (CASE 
                WHEN acousticness BETWEEN 0 AND 0.40000 THEN 'Not Acoustic'
                WHEN (acousticness BETWEEN 0.40001 AND 0.80000) THEN 'Acoustic'
                WHEN (acousticness BETWEEN 0.80001 AND 1) THEN 'Highly Acoustic'
             END) AS CompareAverage
FROM Spotify.dbo.Spotify_data


