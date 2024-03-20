-- Create table for artists
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create table for albums
CREATE TABLE albums (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist_id INT REFERENCES artists(artist_id),
    release_year INT,
    genre VARCHAR(100)
);

-- Create table for tracks
CREATE TABLE tracks (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    album_id INT REFERENCES albums(album_id),
    duration TIME
);

-- Insert some sample data
INSERT INTO artists (name) VALUES
    ('The Beatles'),
    ('Pink Floyd'),
    ('Led Zeppelin');

INSERT INTO albums (title, artist_id, release_year, genre) VALUES
    ('Abbey Road', 1, 1969, 'Rock'),
    ('Dark Side of the Moon', 2, 1973, 'Progressive Rock'),
    ('Led Zeppelin IV', 3, 1971, 'Hard Rock');

INSERT INTO tracks (title, album_id, duration) VALUES
    ('Come Together', 1, '04:20'),
    ('Here Comes the Sun', 1, '03:05'),
    ('Money', 2, '06:23'),
    ('Time', 2, '06:53'),
    ('Stairway to Heaven', 3, '08:02');

