
-- If we are re-running this script, make sure to clean up the old
--  tables before we attempt to re-create them.

DROP TABLE IF EXISTS Song;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Genre;


-- Create new tables

CREATE TABLE Genre (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Label VARCHAR(55) NOT NULL
);

CREATE TABLE Artist (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    ArtistName VARCHAR(55) NOT NULL,
    YearEstablished INTEGER NOT NULL
);

CREATE TABLE Album (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Title VARCHAR(55) NOT NULL,
    ReleaseDate VARCHAR(55) NOT NULL,
    AlbumLength INTEGER NOT NULL,
    Label VARCHAR(55) NOT NULL,
    ArtistId INTEGER NOT NULL,
    GenreId INTEGER,
    CONSTRAINT FK_Album_Artist FOREIGN KEY(ArtistId) REFERENCES Artist(Id),
    CONSTRAINT FK_Album_Genre FOREIGN KEY(GenreId) REFERENCES Genre(Id)
);

CREATE TABLE Song (
    Id INTEGER NOT NULL PRIMARY KEY IDENTITY,
    Title VARCHAR(55) NOT NULL,
    SongLength INTEGER NOT NULL,
    ReleaseDate VARCHAR(55) NOT NULL,
    GenreId INTEGER,
    ArtistId INTEGER NOT NULL,
    AlbumId INTEGER NOT NULL,
    CONSTRAINT FK_Song_Genre FOREIGN KEY(GenreId) REFERENCES Genre(Id),
    CONSTRAINT FK_Song_Artist FOREIGN KEY(ArtistId) REFERENCES Artist(Id),
    CONSTRAINT FK_Song_Album FOREIGN KEY(AlbumId) REFERENCES Album(Id)
);


-- Add some data to the tables

INSERT INTO Genre (Label) VALUES ('Soul');
INSERT INTO Genre (Label) VALUES ('Rock');
INSERT INTO Genre (Label) VALUES ('Blues');
INSERT INTO Genre (Label) VALUES ('Jazz');
INSERT INTO Genre (Label) VALUES ('Heavy Metal');
INSERT INTO Genre (Label) VALUES ('R&B');
INSERT INTO Genre (Label) VALUES ('Pop');
INSERT INTO Genre (Label) VALUES ('Bluegrass');
INSERT INTO Genre (Label) VALUES ('Punk');
INSERT INTO Genre (Label) VALUES ('Classical');
INSERT INTO Genre (Label) VALUES ('Country');
INSERT INTO Genre (Label) VALUES ('Latin');
INSERT INTO Genre (Label) VALUES ('Rap');
INSERT INTO Genre (Label) VALUES ('Electronic');

INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Judas Priest', 1969);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Def Leppard', 1977);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('ZZTop', 1969);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Genesis', 1967);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Journey', 1973);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Beatles', 1960);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Howlin'' Wolf', 1959);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Black Flag', 1981);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Porcupine Tree', 1987);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Grateful Dead', 1965);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('The Shins', 1996);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Rush', 1968);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('The Features', 1998);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Squeeze', 1977);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Midnight Oil', 1976);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Dire Straits', 1977);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Hoodoo Gurus', 1981);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('U2', 1976);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Mayer Hawthorne', 2009);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('David Bowie', 1968);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Sigur Ros', 1997);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('deadmau5', 2006);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Justice', 2007);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Miles Davis', 1948);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('The Sheepdogs', 2006);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Coheed & Cambria', 2001);
INSERT INTO Artist (ArtistName, YearEstablished) VALUES ('Jay Z', 1986);

INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('The Black Album', '11/14/2003', 2268, 'Def Jam', 27, 13);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('A Strange Arrangement', '09/08/2009', 2082, 'Stones Throw Records', 19, 1);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('How Do You Do', '10/11/2011', 2357, 'Stones Throw Records', 19, 1);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Where Does This Door Go', '06/16/2013', 3114, 'Stones Throw Records', 19, 1);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Revolver', '08/05/1966', 2083, 'Parlophone', 6, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Sgt. Pepper''s Lonely Hearts Club Band', '06/01/1967', 2392, 'Stones Throw Records', 6, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Magical Mystery Tour', '11/27/1967', 1148, 'Stones Throw Records', 6, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Screaming for Vengeance', '06/17/1982', 2322, 'Columbia', 1, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Point of Entry', '02/26/1981', 2262, 'Columbia', 1, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Defenders of the Faith', '01/04/1984', 2383, 'Columbia', 1, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Round About Midnight', '03/06/1957', 2327, 'Columbia', 24, 4);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Miles Ahead', '10/21/1957', 2132, 'Columbia', 24, 4);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Milestones', '09/02/1958', 2856, 'Columbia', 24, 4);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Moanin'' in the Moonlight', '05/14/1959', 2033, 'Chess', 7, 3);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Howlin'' Wolf', '10/21/1957', 1917, 'Chess', 7, 3);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('The Howlin'' Wolf Album', '09/02/1969', 2459, 'Chess', 7, 3);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Eliminator', '3/23/1983', 2668, 'Warner Bros.', 3, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Afterburner', '1/1/2011', 417, 'Warner Bros.', 3, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Tres Hombres', '6/14/1979', 321, 'Warner Bros.', 3, 2);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Damaged', '12/05/1981', 2098, 'SST', 8, 9);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('TV Party', '07/12/1982', 409, 'SST', 8, 9);
INSERT INTO Album (Title, ReleaseDate, AlbumLength, Label, ArtistId, GenreId) VALUES ('Everything Went Black', '12/03/1982', 3718, 'SST', 8, 9);

INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Revenge', 61, '12/03/1982', 9, 8, 22);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('White Minority', 69, '12/03/1982', 9, 8, 22);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Gimme Gimme Gimme', 120, '12/03/1982', 9, 8, 22);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('No Values', 118, '12/03/1982', 9, 8, 22);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('TV Party', 232, '06/12/1982', 9, 8, 21);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('I''ve Got To Run', 105, '06/12/1982', 9, 8, 21);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('My Rules', 71, '06/12/1982', 9, 8, 21);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Gimme All Your Lovin', 507, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Sharp Dressed Man', 419, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Legs', 309, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('I Need You Tonight', 470, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('TV Dinners', 539, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Thug', 925, '3/23/1983', 2, 3, 17);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Taxman', 714, '8/5/1966', 7, 6, 5);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Eleanor Rigby', 807, '8/5/1966', 7, 6, 5);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Good Day Sunshine', 350, '8/5/1966', 7, 6, 5);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Got To Get You Into My Life', 574, '8/5/1966', 7, 6, 5);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Interlude', 237, '12/03/1982', 13, 27, 1);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('What More Can I Say', 150, '12/03/1982', 13, 27, 1);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Encore', 260, '12/03/1982', 13, 27, 1);
INSERT INTO Song (Title, SongLength, ReleaseDate, GenreId, ArtistId, AlbumId) VALUES ('Dirt Off Your Shoulder', 851, '12/03/1982', 13, 27, 1);

