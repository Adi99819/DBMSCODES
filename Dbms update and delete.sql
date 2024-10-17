CREATE TABLE Library (
    ISBN int PRIMARY KEY,
    Book_Name VARCHAR(255),
    Amount DECIMAL(10, 2),
    Writer_Name VARCHAR(255)
);
CREATE TABLE Library_Audit (
    
    ISBN int,
    Book_Name VARCHAR(255),
    Amount DECIMAL(10, 2),
    Writer_Name VARCHAR(255)
    
);
DELIMITER //

CREATE TRIGGER before_library_delete
BEFORE DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (ISBN, Book_Name, Amount, Writer_Name)
    VALUES (OLD.ISBN, OLD.Book_Name, OLD.Amount, OLD.Writer_Name);
END; //

DELIMITER ;

DELIMITER //
CREATE TRIGGER update_library_delete
BEFORE UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (ISBN, Book_Name, Amount, Writer_Name)
    VALUES (OLD.ISBN, OLD.Book_Name, OLD.Amount, OLD.Writer_Name);
END; //

DELIMITER ;



INSERT INTO Library (ISBN, Book_Name, Amount, Writer_Name) VALUES 
('1', 'The Great Gatsby', 10.99, 'F. Scott Fitzgerald'),
('2', '1984', 15.99, 'George Orwell');

DELETE FROM Library WHERE ISBN = '1';

update Library SET Book_Name='DBMS' where isbn = '2';
select * from library;
select * from Library_Audit;


