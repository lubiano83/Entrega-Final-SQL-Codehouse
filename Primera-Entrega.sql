-- Creación de la base de datos
CREATE DATABASE AutoPartsStore;
USE AutoPartsStore;

-- Tabla Categorías
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria
    CategoryName VARCHAR(50) NOT NULL,        -- Nombre de la categoría
    Description VARCHAR(100)                          -- Descripción de la categoría
);

-- Tabla Productos
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria
    ProductName VARCHAR(50) NOT NULL,        -- Nombre del producto
    Description VARCHAR(100),                         -- Descripción del producto
    Price DECIMAL(10, 2) NOT NULL,            -- Precio del producto
    Stock INT NOT NULL,                       -- Cantidad disponible
    CategoryID INT,                           -- Relación con Categorías
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Tabla Clientes
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria
    FirstName VARCHAR(50) NOT NULL,           -- Nombre del cliente
    LastName VARCHAR(50) NOT NULL,            -- Apellido del cliente
    Email VARCHAR(50) UNIQUE NOT NULL,        -- Correo electrónico
    Phone VARCHAR(12),                         -- Teléfono
    Address VARCHAR(75)                               -- Dirección
);

-- Tabla Órdenes
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria
    OrderDate DATETIME NOT NULL,            -- Fecha y hora de la orden
    CustomerID INT,                         -- Relación con Clientes
    TotalAmount DECIMAL(10, 2) NOT NULL,    -- Monto total de la orden
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tabla Detalles de Órdenes
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY, -- Clave primaria
    OrderID INT,                                  -- Relación con Órdenes
    ProductID INT,                                -- Relación con Productos
    Quantity INT NOT NULL,                        -- Cantidad de productos
    UnitPrice DECIMAL(10, 2) NOT NULL,            -- Precio unitario
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);