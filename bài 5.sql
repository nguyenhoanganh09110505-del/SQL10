CREATE DATABASE IF NOT EXISTS OrderManagement;
USE OrderManagement;

CREATE TABLE Orders (
    order_id INt PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    total_amount DECIMAL(10,2),
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(50)
);

CREATE TABLE Order_logs (
	log_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

DELIMITER $$

CREATE TRIGGER After_order_status_update
AFTER UPDATE ON Orders
FOR EACH ROW 
BEGIN 
    IF OLD.order_status <>NEW.order_status THEN 
    
        INSERT INTO Order_logs (
            order_id,
            old_status,
            new_status
		)
        VALUES (
             NEW.order_id,
             OLD.order_status,
             NEW.order_status
		);
	END IF;
END $$

DELIMITER ;


INSERT INTO Orders ( 
	customer_name,
    total_amount,
    order_status
)
VALUES ('Nguyen Van B', 300000, 'Pending');
UPDATE Orders
SET order_status = 'Shipping'
WHERE order_id = 2;
