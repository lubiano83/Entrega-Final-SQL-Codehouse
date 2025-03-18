# AutoPartsStore - Base de Datos

## Descripción
Este proyecto implementa un sistema de base de datos para una tienda de autopartes utilizando MySQL. Incluye la estructura de tablas, inserción de datos, vistas, funciones, procedimientos almacenados y triggers para gestionar productos, órdenes y auditoría.

## Estructura de la Base de Datos

### 1. Creación de la Base de Datos
```sql
CREATE DATABASE AutoPartsStore;
USE AutoPartsStore;
```

### 2. Tablas Principales

#### **Categorías**
```sql
CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Description VARCHAR(100)
);
```

#### **Productos**
```sql
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    Description VARCHAR(100),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
```

#### **Clientes**
```sql
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Phone VARCHAR(12),
    Address VARCHAR(75)
);
```

#### **Órdenes**
```sql
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATETIME NOT NULL,
    CustomerID INT,
    TotalAmount DECIMAL(10,2) NOT NULL,
    IsPaid BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
```

#### **Detalles de Órdenes**
```sql
CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

#### **Auditoría**
```sql
CREATE TABLE AuditLog (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    TableName VARCHAR(50),
    OperationType VARCHAR(10),
    OldData TEXT,
    NewData TEXT,
    ChangedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## Vistas

- **Detalle de Órdenes** (`View_OrdersDetails`):
  Muestra información detallada de cada orden, incluyendo productos y clientes.

- **Ventas por Clientes** (`View_TotalSalesPerCustomer`):
  Muestra el total gastado por cliente, solo considerando órdenes pagadas.

- **Stock de Productos** (`View_ProductsStock`):
  Muestra el stock disponible de cada producto.

- **Productos más Vendidos** (`View_BestSellingProducts`):
  Muestra los productos más vendidos en órdenes pagadas.

- **Resumen de Órdenes** (`View_OrderSummary`):
  Muestra un resumen de las órdenes con estado de pago.

- **Productos fuera de Stock** (`View_OutOfStockProducts`):
  Muestra productos con stock bajo o agotados.

- **Órdenes Recientes** (`View_RecentOrders`):
  Muestra órdenes realizadas en el último año.

## Funciones

- `GetTotalPrice(order_id INT)`: Obtiene el total de una orden.
- `GetAvailableStock(product_id INT)`: Obtiene el stock disponible de un producto.
- `GetCustomerTotalSpent(customer_id INT)`: Obtiene el total gastado por un cliente en órdenes pagadas.
- `GetBestSellingProduct()`: Devuelve el ID del producto más vendido en órdenes pagadas.
- `GetCategoryProductCount(category_id INT)`: Cuenta la cantidad de productos en una categoría.
- `GetOrderStatus(order_id INT)`: Devuelve el estado de pago de una orden.

## Procedimientos Almacenados

- `GenericCRUD(action_type, table_name, column_names, values_text, condition_text)`: Realiza operaciones dinámicas de INSERT, UPDATE y DELETE.
- `ProcessPayment(order_id INT)`: Marca una orden como pagada y reduce el stock de productos de la orden.

## Triggers

- **Auditoría en Productos**:
  - `AuditLog_Products_Insert`: Guarda registros de inserción.
  - `AuditLog_Products_Update`: Guarda registros de actualización.
  - `AuditLog_Products_Delete`: Guarda registros de eliminación.

- **Reducción Automática de Stock**:
  - `ReduceStockAfterPayment`: Reduce el stock después de marcar una orden como pagada.

## Tablero de Control

### Procesamiento de Pagos
```sql
CALL ProcessPayment(1);
CALL ProcessPayment(3);
```

### CRUD Genérico
```sql
-- Insertar datos
CALL GenericCRUD('INSERT', 'Products', 'ProductName, Description, Price, Stock, CategoryID', "'Neumático Michelin', 'Neumático para autos de alto rendimiento', 120000, 50, 2", NULL);

-- Actualizar datos
CALL GenericCRUD('UPDATE', 'Products', "Price = 110000, Stock = 45, Description = 'Neumático con nueva versión mejorada'", NULL, 'ProductID = 21');

-- Eliminar datos
CALL GenericCRUD('DELETE', 'Products', NULL, NULL, 'ProductID = 21');
```

### Consultas Útiles
```sql
SELECT * FROM Products;
SELECT * FROM AuditLog;
SELECT * FROM View_BestSellingProducts ORDER BY TotalRevenue DESC;
SELECT * FROM View_OrdersDetails ORDER BY OrderID;
```

## Notas Finales
- Se han agregado validaciones en procedimientos y triggers para evitar inconsistencias.
- El sistema ahora permite gestionar pagos y stock de manera automática.
- La auditoría garantiza el rastreo de cambios en productos.

🚀 **Este sistema proporciona una gestión eficiente de una tienda de autopartes con MySQL.**