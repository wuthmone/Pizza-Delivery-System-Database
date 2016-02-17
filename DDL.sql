--DDL

CREATE DATABASE PIZZADB;
CONNECT TO PIZZADB;

--DROP DATABASE;

CREATE TABLE PIZZA
(
PIZZA_ID INT PRIMARY KEY NOT NULL,
PIZZA_NAME VARCHAR(20),
PIZZA_DETAILS VARCHAR(50),
PIZZA_PRICE DECIMAL(5,2)
);
 -- DROP TABLE PIZZA;

INSERT INTO PIZZA VALUES
(100,'STROMBOLI','SANDWICH WITH CHILI SAUCE','19.25'),
(101,'THE DETROITER','MINCED ONIONS, GROUND LAMB, CUMIN AND YOGURT','15.99'),
(102,'MARGHERITA','MOZZARELLA CHEESE, FRESH BASIL','12.49'),
(103,'CALZONE', 'DOUGH FOLDED OVER, USUAL PIZZA INGREDIENTS','20.99'),
(104,'RINARA','OIL, TOMATO, GARLIC, AND OREGANO','18.79'),
(105,'THEOME', 'TOMATO, MOZZARELLA CHEESE, AND CUMIN','12.00'),
(106,'HIENDID','MINCED ONIONS,GARLIC,AND YOGURT','7.69');

CREATE TABLE OUTLET
(
OUTLET_ID VARCHAR(6) PRIMARY KEY NOT NULL,
OUTLET_NAME VARCHAR(20),
OUTLET_ZIPCODE INT
);

--DROP TABLE OUTLET;

INSERT INTO OUTLET VALUES 
('A1000','MALIM', 75000),
('A1001','BUKIT BERUANG', 75360),
('A1002','TAMAN MERDEKA', 75480),
('A1003','AYER KEROH', 75449),
('A1004','BUKIT CINA', 75366),
('A1005','TAMAN ASEAN', 75128),
('A1006','MELAKA TENGAH', 75220);


CREATE TABLE VEHICLE
(
VEHICLE_ID VARCHAR(6) PRIMARY KEY NOT NULL,
VEHICLE_PLATE_NUMBER VARCHAR(8),
VEHICLE_TYPE VARCHAR(10)
);

--DROP TABLE VEHICLE;

INSERT INTO VEHICLE VALUES
('1000A','JJJ1249','MOTORCYCLE'),
('1000B','JGF4449','VAN'),
('1001A','WTF8849','MOTORCYCLE'),
('1001B','WGJ5589','MOTORCYCLE'),
('1002A','APK4923','MOTORCYCLE'),
('1002B','WMJ1149','VAN'),
('1002C','JKJ1279','MOTORCYCLE'),
('1003D','WJJ6543','VAN');

CREATE TABLE STAFF
(
STAFF_ID VARCHAR(7) PRIMARY KEY NOT NULL,
STAFF_NAME VARCHAR(30),
STAFF_PHONE VARCHAR(12),
VEHICLE_ID VARCHAR(6),
FOREIGN KEY (VEHICLE_ID) REFERENCES VEHICLE ON DELETE RESTRICT
);

--DROP TABLE STAFF;

INSERT INTO STAFF VALUES
('2AAAA1','JACKY','0127886665','1001A'),
('2AAAA2','ANNIE','0117886665','1001B'),
('2AAAA3','JEFF','0101234567','1002C'),
('2AAAA4','ANTONY','0149102234','1002A'),
('2AAAA5','BECKAM','0176668881','1002C'),
('2AAAA6','JACK','0129004296','1002A'),
('2AAAA7','JOEY','0127186816','1002C');






CREATE TABLE ADDRESS
(
ADDRESS_ID INT PRIMARY KEY NOT NULL,
ADDRESS_UNIT_NUMBER INT,
ADDRESS_STREET VARCHAR(40),
ADDRESS_ZIPCODE INT,
ADDRESS_CITY VARCHAR(20),
ADDRESS_STATE VARCHAR(10)
);

