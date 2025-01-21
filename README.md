# Proyecto SQL: Base de Datos para Tienda de Repuestos de Automóviles

## **Descripción del Proyecto**
Este proyecto consiste en el diseño y creación de una base de datos para una tienda de repuestos de automóviles. La base de datos está diseñada para gestionar información clave sobre los productos que se venden, las categorías de productos, los clientes que realizan compras, las órdenes realizadas, y los detalles específicos de cada orden. Este sistema permite una administración eficiente y organizada, optimizando las operaciones de la tienda y el acceso a los datos relevantes.

## **Tablas de la Base de Datos**
A continuación, se describen las tablas principales que componen la base de datos, junto con una breve explicación de su propósito:

### **1. Categories (Categorías)**
- **Propósito:** Contiene información sobre las diferentes categorías de productos que ofrece la tienda. Esto permite organizar los productos de manera lógica y facilitar su búsqueda.
- **Campos principales:**
  - `CategoryID`: Identificador único de la categoría.
  - `CategoryName`: Nombre de la categoría (por ejemplo, "Filtros", "Aceites").
  - `Description`: Descripción adicional sobre la categoría.

### **2. Products (Productos)**
- **Propósito:** Almacena información sobre los productos disponibles en la tienda, incluyendo detalles como precio, cantidad en stock, y la categoría a la que pertenecen.
- **Campos principales:**
  - `ProductID`: Identificador único del producto.
  - `ProductName`: Nombre del producto (por ejemplo, "Aceite 10W-40").
  - `Description`: Descripción detallada del producto.
  - `Price`: Precio del producto.
  - `Stock`: Cantidad disponible en inventario.
  - `CategoryID`: Relación con la tabla de categorías para identificar a qué categoría pertenece el producto.

### **3. Customers (Clientes)**
- **Propósito:** Registra información sobre los clientes que realizan compras en la tienda, permitiendo un seguimiento personalizado y eficiente.
- **Campos principales:**
  - `CustomerID`: Identificador único del cliente.
  - `FirstName`: Nombre del cliente.
  - `LastName`: Apellido del cliente.
  - `Email`: Correo electrónico del cliente (único).
  - `Phone`: Número de teléfono del cliente.
  - `Address`: Dirección del cliente.

### **4. Orders (Órdenes)**
- **Propósito:** Almacena información sobre las órdenes realizadas por los clientes, incluyendo la fecha de la orden y el monto total.
- **Campos principales:**
  - `OrderID`: Identificador único de la orden.
  - `OrderDate`: Fecha en que se realizó la orden.
  - `CustomerID`: Relación con la tabla de clientes para identificar quién realizó la orden.
  - `TotalAmount`: Monto total de la orden.

### **5. OrderDetails (Detalles de Órdenes)**
- **Propósito:** Detalla la información de los productos incluidos en cada orden, como la cantidad y el precio unitario. Esta tabla permite un desglose preciso de cada orden.
- **Campos principales:**
  - `OrderDetailID`: Identificador único del detalle de la orden.
  - `OrderID`: Relación con la tabla de órdenes para identificar a qué orden pertenece el detalle.
  - `ProductID`: Relación con la tabla de productos para identificar qué producto fue adquirido.
  - `Quantity`: Cantidad de productos adquiridos.
  - `UnitPrice`: Precio unitario del producto.