============================================
a. CLIENT_MASTER
============================================

CREATE TABLE Client_master_21340425026(
  Client_no VARCHAR2(6) PRIMARY KEY CHECK (Client_no LIKE 'C%'),
  Name VARCHAR2(30) NOT NULL,
  Address1 VARCHAR2(30),
  Address2 VARCHAR2(30),
  City VARCHAR2(15),
  State VARCHAR2(15),
  Pincode NUMBER(6),
  Balance_due NUMBER(10,2)
);

INSERT INTO Client_master_21340425026 VALUES('C001', 'Ivan Bayross', 'P-76', 'Worli', 'Bombay', 'Maharastra', 400054, 15000);
INSERT INTO Client_master_21340425026 VALUES('C002', 'Vandana Satiwal', '128', 'Adams Street', 'Madras', 'TamilNadu', 780001, 0);
INSERT INTO Client_master_21340425026 VALUES('C003', 'Pramada Jaguste', '157', 'Gopalpur', 'Kolkata', 'West Bengal', 700058, 5000);
INSERT INTO Client_master_21340425026 VALUES('C004', 'Basu Navindgi', 'A/12', 'Nariman', 'Bombay', 'Maharastra', 400056, 0);
INSERT INTO Client_master_21340425026 VALUES('C005', 'Ravi Sreedharan', 'B/34', 'Rajnagar', 'Delhi', 'Delhi', 100001, 2000);
INSERT INTO Client_master_21340425026 VALUES('C006', 'Rukmini', 'Q-12', 'Bandra', 'Bombay', 'Maharastra', 400050, 0);

COMMIT;


============================================
b. PRODUCT_MASTER
============================================

CREATE TABLE Product_master_21340425026(
  Product_no VARCHAR2(6) PRIMARY KEY CHECK (Product_no LIKE 'P%'),
  Description VARCHAR2(40) NOT NULL,
  Profit_percent NUMBER(4,2) NOT NULL,
  Unit_measure VARCHAR2(20) NOT NULL,
  Qty_on_hand NUMBER(10) NOT NULL,
  Reorder_level NUMBER(10) NOT NULL,
  Sell_price NUMBER(10,2) NOT NULL CHECK(Sell_price>0),
  Cost_price NUMBER(10,2) NOT NULL CHECK(Cost_price>0)
);

INSERT INTO Product_master_21340425026 VALUES('P00001', '1.44 Floppies', 5, 'Piece', 100, 20, 525, 500);
INSERT INTO Product_master_21340425026 VALUES('P03453', 'Monitors', 6, 'Piece', 10, 3, 12000, 11280);
INSERT INTO Product_master_21340425026 VALUES('P06734', 'Mouse', 5, 'Piece', 20, 5, 1050, 1000);
INSERT INTO Product_master_21340425026 VALUES('P07865', '1.22 Floppies', 5, 'Piece', 100, 20, 525, 500);
INSERT INTO Product_master_21340425026 VALUES('P07868', 'Keyboard', 2, 'Piece', 10, 3, 3150, 3050);
INSERT INTO Product_master_21340425026 VALUES('P07885', 'CD Drive', 2.5, 'Piece', 10, 3, 5250, 5100);
INSERT INTO Product_master_21340425026 VALUES('P07965', '540 HDD', 4, 'Piece', 10, 3, 8400, 8000);
INSERT INTO Product_master_21340425026 VALUES('P07975', '1.44 Drive', 5, 'Piece', 10, 3, 1050, 900);
INSERT INTO Product_master_21340425026 VALUES('P08865', '1.22 Drive', 5, 'Piece', 2, 3, 1025, 850);

COMMIT;


============================================
c. SALESMAN_MASTER
============================================

CREATE TABLE Salesman_master_21340425026(
  Salesman_no VARCHAR2(6) PRIMARY KEY CHECK (Salesman_no LIKE 'S%'),
  Salesman_name VARCHAR2(20) NOT NULL,
  Address1 VARCHAR2(20) NOT NULL,
  Address2 VARCHAR2(20),
  City VARCHAR2(15),
  Pincode NUMBER(10),
  State VARCHAR2(20),
  Sal_amt NUMBER(10,2)
);

