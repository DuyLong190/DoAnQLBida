create database DoAnQLBida
go
use DoAnQLBida
go

CREATE TABLE LOAIBAN (
    LoaiBanID   INT NOT NULL PRIMARY KEY,       
    LoaiBanName NVARCHAR(100) NOT NULL
);

create table BAN (
	TableID		int primary key not null,
	TableName	nvarchar(50) not null,
	Status		nvarchar(50) not null,
	LoaiBanID   INT NOT NULL,     
	StartTime	datetime,
	EndTime		datetime,
);

create table KHACHHANG (
	CustomerID	int primary key not null,
	CustomerName	nvarchar(100) not null,
	PhoneNum	int,
);

create table DICHVU (
	ServiceID	int primary key not null,
	ServiceName nvarchar(100) not null,
	Price		decimal(10,2),
);

create table NHANVIEN (
	EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName NVARCHAR(100) not null,
    Role NVARCHAR(50) not null,
    Password NVARCHAR(100) not null
);

CREATE TABLE HOADON (
    InvoiceID   INT NOT NULL PRIMARY KEY,
    TableID     INT NOT NULL,
    CustomerID  INT NOT NULL,
    EmployeeID  INT NOT NULL,
    StartTime   DATETIME NOT NULL,
    EndTime     DATETIME NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount >= 0),
    CONSTRAINT FK_HOADON_BAN FOREIGN KEY (TableID) REFERENCES BAN(TableID),
    CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (CustomerID) REFERENCES KHACHHANG(CustomerID),
    CONSTRAINT FK_HOADON_NHANVIEN FOREIGN KEY (EmployeeID) REFERENCES NHANVIEN(EmployeeID)
);

CREATE TABLE CHITIETHOADON (
    InvoiceID   INT NOT NULL,
    ServiceID   INT NOT NULL,
    SoLuong     INT NOT NULL CHECK (SoLuong > 0),
    PRIMARY KEY (InvoiceID, ServiceID),
    CONSTRAINT FK_CHITIETHOADON_HOADON FOREIGN KEY (InvoiceID) REFERENCES HOADON(InvoiceID),
    CONSTRAINT FK_CHITIETHOADON_DICHVU FOREIGN KEY (ServiceID) REFERENCES DICHVU(ServiceID)
);



INSERT INTO LOAIBAN (LoaiBanID, LoaiBanName)
VALUES (1, N'Bàn lỗ'),
       (2, N'Bàn carom'),
       (3, N'Bàn lip');

INSERT INTO BAN (TableID, TableName, LoaiBanID, Status, StartTime, EndTime)
VALUES (1, N'Bàn số 1', 1, N'Trống', NULL, NULL),      -- Bàn lỗ
       (2, N'Bàn số 2', 1, N'Đang sử dụng', '2024-10-16 10:00:00', '2024-10-16 12:00:00'), -- Bàn lỗ
       (3, N'Bàn số 3', 2, N'Trống', NULL, NULL),      -- Bàn carom
       (4, N'Bàn số 4', 2, N'Đang sử dụng', '2024-10-16 11:00:00', '2024-10-16 13:00:00'), -- Bàn carom
       (5, N'Bàn số 5', 3, N'Trống', NULL, NULL),      -- Bàn lip
       (6, N'Bàn số 6', 3, N'Đang sử dụng', '2024-10-16 09:00:00', '2024-10-16 11:00:00'); -- Bàn lip

INSERT INTO KHACHHANG (CustomerID, CustomerName, PhoneNum)
VALUES (1, N'Nguyễn Văn A', 0123456789),
       (2, N'Trần Thị B', 0987654321);

INSERT INTO DICHVU (ServiceID, ServiceName, Price)
VALUES (1, N'Nước uống', 15000),
       (2, N'Thuê gậy bida', 50000),
       (3, N'Thuê bàn bida', 100000);

INSERT INTO NHANVIEN (EmployeeName, Role, Password)
VALUES (N'Phạm Thị C', N'Quản lý', N'123456'),
       (N'Lê Văn D', N'Thu ngân', N'password');

INSERT INTO HOADON (InvoiceID, TableID, CustomerID, EmployeeID, StartTime, EndTime, TotalAmount)
VALUES (1, 2, 1, 1, '2024-10-16 10:00:00', '2024-10-16 12:00:00', 200000),  -- Hóa đơn cho Bàn lỗ
       (2, 4, 2, 2, '2024-10-16 11:00:00', '2024-10-16 13:00:00', 150000),  -- Hóa đơn cho Bàn carom
       (3, 6, 1, 1, '2024-10-16 09:00:00', '2024-10-16 11:00:00', 180000);  -- Hóa đơn cho Bàn lip

INSERT INTO CHITIETHOADON (InvoiceID, ServiceID, SoLuong)
VALUES (1, 1, 2),  -- Hóa đơn 1 mua 2 nước uống
       (1, 2, 1),  -- Hóa đơn 1 thuê 1 gậy bida
       (1, 3, 1),  -- Hóa đơn 1 thuê 1 bàn bida
       (2, 1, 1),  -- Hóa đơn 2 mua 1 nước uống
       (2, 3, 1),  -- Hóa đơn 2 thuê 1 bàn bida
       (3, 1, 2),  -- Hóa đơn 3 mua 2 nước uống
       (3, 3, 1);  -- Hóa đơn 3 thuê 1 bàn bida

UPDATE NHANVIEN
SET Password = CONVERT(VARCHAR(100), HASHBYTES('SHA2_256', Password), 2);

select * from BAN
select * from LOAIBAN
select * from NHANVIEN
select * from KHACHHANG
select * from HOADON
select * from CHITIETHOADON
select * from DICHVU