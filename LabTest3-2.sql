
-- Obtain list of all the orders placed for parts after a given date as a user input
SELECT *
FROM Parts_Order
WHERE OrderDate > '2022-02-01'; -- Assuming user input is '2022-02-01'


-- Find the number of parts in the Part table which belong to a given part type
SELECT COUNT(*)
FROM Part
WHERE PartType = 'Mechanical'; -- Assuming we want to find the number of Mechanical parts


-- Obtain a list of all the manufacturers with their names and addresses in the alphabetical order of the name of the manufacturer
SELECT MName, Address
FROM Manufacturer
ORDER BY MName ASC;


--  Increase the unit price of the parts by Rs.50/- of all those which have the available quantity more than 5
UPDATE Part
SET UnitPrice = UnitPrice + 50
WHERE AvailableQuantity > 5;

-- Add a new column to the Parts_Order table as “DeliveryDate” to keep track of the latest date on which the delivery needs to be done
ALTER TABLE Parts_Order ADD DeliveryDate DATE;

-- Delete all the records pertaining to the parts which are having the available quantity less than or equal to one
DELETE FROM Part WHERE  AvailableQuantity<=1;

