/* Creación DB */

CREATE DATABASE AutoPartsStore;
USE AutoPartsStore;

-- Tabla Categorías
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(100)
);

-- Tabla Productos
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Description VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Tabla Clientes
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Phone VARCHAR(12),
    Address VARCHAR(75)
);

-- Tabla Órdenes
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    IsPaid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Tabla Detalles de Órdenes
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tabla de Auditoria
CREATE TABLE AuditLog (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    TableName VARCHAR(50),     -- Nombre de la tabla afectada
    OperationType VARCHAR(10), -- Tipo de operación (INSERT, UPDATE, DELETE)
    OldData TEXT,              -- Datos antiguos (para UPDATE y DELETE)
    NewData TEXT,              -- Datos nuevos (para INSERT y UPDATE)
    ChangedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Fecha del cambio
);

/* Ingresando Datos */

-- Categorias
INSERT INTO Categories (CategoryName, Description)
VALUES
    ('Baterías', 'Baterías para automóviles de diferentes capacidades'),
    ('Neumáticos', 'Neumáticos para vehículos de diferentes tamaños y marcas'),
    ('Ampolletas', 'Ampolletas halógenas, LED y xenón para iluminación automotriz'),
    ('Pastillas de Freno', 'Pastillas de freno delanteras y traseras de alto rendimiento'),
    ('Filtros', 'Filtros de aceite, aire, combustible y cabina para autos');
    
SELECT * FROM Categories; -- Vemos las Categorias

-- Productos
INSERT INTO Products (ProductName, Description, Price, Stock, CategoryID)
VALUES
    ('Batería Bosch S4 60Ah', 'Batería de 12V con 60Ah, ideal para autos de gama media', 75000, 10, 1),
    ('Batería Varta Silver 74Ah', 'Batería de alto rendimiento con 74Ah, ideal para autos modernos', 120000, 8, 1),
    ('Batería Hankook 100Ah', 'Batería de 12V con 100Ah, recomendada para vehículos de alto consumo', 150000, 5, 1),
	('Batería Exide Premium 77Ah', 'Batería de 12V con 77Ah, ideal para autos de alto rendimiento', 110000, 7, 1),
    
    ('Neumático Michelin 205/55 R16', 'Neumático de alto desempeño para autos de turismo', 90000, 12, 2),
    ('Neumático Bridgestone 195/65 R15', 'Neumático de larga durabilidad para autos medianos', 78000, 15, 2),
    ('Neumático Pirelli Scorpion 225/65 R17', 'Neumático para SUV con excelente tracción en todo terreno', 130000, 7, 2),
    ('Neumático Goodyear Eagle F1 245/40 R18', 'Neumático de alto desempeño para autos deportivos', 160000, 6, 2),

    ('Ampolleta H4 Philips X-treme Vision', 'Ampolleta halógena H4 con 130% más brillo', 25000, 20, 3),
    ('Ampolleta H7 Osram Night Breaker', 'Ampolleta halógena H7 con mayor intensidad lumínica', 27000, 18, 3),
    ('Ampolleta LED T10 Blanco Frío', 'Ampolleta LED para luces de posición y tablero', 8000, 30, 3),
    ('Ampolleta Xenón D2S 6000K', 'Ampolleta de xenón para autos con sistema de iluminación HID', 45000, 12, 3),

    ('Pastillas de Freno Bosch Frontales', 'Juego de pastillas de freno delanteras de alta calidad', 55000, 10, 4),
    ('Pastillas de Freno Brembo Traseras', 'Pastillas de freno traseras con excelente rendimiento', 65000, 8, 4),
    ('Pastillas de Freno TRW Cerámicas', 'Pastillas de freno cerámicas para menor desgaste y mejor frenado', 72000, 6, 4),
    ('Pastillas de Freno Ferodo Premier', 'Juego de pastillas delanteras con bajo nivel de ruido', 50000, 12, 4),

    ('Filtro de Aceite Mann', 'Filtro de aceite de alta eficiencia para motores a combustión', 12000, 25, 5),
    ('Filtro de Aire Bosch', 'Filtro de aire de alto flujo para mejorar la combustión', 18000, 20, 5),
    ('Filtro de Combustible Mahle', 'Filtro de combustible con retención de partículas', 25000, 18, 5),
    ('Filtro de Cabina Carbono Activo', 'Filtro de polen con carbón activo para eliminar olores', 30000, 15, 5);
    
