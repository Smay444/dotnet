USE master
GO

-- Drop database if it exists
IF DB_ID('mobile_bookshelf') IS NOT NULL
BEGIN
    ALTER DATABASE mobile_bookshelf SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE mobile_bookshelf;
END

-- Create database
CREATE DATABASE mobile_bookshelf;
GO

USE mobile_bookshelf;
GO

-- Create tables
CREATE TABLE users (
    user_id int IDENTITY(1,1) NOT NULL,
    username varchar(50) NOT NULL,
    password_hash varchar(200) NOT NULL,
    salt varchar(200) NOT NULL,
    user_role varchar(50) NOT NULL,
    user_email varchar(100) NOT NULL,
    CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE read_books (
    read_books_id INT IDENTITY (2,2) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES users(user_id),
    cover_image VARCHAR(500),
    title VARCHAR(255),
    author VARCHAR (100),
    summary TEXT,
    rating INT CHECK (rating >= 1 AND rating <=5),
    spice_rating INT CHECK (spice_rating >=1 AND spice_rating <= 5),
    date_completed DATETIME,
    CONSTRAINT FK_ReadBooks_UserID FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE toBeRead_books (
    TBR_books_id INT IDENTITY (1,1) PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES users(user_id),
    cover_image VARCHAR(500),
    title VARCHAR(255),
    author VARCHAR(255),
    CONSTRAINT FK_ToBeReadBooks_UserID FOREIGN KEY (user_id) REFERENCES users(user_id) 
);

CREATE TABLE currently_reading (
    currently_reading_bookId INT PRIMARY KEY IDENTITY (1,1),
    user_id INT NOT NULL,
    cover_image VARCHAR(500),
    title VARCHAR(255),
    author VARCHAR(255)
);
GO

-- Populate default data
INSERT INTO users (username, password_hash, salt, user_role, user_email)
VALUES ('user', 'Jg45HuwT7PZkfuKTz6IB90CtWY4=', 'LHxP4Xh7bN0=', 'user', 'user@example.com');

INSERT INTO users (username, password_hash, salt, user_role, user_email)
VALUES ('admin', 'YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=', 'admin', 'admin@example.com');
