# AutoPartsStore - Documentación de Base de Datos

## 📌 Descripción General
**AutoPartsStore** es una base de datos diseñada para gestionar la venta de autopartes, incluyendo clientes, productos, órdenes y auditoría de operaciones.

La base de datos incluye:
- **Tablas**: Clientes, Productos, Categorías, Órdenes, Detalles de Órdenes y Auditoría.
- **Funciones (`FUNCTION`)**: Para cálculos como total de órdenes, stock disponible y ventas de clientes.
- **Procedimientos (`STORED PROCEDURES`)**: Para CRUD dinámico y gestión de pagos.
- **Disparadores (`TRIGGERS`)**: Para auditoría de cambios y reducción automática de stock.
- **Vistas (`VIEWS`)**: Para reportes como productos más vendidos y órdenes recientes.

---

## 📂 Estructura de la Base de Datos

### 📌 Tablas Principales
- **Categories**: Categorías de productos.
- **Products**: Productos de autopartes.
- **Customers**: Clientes registrados.
- **Orders**: Órdenes de compra.
- **OrderDetails**: Detalles de cada orden.
- **AuditLog**: Registro de auditoría.

---

## 🔹 Vistas (`VIEWS`)

### **1️⃣ `View_OrdersDetails`** - Detalle de órdenes
📌 **Descripción**: Muestra información completa de las órdenes, incluyendo los productos comprados, clientes y montos.
```sql
SELECT * FROM View_OrdersDetails ORDER BY OrderID;
```

### **2️⃣ `View_TotalSalesPerCustomer`** - Total de Ventas por Cliente
📌 **Descripción**: Muestra cuánto ha gastado cada cliente.
```sql
SELECT * FROM View_TotalSalesPerCustomer;
```

### **3️⃣ `View_ProductsStock`** - Stock de Productos
📌 **Descripción**: Muestra el stock actual de cada producto con su categoría.
```sql
SELECT * FROM View_ProductsStock;
```

### **4️⃣ `View_BestSellingProducts`** - Productos Más Vendidos
📌 **Descripción**: Muestra los productos más vendidos en términos de cantidad y total de ingresos.
```sql
SELECT * FROM View_BestSellingProducts ORDER BY TotalRevenue DESC;
```

### **5️⃣ `View_OutOfStockProducts`** - Productos Agotados o con Bajo Stock
📌 **Descripción**: Muestra productos con stock = 0 o menor a 5.
```sql
SELECT * FROM View_OutOfStockProducts;
```

### **6️⃣ `View_RecentOrders`** - Órdenes Recientes (Último Año)
📌 **Descripción**: Muestra las órdenes realizadas en el último año, ordenadas por fecha.
```sql
SELECT * FROM View_RecentOrders;
```

---

## 🔹 Funciones (`FUNCTION`)

### **1️⃣ `GetTotalPrice(order_id INT)`** - Total de una Orden
📌 **Descripción**: Calcula el total de una orden sumando `Cantidad * PrecioUnitario`.
```sql
SELECT GetTotalPrice(1);
```

### **2️⃣ `GetAvailableStock(product_id INT)`** - Verificar Stock Disponible
📌 **Descripción**: Devuelve el stock actual de un producto específico.
```sql
SELECT GetAvailableStock(1);
```

### **3️⃣ `GetCustomerTotalSpent(customer_id INT)`** - Total Gastado por Cliente
📌 **Descripción**: Calcula cuánto ha gastado un cliente en órdenes pagadas.
```sql
SELECT GetCustomerTotalSpent(1);
```

### **4️⃣ `GetBestSellingProduct()`** - Producto Más Vendido
📌 **Descripción**: Devuelve el `ProductID` del producto más vendido en órdenes pagadas.
```sql
SELECT GetBestSellingProduct();
```

### **5️⃣ `GetOrderStatus(order_id INT)`** - Estado de una Orden
📌 **Descripción**: Devuelve `Paid` o `Pending` según el estado de pago de la orden.
```sql
SELECT GetOrderStatus(2);
```

---

## 🔹 Procedimientos (`STORED PROCEDURES`)

### **1️⃣ `GenericCRUD`** - Procedimiento Genérico para `INSERT`, `UPDATE` y `DELETE`
📌 **Descripción**: Maneja operaciones CRUD dinámicas en cualquier tabla.

#### **📌 Insertar un Producto**
```sql
CALL GenericCRUD(
    'INSERT', 'Products',
    'ProductName, Description, Price, Stock, CategoryID',
    "'Neumático Michelin', 'Neumático para autos de alto rendimiento', 120000, 50, 2",
    NULL
);
```

#### **📌 Actualizar un Producto**
```sql
CALL GenericCRUD(
    'UPDATE', 'Products',
    "Price = 110000, Stock = 45, Description = 'Neumático con nueva versión mejorada'",
    NULL,
    'ProductID = 23'
);
```

#### **📌 Eliminar un Producto**
```sql
CALL GenericCRUD(
    'DELETE', 'Products', NULL, NULL, 'ProductID = 23'
);
```

### **2️⃣ `ProcessPayment(order_id INT)`** - Procesar Pago de una Orden
📌 **Descripción**: Cambia `IsPaid = TRUE` en la tabla `Orders`.
```sql
CALL ProcessPayment(1);
```

---

## 🔹 Disparadores (`TRIGGERS`)

### **1️⃣ `AuditLog_Products_Insert`** - Auditoría de `INSERT`
📌 **Descripción**: Guarda en `AuditLog` cada vez que se inserta un producto.

### **2️⃣ `AuditLog_Products_Update`** - Auditoría de `UPDATE`
📌 **Descripción**: Guarda en `AuditLog` los datos antiguos y nuevos cuando un producto es modificado.

### **3️⃣ `AuditLog_Products_Delete`** - Auditoría de `DELETE`
📌 **Descripción**: Guarda en `AuditLog` los datos antiguos antes de eliminar un producto.

### **4️⃣ `ReduceStockAfterPayment`** - Reducción de Stock tras Pago de una Orden
📌 **Descripción**: Cuando una orden cambia `IsPaid = TRUE`, reduce automáticamente el stock de los productos comprados.

```sql
CALL ProcessPayment(1); -- Reduce stock automáticamente
```

---

## 📌 Resumen Final
✅ **`VIEWS`** → Para reportes de órdenes, ventas, stock y productos más vendidos.
✅ **`FUNCTIONS`** → Cálculos automáticos como total de órdenes, stock y productos más vendidos.
✅ **`STORED PROCEDURES`** → CRUD dinámico y procesamiento de pagos.
✅ **`TRIGGERS`** → Auditoría de cambios y reducción automática de stock.

🚀 **¡Base de datos completamente funcional y optimizada para AutoPartsStore!**# Entrega-Final-SQL-Codehouse