SELECT * FROM Products; -- Vemos los Productos
    
-- Clientes
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES
    ('Carlos', 'Pérez', 'carlos.perez@email.com', '987654321', 'Av. Libertad 123, Santiago'),
    ('María', 'González', 'maria.gonzalez@email.com', '956741258', 'Calle Las Rosas 456, Viña del Mar'),
    ('Javier', 'Martínez', 'javier.martinez@email.com', '987321654', 'Pasaje El Bosque 789, Concepción'),
    ('Camila', 'Hernández', 'camila.hernandez@email.com', '945612378', 'Av. España 321, Valparaíso'),
    ('Rodrigo', 'Torres', 'rodrigo.torres@email.com', '985412367', 'Los Aromos 654, Temuco'),
    ('Fernanda', 'Soto', 'fernanda.soto@email.com', '975846213', 'El Almendro 987, Rancagua'),
    ('Matías', 'Rojas', 'matias.rojas@email.com', '998745632', 'Plaza Central 125, La Serena'),
    ('Paola', 'Fuentes', 'paola.fuentes@email.com', '985623147', 'Los Pinares 951, Antofagasta'),
    ('Sebastián', 'Vargas', 'sebastian.vargas@email.com', '964587123', 'Av. Alemania 753, Puerto Montt'),
    ('Daniela', 'Ramírez', 'daniela.ramirez@email.com', '987154362', 'Camino del Sol 357, Chillán'),
    ('Hugo', 'Carrasco', 'hugo.carrasco@email.com', '952143678', 'Paseo Los Nogales 874, Iquique'),
    ('Andrea', 'Fernández', 'andrea.fernandez@email.com', '974561239', 'San Pedro 654, Copiapó'),
    ('Cristian', 'Mora', 'cristian.mora@email.com', '986745213', 'El Roble 123, Talca'),
    ('Francisca', 'López', 'francisca.lopez@email.com', '965478132', 'Calle Nueva 478, Arica'),
    ('Tomás', 'Navarro', 'tomas.navarro@email.com', '987654120', 'Av. Costanera 102, Punta Arenas'),
    ('Patricia', 'Silva', 'patricia.silva@email.com', '953214687', 'Av. Prat 879, Curicó'),
    ('Gabriel', 'Muñoz', 'gabriel.munoz@email.com', '988745623', 'Los Maitenes 341, Coquimbo'),
    ('Valentina', 'Gutiérrez', 'valentina.gutierrez@email.com', '976541287', 'Camino Real 789, Calama'),
    ('Pablo', 'Reyes', 'pablo.reyes@email.com', '962345789', 'Los Canelos 234, Osorno'),
    ('Fernanda', 'Araya', 'fernanda.araya@email.com', '951237846', 'Los Lirios 456, La Ligua'),
    ('Joaquín', 'Salazar', 'joaquin.salazar@email.com', '978512346', 'Av. San Martín 678, Quillota'),
    ('Marcela', 'Cifuentes', 'marcela.cifuentes@email.com', '982367451', 'El Arrayán 951, Pucón'),
    ('Felipe', 'Castro', 'felipe.castro@email.com', '975821436', 'Plaza del Este 234, San Fernando'),
    ('Bárbara', 'Pino', 'barbara.pino@email.com', '968745312', 'Camino La Luna 789, Melipilla'),
    ('Mauricio', 'Ortiz', 'mauricio.ortiz@email.com', '985621437', 'Los Eucaliptos 543, Peñaflor'),
    ('Alejandra', 'Sepúlveda', 'alejandra.sepulveda@email.com', '952147368', 'Las Acacias 147, Lota'),
    ('Esteban', 'Vega', 'esteban.vega@email.com', '987415263', 'El Arrayán 258, Quilpué'),
    ('Katherine', 'Saavedra', 'katherine.saavedra@email.com', '978562341', 'Paseo Costero 698, Angol'),
    ('Gonzalo', 'Bravo', 'gonzalo.bravo@email.com', '962548731', 'San Ignacio 357, Linares'),
    ('Isidora', 'Espinoza', 'isidora.espinoza@email.com', '975482136', 'Los Cipreses 453, Ovalle');
    