INSERT INTO Salesman_master_21340425026 VALUES('S001', 'Kiran', 'A/14', 'Worli', 'Bombay', 400002, 'Maharastra', 3000);
INSERT INTO Salesman_master_21340425026 VALUES('S002', 'Manish', '65', 'Nariman', 'Bombay', 400001, 'Maharastra', 3000);
INSERT INTO Salesman_master_21340425026 VALUES('S003', 'Ravi', 'P-7', 'Bandra', 'Bombay', 400032, 'Maharastra', 3000);
INSERT INTO Salesman_master_21340425026 VALUES('S004', 'Asish', 'A/5', 'Juhu', 'Bombay', 400044, 'Maharastra', 3000);

COMMIT;


============================================
d. SALES_ORDER
============================================

CREATE TABLE Sales_order_21340425026(
  Order_no VARCHAR2(6) PRIMARY KEY CHECK (Order_no LIKE 'O%'),
  Order_date DATE,
  Client_no VARCHAR2(6) REFERENCES Client_master_21340425026,
  Salesman_no VARCHAR2(6) REFERENCES Salesman_master_21340425026,
  Delivery_type CHAR(1) DEFAULT 'F' CHECK (Delivery_type IN ('P','F')),
  Bill_y_n CHAR(1),
  Delivery_date DATE,
  Order_status VARCHAR2(20) CHECK(Order_status IN ('InProcess','FulFilled','BackOrder','Cancelled')),
  CONSTRAINT CK_Delivery_date_21340425026 CHECK(Delivery_date > Order_date)
);

INSERT INTO Sales_order_21340425026 VALUES ('O19001', '12-Jan-96', 'C001', 'S001', 'F', 'N', '20-Jan-96', 'InProcess');
INSERT INTO Sales_order_21340425026 VALUES ('O19002', '25-Jan-96', 'C002', 'S002', 'P', 'N', '27-Jan-96', 'BackOrder');
INSERT INTO Sales_order_21340425026 VALUES ('O46865', '18-Feb-96', 'C003', 'S003', 'F', 'Y', '20-Feb-96', 'FulFilled');
INSERT INTO Sales_order_21340425026 VALUES ('O19003', '03-Apr-96', 'C001', 'S001', 'F', 'Y', '07-Apr-96', 'FulFilled');
INSERT INTO Sales_order_21340425026 VALUES ('O46866', '20-May-96', 'C004', 'S002', 'P', 'N', '22-May-96', 'Cancelled');
INSERT INTO Sales_order_21340425026 VALUES ('O19008', '24-May-96', 'C005', 'S004', 'F', 'N', '26-May-96', 'InProcess');

COMMIT;


============================================
e. SALES_ORDER_DETAILS
============================================

CREATE TABLE Sales_order_details_21340425026(
  Order_no VARCHAR2(6) REFERENCES Sales_order_21340425026,
  Product_no VARCHAR2(6) REFERENCES Product_master_21340425026,
  Qty_order NUMBER(10),
  Qty_disp NUMBER(10),
  Product_rate NUMBER(10,2)
);

INSERT INTO Sales_ord_det_21340425026 VALUES ('O19001', 'P00001', 4, 4, 525);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19001', 'P07965', 2, 1, 8400);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19001', 'P07885', 2, 1, 5250);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19002', 'P00001', 10, 0, 525);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46865', 'P07868', 3, 3, 3150);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46865', 'P07885', 3, 1, 5250);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46865', 'P00001', 10, 10, 525);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46865', 'P03453', 4, 4, 1050);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19003', 'P03453', 2, 2, 1050);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19003', 'P06734', 1, 1, 12000);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46866', 'P07965', 1, 0, 8400);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O46866', 'P07975', 1, 0, 1050);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19008', 'P00001', 10, 5, 525);
INSERT INTO Sales_ord_det_21340425026 VALUES ('O19008', 'P07975', 5, 3, 1050);
COMMIT;