INSERT INTO ADDRESS VALUES 
(11111,01,'JALAN HANG JEBAT',75000,'MALIM','MELAKA'),
(86261,04,'JALAN CHENG HO',75360,'BUKIT BERUANG','MELAKA'),
(68422,06,'JALAN MANGGA',75480,'TAMAN MERDEKA','MELAKA'),
(42561,56,'JALAN MULTIMEDIA',75449,'AYER KEROH','MELAKA'),
(16371,61,'JALAN LIMBONGAN',75366,'BUKIT CINA','MELAKA'),
(12548,33,'JALAN KLEBANG',75128,'TAMAN ASEAN','MELAKA'),
(96411,64,'JALAN TANJUNG MINYAK',75220,'MELAKA TENGAH','MELAKA');

CREATE TABLE CUSTOMER
(
CUSTOMER_ID VARCHAR(6) PRIMARY KEY NOT NULL,
CUSTOMER_NAME VARCHAR(30),
CUSTOMER_PHONE VARCHAR(11),
ADDRESS_ID INT,
FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS ON DELETE RESTRICT
);

INSERT INTO CUSTOMER VALUES 
('AX546','LEE SHU TENG','0123456789',11111),
('NO777','MOHAMMAD ZAIDI','0114568412',86261),
('GH123','NURUL SHAH','0168456347',68422),
('RE012','KOH SHUN TIAN','0143498216',42561),
('SN335','ABDULLAH HAKIM','0176245228',16371),
('AX711','LOH XUN JIAN','0186442229',12548),
('SD866','NICK CHONG','0125486312',96411);


CREATE TABLE INVOICE
(
INVOICE_ID VARCHAR(6) PRIMARY KEY NOT NULL,
INVOICE_DATE DATE,
INVOICE_PAYMENT VARCHAR(7),
CUSTOMER_ID VARCHAR(6),
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER ON DELETE RESTRICT
);
INSERT INTO INVOICE VALUES
('IAA01','2015-01-01','CASH','AX546'),
('IAA02','2015-01-02','CREDIT','NO777'),
('IAA03','2015-02-01','CASH','GH123'),
('IAA04','2015-02-02','CASH','RE012'),
('IAA05','2015-02-11','CREDIT','SN335'),
('IAA06','2015-04-02','CASH','AX711'),
('IAA07','2015-05-23','CREDIT','SD866');

CREATE TABLE ORDER
(
INVOICE_ID VARCHAR(6) NOT NULL,
PIZZA_ID INT NOT NULL,
ORDER_QUANTITY INT,
ORDER_TOTAL_PRICE DECIMAL(5,2),
PRIMARY KEY (INVOICE_ID,PIZZA_ID),
FOREIGN KEY (INVOICE_ID) REFERENCES INVOICE ON DELETE RESTRICT,
FOREIGN KEY (PIZZA_ID) REFERENCES PIZZA ON DELETE RESTRICT
)

INSERT INTO ORDER VALUES
('IAA01','103',2,'0'),
('IAA01','104',3,'0'),
('IAA02','106',4,'0'),
('IAA03','101',1,'0'),
('IAA04','101',5,'0'),
('IAA05','100',2,'0'),
('IAA05','102',3,'0'),
('IAA05','106',1,'0'),
('IAA06','103',4,'0'),
('IAA06','102',5,'0'),
('IAA07','103',2,'0'),
('IAA05','105',2,'0'),
('IAA06','105',3,'0'),
('IAA01','100',2,'0'),
('IAA01','106',4,'0');

CREATE TABLE DELIVERY
(
DELIVERY_ID VARCHAR(6) PRIMARY KEY NOT NULL,
DELIVERY_STATUS VARCHAR(11),
INVOICE_ID VARCHAR(6),
OUTLET_ID VARCHAR(6),
STAFF_ID VARCHAR(7),
FOREIGN KEY (OUTLET_ID) REFERENCES OUTLET ON DELETE RESTRICT,
FOREIGN KEY (INVOICE_ID) REFERENCES INVOICE ON DELETE RESTRICT,
FOREIGN KEY (STAFF_ID) REFERENCES STAFF ON DELETE RESTRICT
);

INSERT INTO DELIVERY VALUES
('DEAA1','DELIVERING','IAA01','A1000','2AAAA1'),
('DEAA2','DELIVERING','IAA02','A1001','2AAAA5'),
('DEAA3','DELIVERING','IAA03','A1002','2AAAA7'),
('DEAA4','WAITING','IAA04','A1003','2AAAA1'),
('DEAB1','WAITING','IAA05','A1004','2AAAA4'),
('DEAB2','WAITING','IAA06','A1005','2AAAA6'),
('DEAB3','WAITING','IAA07','A1006','2AAAA7');




















