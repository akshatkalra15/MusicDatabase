-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS music_store;

-- CREATING TABLES

-- ARTIST TABLE
CREATE TABLE IF NOT EXISTS artist (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- ALBUM TABLE
CREATE TABLE IF NOT EXISTS album (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    artist_id INT NOT NULL,
    FOREIGN KEY (artist_id) references artist(id)
);

-- PLAYLIST TABLE
CREATE TABLE IF NOT EXISTS playlist (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL 
);

-- MEDIA TYPE TABLE
CREATE TABLE IF NOT EXISTS media_type (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- GENRE TABLE
CREATE TABLE IF NOT EXISTS genre (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

-- TRACK TABLE

CREATE TABLE IF NOT EXISTS track(
	id INT PRIMARY KEY AUTO_INCREMENT ,
    name VARCHAR(100) NOT NULL,
    album_id INT ,
    media_type_id INT NOT NULL,
    genre_id INT NOT NULL,
    composer VARCHAR(100),
    milliseconds INT UNSIGNED,
    bytes INT UNSIGNED,
    unit_price DECIMAL(4,2) UNSIGNED,
    FOREIGN KEY (album_id) REFERENCES album(id),
    FOREIGN KEY (media_type_id) REFERENCES media_type(id),
    FOREIGN KEY (genre_id) REFERENCES genre(id)
);

-- PLAYLIST TRACK TABLE
CREATE TABLE IF NOT EXISTS playlist_track (
	track_id INT ,
    playlist_id INT ,
    FOREIGN KEY (playlist_id) references playlist(id),
    FOREIGN KEY (track_id) references track(id),
    PRIMARY KEY(playlist_id, track_id)
);

-- EMPLOYEE TABLE
CREATE TABLE IF NOT EXISTS employee (
	id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    reports_to INT ,
    levels CHAR(2) NOT NULL,
    birth_date DATE,
    hire_date DATE,
    address VARCHAR(100),
    city VARCHAR(30),
    state VARCHAR(30),
    country VARCHAR(30),
    postal_code CHAR(7),
    phone CHAR(17),
    fax CHAR(17),
    email VARCHAR(50),
    FOREIGN KEY (reports_to) REFERENCES employee(id)
);

-- CUSTOMER TABLE
CREATE TABLE IF NOT EXISTS customer (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    company VARCHAR(50) NOT NULL,
    address VARCHAR(100),
    city VARCHAR(30),
    state VARCHAR(30),
    country VARCHAR(30),
    postal_code CHAR(7),
    phone CHAR(17),
    fax CHAR(17),
    email VARCHAR(50),
    support_rep_id INT,
    FOREIGN KEY (support_rep_id) REFERENCES employee(id)
);

-- INVOICE TABLE
CREATE TABLE IF NOT EXISTS invoice(
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    invoice_date DATE NOT NULL,
    billing_address VARCHAR(100),
    billing_city VARCHAR(30),
    billing_state VARCHAR(30),
    billing_country VARCHAR(30),
    billing_postal_code CHAR(7),
    total FLOAT ,
    FOREIGN KEY (customer_id) REFERENCES customer(id)
);

-- Invoice Line Table
CREATE TABLE IF NOT EXISTS invoice_line (
	id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_id INT,
    track_id INT,
    unit_price DECIMAL(5,2),
    quantity INT,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id),
    FOREIGN KEY (track_id) REFERENCES track(id)
);