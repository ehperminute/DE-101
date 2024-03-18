CREATE TABLE IF NOT EXISTS Calendar
(
 "date"    date NOT NULL,
 year    int4range NOT NULL,
 quarter varchar(5) NOT NULL,
 month   int4range NOT NULL,
 week    int4range NOT NULL,
 weekday int4range NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( "date" )
);

CREATE TABLE IF NOT EXISTS Manager
(
 manager_id   int4range NOT NULL,
 manager_name varchar(50) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( manager_id )
);

CREATE TABLE IF NOT EXISTS Region
(
 region_id   int4range NOT NULL,
 region_name varchar(20) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( region_id )
);

CREATE TABLE IF NOT EXISTS Segment
(
 segment_id   int4range NOT NULL,
 segment_name varchar(15) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( segment_id )
);

CREATE TABLE IF NOT EXISTS Shipping
(
 ship_id   int4range NOT NULL,
 ship_mode varchar(15) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( ship_id )
);

CREATE TABLE IF NOT EXISTS RegionManager
(
 manager_id int4range NOT NULL,
 region_id  int4range NOT NULL,
 CONSTRAINT FK_1 FOREIGN KEY ( manager_id ) REFERENCES Manager ( manager_id ),
 CONSTRAINT FK_2 FOREIGN KEY ( region_id ) REFERENCES Region ( region_id )
);

CREATE INDEX FK_1 ON RegionManager
(
 manager_id
);

CREATE INDEX FK_2 ON RegionManager
(
 region_id
);

CREATE TABLE IF NOT EXISTS Product
(
 product_id     varchar(15) NOT NULL,
 product_name   varchar(128) NOT NULL,
 price          numeric(10,2) NOT NULL,
 subcategory_id int4range NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( product_id ),
 CONSTRAINT FK_4 FOREIGN KEY ( subcategory_id ) REFERENCES Subcategory ( subcategory_id )
);

CREATE INDEX FK_1 ON Product
(
 subcategory_id
);

CREATE TABLE IF NOT EXISTS Subcategory
(
 subcategory_id   int4range NOT NULL,
 subcategory_name varchar(50) NOT NULL,
 category_id      int4range NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( subcategory_id ),
 CONSTRAINT FK_5 FOREIGN KEY ( category_id ) REFERENCES Category ( category_id )
);

CREATE INDEX FK_1 ON Subcategory
(
 category_id
);

CREATE TABLE IF NOT EXISTS Customer
(
 customer_id   varchar(8) NOT NULL,
 customer_name varchar(50) NOT NULL,
 segment_id    int4range NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( customer_id ),
 CONSTRAINT FK_6 FOREIGN KEY ( segment_id ) REFERENCES Segment ( segment_id )
);

CREATE INDEX FK_1 ON Customer
(
 segment_id
);

CREATE TABLE IF NOT EXISTS "Return"
(
 order_id varchar(14) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( order_id )
);

CREATE TABLE IF NOT EXISTS Geography
(
 postal_code int4range NOT NULL,
 region_id   int4range NOT NULL,
 city_id     int4range NOT NULL,
 state_id    int4range NOT NULL,
 country_id  int4range NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( postal_code ),
 CONSTRAINT FK_10 FOREIGN KEY ( region_id ) REFERENCES Region ( region_id )
);

CREATE INDEX FK_1 ON Geography
(
 region_id
);

CREATE TABLE IF NOT EXISTS Category
(
 category_id   int4range NOT NULL,
 category_name varchar(50) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( category_id )
);



CREATE TABLE IF NOT EXISTS SalesFact
(
 row_id      int4range NOT NULL,
 order_id    varchar(14) NOT NULL,
 order_date  date NOT NULL,
 ship_date   date NOT NULL,
 sales       numeric(9,4) NOT NULL,
 quantity    int4range NOT NULL,
 discount    numeric(4,2) NOT NULL,
 profit      numeric(21,16) NOT NULL,
 postal_code int4range NOT NULL,
 ship_id     int4range NOT NULL,
 product_id  varchar(15) NOT NULL,
 customer_id varchar(8) NOT NULL,
 CONSTRAINT PK_1 PRIMARY KEY ( row_id ),
 CONSTRAINT FK_6_1 FOREIGN KEY ( postal_code ) REFERENCES Geography ( postal_code ),
 CONSTRAINT FK_7 FOREIGN KEY ( ship_id ) REFERENCES Shipping ( ship_id ),
 CONSTRAINT FK_8 FOREIGN KEY ( product_id ) REFERENCES Product ( product_id ),
 CONSTRAINT FK_9 FOREIGN KEY ( customer_id ) REFERENCES Customer ( customer_id )
);

CREATE INDEX FK_1 ON SalesFact
(
 postal_code
);

CREATE INDEX FK_2 ON SalesFact
(
 ship_id
);

CREATE INDEX FK_3 ON SalesFact
(
 product_id
);

CREATE INDEX FK_4 ON SalesFact
(
 customer_id
);
