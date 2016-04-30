CREATE TRIGGER updateOrdersOrderTotalsTrig 
ON Orders AFTER INSERT, UPDATE, DELETE AS
BEGIN
  UPDATE Orders
  SET OrderTotal = (
      SELECT SUM(QuantityOrdered * QuotedPrice) 
	FROM Order_Details OD
       WHERE OD.OrderNumber = Orders.OrderNumber
  )
  WHERE Orders.OrderNumber IN (
    SELECT OrderNumber FROM deleted
    UNION
    SELECT OrderNumber FROM inserted
  );
END;

DROP TRIGGER updateOrdersOrderTotalsTrig;
