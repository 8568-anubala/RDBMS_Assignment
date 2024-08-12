CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR NOT NULL,
    author_id INT,
    publication_year INT,
    genre VARCHAR,
    isbn VARCHAR,
    available_copies INT)

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    nationality VARCHAR(255))
);

 CREATE TABLE  valut( valueat_id INT);
 CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    membership_date DATE
);
 
 CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    actual_return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
 
 CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    contact_number VARCHAR(20),
    email VARCHAR(100),
    hire_date DATE
);
 
 ALTER TABLE Books ADD COLUMN shelf_location VARCHAR(50);
 
 ALTER TABLE Staff RENAME COLUMN position TO job_title;
 
 ALTER TABLE Members DROP COLUMN email;
 
 INSERT INTO Books (book_id, title, author_id, publication_year, genre, isbn, available_copies)
VALUES (1, 'To Kill a Mockingbird', 3, 1960, 'Fiction', '9780060935467', 5);--error
select*from books;

 
 UPDATE Members
SET contact_number = '123-456-7890'
WHERE member_id = 1;
 
 DELETE FROM Loans
WHERE loan_id = 1;
 
 INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date)
VALUES (1, 1, 1, '2024-08-01', '2024-08-15');--error
 
 SELECT B.title, A.first_name, A.last_name
FROM Books B
JOIN Authors A ON B.author_id = A.author_id;
 
 SELECT B.title, M.first_name, M.last_name, L.loan_date, L.return_date
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
JOIN Members M ON L.member_id = M.member_id
WHERE L.actual_return_date IS NULL;
 
 SELECT B.title
FROM Loans L
JOIN Books B ON L.book_id = B.book_id
WHERE L.member_id = 1;
 
 
SELECT genre, COUNT(book_id) AS total_books, SUM(available_copies) AS total_available_copies
FROM Books
GROUP BY genre;
 
 
SELECT first_name, last_name, hire_date
FROM Staff
WHERE job_title = 'Librarian';
 SELECT count(*) FROM information_schema. tables WHERE table_schema NOT IN ('information_schema', 'pg_catalog');
SELECT * FROM pg_catalog.pg_tables WHERE schemaname='public';
