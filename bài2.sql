USE InventoryManagerment;

DELIMITER $$
CREATE TRIGGER Before_product_delete
BEFORE DELETE ON Products 
FOR EACH ROW 
BEGIN 

    IF OLD.quantity > 10 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Không thể xóa sản phẩm có số lượng lớn hơn 10';
	END IF;
END $$
DELIMITER ;

INSERT INTO Products (productID, product_name, quantity)
VALUES (2,'Mouse',20);

DELETE FROM Products
WHERE productID = 2;