SELECT * FROM Customers; -- Vemos a los Clientes
    
-- Ordenes
INSERT INTO Orders (OrderDate, CustomerID, TotalAmount)
VALUES
    ('2024-02-01 10:15:00', 1, 150000),
    ('2024-02-02 14:30:00', 2, 78000),
    ('2024-02-03 09:45:00', 3, 125000),
    ('2024-02-04 11:20:00', 4, 95000),
    ('2024-02-05 16:10:00', 5, 64000),
    ('2024-02-06 08:50:00', 6, 178000),
    ('2024-02-07 12:30:00', 7, 92000),
    ('2024-02-08 15:40:00', 8, 134000),
    ('2024-02-09 17:55:00', 9, 230000),
    ('2024-02-10 13:25:00', 10, 112000),
    ('2024-02-11 09:10:00', 11, 87000),
    ('2024-02-12 14:50:00', 12, 67000),
    ('2024-02-13 18:20:00', 13, 155000),
    ('2024-02-14 07:45:00', 14, 98000),
    ('2024-02-15 10:30:00', 15, 142000),
    ('2024-02-16 12:15:00', 16, 200000),
    ('2024-02-17 15:00:00', 17, 110000),
    ('2024-02-18 17:45:00', 18, 75000),
    ('2024-02-19 08:10:00', 19, 175000),
    ('2024-02-20 11:30:00', 20, 94000),
    ('2024-02-21 14:10:00', 21, 67000),
    ('2024-02-22 16:20:00', 22, 154000),
    ('2024-02-23 18:40:00', 23, 187000),
    ('2024-02-24 09:55:00', 24, 72000),
    ('2024-02-25 12:35:00', 25, 129000),
    ('2024-02-26 15:45:00', 26, 93000),
    ('2024-02-27 18:55:00', 27, 159000),
    ('2024-02-28 08:20:00', 28, 148000),
    ('2024-02-29 10:40:00', 29, 82000),
    ('2024-03-01 13:15:00', 30, 99000);
    
SELECT * FROM Orders; -- Vemos las Ordenes

-- Detalle de Ordenes
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1, 2, 75000),
    (1, 4, 4, 90000),
    (2, 3, 1, 150000),
    (2, 8, 2, 27000),
    (3, 10, 5, 8000),
    (3, 11, 1, 45000),
    (4, 6, 2, 130000),
    (4, 12, 3, 55000),
    (5, 16, 2, 12000),
    (6, 19, 1, 25000),
    (7, 9, 4, 25000),
    (8, 11, 2, 45000),
    (8, 14, 1, 72000),
    (9, 2, 1, 120000),
    (10, 7, 3, 160000),
    (11, 4, 2, 90000),
    (12, 18, 3, 18000),
    (13, 13, 2, 65000),
    (14, 17, 1, 30000),
    (15, 20, 2, 25000),
    (16, 1, 1, 75000),
    (16, 11, 1, 45000),
    (17, 6, 2, 130000),
    (18, 12, 1, 55000),
    (19, 3, 2, 150000),
    (20, 10, 5, 8000),
    (21, 16, 2, 12000),
    (22, 8, 1, 27000),
    (23, 14, 2, 72000),
    (24, 2, 1, 120000),
    (25, 7, 1, 160000),
    (26, 4, 3, 90000),
    (27, 5, 2, 78000),
    (28, 19, 1, 25000),
    (29, 9, 3, 25000),
    (30, 13, 1, 65000),
    (30, 18, 2, 18000),
    (1, 9, 1, 25000),
    (2, 19, 2, 25000),
    (3, 17, 2, 30000),
    (4, 11, 1, 45000),
    (5, 14, 2, 72000),
    (6, 4, 3, 90000),
    (7, 2, 1, 120000),
    (8, 7, 1, 160000),
    (9, 5, 2, 78000),
    (10, 18, 1, 18000);
    
