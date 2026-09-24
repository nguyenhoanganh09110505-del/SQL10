CREATE DATABASE InventoryManagerment;
USE InventoryManagerment;

CREATE TABLE Products (
     productID INT PRIMARY KEY AUTO_INCREMENT,
     product_name VARCHAR(100),
     quantity INT
);

CREATE TABLE Inventorychanges (
     changeID INT PRIMARY KEY AUTO_INCREMENT,
     productID INT,
     oldQuantity INT,
     newQuantity INT,
     changeDate DATETIME,
	 
     FOREIGN KEY (productID)
     REFERENCES Products(productID)
);

INSERT INTO Products (product_name, quantity)
VALUES
('Laptop',10),
('Mouse',20),
('Keyboard',15);
     
DELIMITER $$

CREATE TRIGGER After_product_update
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity THEN
    
    INSERT INTO Inventorychanges (
         productID,
         oldQuantity,
         newQuantity,
         changeDate
    )
    VALUES (
         NEW.productID,
         OLD.quantity,
         NEW.quantity,
         NOW()
	);
    END IF;
END $$
DELIMITER ;

SELECT * FROM Products;

UPDATE Products
SET quantity = 10
WHERE productID = 1;
SELECT * FROM Inventorychanges;
         