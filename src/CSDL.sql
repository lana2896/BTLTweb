USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ShoppingServletDB')
BEGIN
    ALTER DATABASE ShoppingServletDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ShoppingServletDB;
END
GO

CREATE DATABASE ShoppingServletDB;
GO

USE ShoppingServletDB;
GO

CREATE TABLE roles (
    roleid INT IDENTITY(1,1) PRIMARY KEY,
    rolename NVARCHAR(50) UNIQUE NOT NULL
);
GO

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(100),
    username NVARCHAR(50) UNIQUE NOT NULL,
    fullname NVARCHAR(100),
    password NVARCHAR(100),
    images NVARCHAR(200) NULL,
    phone NVARCHAR(20),
    roleid INT NOT NULL,
    createdate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (roleid) REFERENCES roles(roleid)
);
GO

INSERT INTO roles (rolename)
VALUES
    ('ADMIN'),
    ('MANAGER'),
    ('USER');
GO

INSERT INTO users (
    email,
    username,
    fullname,
    password,
    images,
    phone,
    roleid,
    createdate
)
VALUES (
    'admin@gmail.com',
    'admin',
    N'Quan Tri Vien',
    '123456',
    NULL,
    '0900000000',
    1,
    NULL
);
GO

INSERT INTO users (
    email,
    username,
    fullname,
    password,
    images,
    phone,
    roleid,
    createdate
)
VALUES (
    'manager@gmail.com',
    'manager',
    N'Nguoi Quan Ly',
    '123456',
    NULL,
    '0900000000',
    2,
    NULL
);
GO

INSERT INTO users (
    email,
    username,
    fullname,
    password,
    images,
    phone,
    roleid,
    createdate
)
VALUES (
    'mthu@gmail.com',
    'mthu',
    N'Minh Thu',
    '123456',
    NULL,
    '0900000000',
    3,
    NULL
);
GO

USE ShoppingServletDB;
GO

CREATE TABLE category (
    cate_id INT IDENTITY(1,1) PRIMARY KEY,
    cate_name NVARCHAR(100) NOT NULL,
    icons NVARCHAR(255) NULL
);
GO

USE ShoppingServletDB;
GO

INSERT INTO category (cate_name, icons)
VALUES
    (N'Điện thoại', N'fa-mobile'),
    (N'Laptop', N'fa-laptop'),
    (N'Tai nghe', N'fa-headphones'),
    (N'Phụ kiện', N'fa-plug');
GO


ALTER TABLE users
ADD active BIT NOT NULL DEFAULT 0,
    otp_code VARCHAR(10) NULL,
    otp_expiry DATETIME NULL;
GO

UPDATE users
SET active = 1;

CREATE TABLE products (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    price DECIMAL(18,2) NOT NULL,
    quantity INT NOT NULL,
    image NVARCHAR(255) NULL,
    description NVARCHAR(MAX) NULL,
    cate_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (cate_id)
        REFERENCES category(cate_id)
);
GO
INSERT INTO products (name, price, quantity, image, description, cate_id, created_at)
VALUES
    (N'iPhone 15 Pro Max', 32990000, 20, NULL, N'Flagship Apple, chip A17 Pro, camera 48MP', 1, GETDATE()),
    (N'Samsung Galaxy S24 Ultra', 28990000, 15, NULL, N'Bút S Pen, màn hình Dynamic AMOLED 2X', 1, GETDATE()),
    (N'Xiaomi 14', 15990000, 30, NULL, N'Chip Snapdragon 8 Gen 3, camera Leica', 1, GETDATE()),
    (N'OPPO Reno 11', 9990000, 25, NULL, N'Thiết kế mỏng nhẹ, camera chân dung AI', 1, GETDATE()),
    (N'MacBook Air M3', 27990000, 10, NULL, N'Chip Apple M3, pin 18 giờ, siêu mỏng nhẹ', 2, GETDATE()),
    (N'Dell XPS 13', 25990000, 8, NULL, N'Màn hình InfinityEdge, thiết kế cao cấp', 2, GETDATE()),
    (N'Asus ROG Zephyrus G14', 34990000, 6, NULL, N'Laptop gaming mỏng nhẹ, RTX 4060', 2, GETDATE()),
    (N'Lenovo ThinkPad X1 Carbon', 29990000, 7, NULL, N'Bền bỉ, bảo mật cao, dành cho doanh nhân', 2, GETDATE()),
    (N'Sony WH-1000XM5', 7990000, 40, NULL, N'Tai nghe chống ồn chủ động hàng đầu', 3, GETDATE()),
    (N'AirPods Pro 2', 5990000, 50, NULL, N'Chống ồn chủ động, âm thanh không gian', 3, GETDATE()),
    (N'JBL Tune 720BT', 1290000, 60, NULL, N'Tai nghe không dây, bass mạnh mẽ', 3, GETDATE()),
    (N'Sạc dự phòng Anker 20000mAh', 890000, 100, NULL, N'Sạc nhanh 2 chiều, dung lượng lớn', 4, GETDATE()),
    (N'Chuột không dây Logitech MX Master 3S', 2190000, 35, NULL, N'Chuột văn phòng cao cấp, pin lâu', 4, GETDATE()),
    (N'Bàn phím cơ Keychron K8', 1890000, 20, NULL, N'Bàn phím cơ không dây, switch hot-swap', 4, GETDATE());
GO