SELECT * FROM OrderDetails; -- Vemos el Detalle

/* Vistas */

-- Detalle de Ordenes
CREATE VIEW View_OrdersDetails AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    c.Email AS CustomerEmail,
    p.ProductName,
    od.Quantity,
    od.UnitPrice,
    (od.Quantity * od.UnitPrice) AS TotalProductAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

SELECT * FROM View_OrdersDetails ORDER BY OrderID; -- Vista Detalle de Ordenes ordenado por OrderID

-- Ventas por Clientes
CREATE VIEW View_TotalSalesPerCustomer AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    SUM(o.TotalAmount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email;

SELECT * FROM View_TotalSalesPerCustomer; -- Vemos las ventas totales por cliente

-- Stock de Productos
CREATE VIEW View_ProductsStock AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Description,
    c.CategoryName,
    p.Price,
    p.Stock
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID;

SELECT * FROM View_ProductsStock; -- Vemos el stock actual de los productos

-- Productos mas vendidos
CREATE VIEW View_BestSellingProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalSold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;

SELECT * FROM View_BestSellingProducts ORDER BY TotalRevenue DESC; -- Vemos el listado de productos mas vendidos de forma descendente

-- Resumen de Ordenes
CREATE VIEW View_OrderSummary AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    c.Email AS CustomerEmail,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

SELECT * FROM View_OrderSummary; -- Vista de Resumen de Ordenes

-- Productos fuera de Stock
CREATE VIEW View_OutOfStockProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    p.Stock
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.Stock = 0 OR p.Stock < 5;

SELECT * FROM View_OutOfStockProducts; -- Vista de Productos con Stock = 0 o Stock < 5 (si no hay algun producto con stock menor o igual a 5, la tabla estara vacia)

-- Ordenes Recientes
CREATE VIEW View_RecentOrders AS
SELECT 
    o.OrderID,
    o.OrderDate,
    c.FirstName AS CustomerFirstName,
    c.LastName AS CustomerLastName,
    c.Email AS CustomerEmail,
    o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
ORDER BY o.OrderDate DESC;

SELECT * FROM View_RecentOrders; -- Vista de Ordenes Recientes (1 año), si no hay alguna orden dentro del ultimo año, la tabla se vera vacia

/* Funciones */

-- Obtener el Precio Total
DELIMITER //
CREATE FUNCTION GetTotalPrice(order_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(Quantity * UnitPrice) INTO total
    FROM OrderDetails
    WHERE OrderID = order_id;
    
    RETURN total;
END;
//
DELIMITER ;

SELECT GetTotalPrice(1); -- Obtenemos el precio total de la orden de trabajo

-- Verificar Stock de un Producto
DELIMITER //
CREATE FUNCTION GetAvailableStock(product_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock_count INT;
    
    SELECT Stock INTO stock_count 
    FROM Products 
    WHERE ProductID = product_id;
    
    RETURN stock_count;
END;
//
DELIMITER ;

SELECT GetAvailableStock(1); -- Obtenemos el stock de un producto en especifico

-- Gasto Total por Cliente
DELIMITER //

CREATE FUNCTION GetCustomerTotalSpent(customer_id INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_spent DECIMAL(10,2);
    
    -- Sumar solo el total de órdenes que han sido pagadas
    SELECT COALESCE(SUM(TotalAmount), 0) INTO total_spent 
    FROM Orders 
    WHERE CustomerID = customer_id AND IsPaid = TRUE;

    RETURN total_spent;
END;
//

DELIMITER ;

SELECT GetCustomerTotalSpent(0); -- Obtenemos el gasto total realizado por un cliente, esto debe estar pagado para que cuente

-- Producto mas vendido
DELIMITER //

CREATE FUNCTION GetBestSellingProduct() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE best_product INT;

    -- Obtener el producto más vendido solo de órdenes pagadas
    SELECT od.ProductID INTO best_product
    FROM OrderDetails od
    JOIN Orders o ON od.OrderID = o.OrderID
    WHERE o.IsPaid = TRUE  -- Solo contar las órdenes pagadas
    GROUP BY od.ProductID
    ORDER BY SUM(od.Quantity) DESC
    LIMIT 1;

    RETURN best_product;
END;
//

DELIMITER ;

SELECT GetBestSellingProduct(); -- Obtenemos el producto mejor vendido, esto debe estar pagado para que cuente

-- Cantidad de Productos por Categoria
DELIMITER //

CREATE FUNCTION GetCategoryProductCount(category_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE product_count INT;
    
    SELECT COUNT(*) INTO product_count 
    FROM Products 
    WHERE CategoryID = category_id;
    
    RETURN product_count;
END;
//

DELIMITER ;

SELECT GetCategoryProductCount(1); -- Obtenemos la cantidad de productos por una categoria especifica

-- Ordenes Pagadas
DELIMITER //

CREATE FUNCTION GetOrderStatus(order_id INT) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE status VARCHAR(20);

    -- Verifica si la orden está pagada
    SELECT IF(IsPaid, 'Paid', 'Pending') INTO status 
    FROM Orders 
    WHERE OrderID = order_id;

    RETURN status;
END;
//

DELIMITER ;

SELECT GetOrderStatus(2); -- Obtenemos si una orden en especifico fue pagada o no

/* Store Procedure */

-- Actualizacion de Datos
DELIMITER //

CREATE PROCEDURE GenericCRUD(
    IN action_type VARCHAR(10),    -- Acción: INSERT, UPDATE o DELETE
    IN table_name VARCHAR(50),     -- Nombre de la tabla
    IN column_names TEXT,          -- Columnas a insertar o SET para UPDATE
    IN values_text TEXT,           -- Valores a insertar (para INSERT)
    IN condition_text TEXT         -- Condición para UPDATE o DELETE
)
BEGIN
    SET @query = '';

    -- Insertar datos
    IF action_type = 'INSERT' THEN
        SET @query = CONCAT('INSERT INTO ', table_name, ' (', column_names, ') VALUES (', values_text, ');');

    -- Actualizar datos
    ELSEIF action_type = 'UPDATE' THEN
        SET @query = CONCAT('UPDATE ', table_name, ' SET ', column_names, ' WHERE ', condition_text, ';');

    -- Eliminar datos
    ELSEIF action_type = 'DELETE' THEN
        SET @query = CONCAT('DELETE FROM ', table_name, ' WHERE ', condition_text, ';');

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Acción no válida. Usa INSERT, UPDATE o DELETE.';
    END IF;

    -- Ejecutar la consulta generada dinámicamente
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END;
//

DELIMITER ;

-- Pagar Orden de Trabajo
DELIMITER //

CREATE PROCEDURE ProcessPayment(
    IN order_id INT  -- ID de la orden a pagar
)
BEGIN
    -- Verificar si la orden ya está pagada
    IF (SELECT IsPaid FROM Orders WHERE OrderID = order_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: La orden ya ha sido pagada';
    ELSE
        -- Marcar la orden como pagada
        UPDATE Orders 
        SET IsPaid = TRUE 
        WHERE OrderID = order_id;
    END IF;
END;
//

DELIMITER ;

/* Trigger */

-- Registro de INSERT
DELIMITER //

CREATE TRIGGER AuditLog_Products_Insert
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
    DECLARE new_data TEXT;
    
    -- Capturar datos nuevos (para INSERT)
    SET new_data = CONCAT('ProductID:', NEW.ProductID, ', Name:', NEW.ProductName, 
                          ', Price:', NEW.Price, ', Stock:', NEW.Stock, ', CategoryID:', NEW.CategoryID);

    -- Insertar en la tabla de auditoría
    INSERT INTO AuditLog (TableName, OperationType, OldData, NewData)
    VALUES ('Products', 'INSERT', NULL, new_data);
END;
//

DELIMITER ;

-- Registro de UPDATE
DELIMITER //

CREATE TRIGGER AuditLog_Products_Update
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    DECLARE old_data TEXT;
    DECLARE new_data TEXT;

    -- Capturar datos antiguos
    SET old_data = CONCAT('ProductID:', OLD.ProductID, ', Name:', OLD.ProductName, 
                          ', Price:', OLD.Price, ', Stock:', OLD.Stock, ', CategoryID:', OLD.CategoryID);

    -- Capturar datos nuevos
    SET new_data = CONCAT('ProductID:', NEW.ProductID, ', Name:', NEW.ProductName, 
                          ', Price:', NEW.Price, ', Stock:', NEW.Stock, ', CategoryID:', NEW.CategoryID);

    -- Insertar en la tabla de auditoría
    INSERT INTO AuditLog (TableName, OperationType, OldData, NewData)
    VALUES ('Products', 'UPDATE', old_data, new_data);
END;
//

DELIMITER ;

-- Registro de DELETE
DELIMITER //

CREATE TRIGGER AuditLog_Products_Delete
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    DECLARE old_data TEXT;

    -- Capturar los datos antiguos antes de la eliminación
    SET old_data = CONCAT('ProductID:', OLD.ProductID, ', Name:', OLD.ProductName, 
                          ', Price:', OLD.Price, ', Stock:', OLD.Stock, ', CategoryID:', OLD.CategoryID);

    -- Insertar en la tabla de auditoría
    INSERT INTO AuditLog (TableName, OperationType, OldData, NewData)
    VALUES ('Products', 'DELETE', old_data, NULL);
END;
//

DELIMITER ;

-- Reducir el Stock
DELIMITER //

CREATE TRIGGER ReduceStockAfterPayment
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    -- Solo ejecutar si el pago ha cambiado de FALSE a TRUE
    IF OLD.IsPaid = FALSE AND NEW.IsPaid = TRUE THEN
        -- Reducir el stock de los productos de la orden
        UPDATE Products p
        JOIN OrderDetails od ON p.ProductID = od.ProductID
        SET p.Stock = p.Stock - od.Quantity
        WHERE od.OrderID = NEW.OrderID;
    END IF;
END;
//

DELIMITER ;

/* Tablero de Control */

CALL ProcessPayment(1); -- Aca realizamos el pago y reducimos el stock de los productos de la orden especificada
CALL ProcessPayment(3); -- Aca realizamos el pago y reducimos el stock de los productos de la orden especificada

-- Insertar datos
CALL GenericCRUD(
    'INSERT',
    'Products',
    'ProductName, Description, Price, Stock, CategoryID',
    "'Neumático Michelin', 'Neumático para autos de alto rendimiento', 120000, 50, 2",
    NULL
);

-- Actualizar datos
CALL GenericCRUD(
    'UPDATE',
    'Products',
    "Price = 110000, Stock = 45, Description = 'Neumático con nueva versión mejorada'",
    NULL,
    'ProductID = 21'
);

-- Eliminar datos
CALL GenericCRUD(
    'DELETE',
    'Products',
    NULL,
    NULL,
    'ProductID = 21'
);

SELECT * FROM products; -- Revisamos la lista de productos
SELECT * FROM AuditLog; -- Revisamos la tabla de auditoria














