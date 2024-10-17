CREATE TABLE N_RollCall (
    Roll INT PRIMARY KEY,
    Name VARCHAR(255)
);

CREATE TABLE O_RollCall (
    Roll INT PRIMARY KEY,
    Name VARCHAR(255)
);

INSERT INTO N_RollCall (Roll, Name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva');

INSERT INTO O_RollCall (Roll, Name) VALUES
(3, 'Charlie'),  
(6, 'Frank');


DELIMITER //

CREATE PROCEDURE MergeRollCall()
BEGIN
    DECLARE v_roll INT;
    DECLARE v_name VARCHAR(255);

    -- Declare a cursor for the N_RollCall table
    DECLARE cur CURSOR FOR 
        SELECT Roll, Name FROM N_RollCall;

    -- Declare a NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_roll = NULL;

    -- Open the cursor
    OPEN cur;

    -- Loop through the records in the cursor
    read_loop: LOOP
        FETCH cur INTO v_roll, v_name;

        -- If there are no more rows, exit the loop
        IF v_roll IS NULL THEN
            LEAVE read_loop;
        END IF;

        -- Check if the record exists in O_RollCall
        IF NOT EXISTS (SELECT 1 FROM O_RollCall WHERE Roll = v_roll) THEN
            -- Insert into O_RollCall if the roll number does not already exist
            INSERT INTO O_RollCall (Roll, Name) VALUES (v_roll, v_name);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END //

DELIMITER ;

CALL MergeRollCall();

select * from O_RollCall;

