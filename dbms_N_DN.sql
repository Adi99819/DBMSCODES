CREATE TABLE Stud (
    Roll INT PRIMARY KEY,
    Att DECIMAL(5,2),
    Status VARCHAR(2)
);

INSERT INTO Stud (Roll, Att, Status) VALUES 
(1, 80.00, 'ND'),
(2, 70.00, 'ND'),
(3, 85.00, 'ND'),
(4, 60.00, 'ND'),
(5, 90.00, 'ND');

DELIMITER //

CREATE PROCEDURE CheckAttendancee(IN roll_no INT)
BEGIN
    DECLARE attendance DECIMAL(5,2);
    DECLARE exit_code INT DEFAULT 0;

    -- Declare an exit handler for handling exceptions
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        SET exit_code = 1;
        SELECT 'An error occurred while checking attendance.' AS ErrorMessage;
    END;

    -- Select attendance for the given roll number
    SELECT Att INTO attendance FROM Stud WHERE Roll = roll_no;

    -- Check if attendance was retrieved
    IF attendance IS NULL THEN
        SELECT 'Roll number does not exist.' AS ErrorMessage;
    ELSE
        -- Control structure to check attendance
        IF attendance < 75 THEN
            -- If attendance is less than 75%
            UPDATE Stud SET Status = 'D' WHERE Roll = roll_no;
            SELECT 'Term not granted' AS Message;
        ELSE
            -- If attendance is 75% or more
            UPDATE Stud SET Status = 'ND' WHERE Roll = roll_no;
            SELECT 'Term granted' AS Message;
        END IF;
    END IF;

END //

DELIMITER ;

CALL CheckAttendancee(1);  -- Replace 2 with the roll number you want to check

