USE InventoryManagerment;

DELIMITER $$

CREATE TRIGGER Before_Insert_Product
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
         SIGNAL SQLSTATE '45000'
         SET MESSAGE_TEXT = 'Số lượng sản phẩm không hợp lệ';
	END IF;
END $$

DELIMITER ;

INSERT INTO Products (product_name, quantity)
VALUES ('Test', -5);