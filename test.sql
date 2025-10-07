--LIMPIO LAS TABLAS TEMPORALES PREVIAS
IF OBJECT_ID('tempdb..#Ventas') IS NOT NULL DROP TABLE #Ventas;
IF OBJECT_ID('tempdb..#Clients') IS NOT NULL DROP TABLE #Clients;
IF OBJECT_ID('tempdb..#Products') IS NOT NULL DROP TABLE #Products;

CREATE TABLE #Clients(
    Id INT IDENTITY(1, 1) PRIMARY KEY
    ,Nombre VARCHAR(30)

)

INSERT INTO #Clients (Nombre)
VALUES ('Maria')
    ,('Juan')
    ,('Magdalena')


CREATE TABLE #Products(
    Id INT IDENTITY(1, 1) PRIMARY KEY
    ,Nombre VARCHAR(30)
    ,Precio FLOAT

)
INSERT INTO #Products
VALUES ('Silla', 500.00)
    ,('Mesa', 5000.00)
    ,('Cojin', 50.00)
    ,('Plato', 5.00)
    ,('Cubiertos', 10.00)


-- Write your code here--

CREATE TABLE #Ventas (
    IdVenta INT IDENTITY(1,1) PRIMARY KEY,
    IdProducto INT NOT NULL,
    IdCliente INT NOT NULL, 
    FechaCompra DATE NOT NULL, 
    Cantidad INT NOT NULL,
    FOREIGN KEY (IdProducto) REFERENCES #Products(Id),
    FOREIGN KEY (IdCliente) REFERENCES #Clients(Id)
    ); 


INSERT INTO #Ventas (IdProducto, IdCliente, FechaCompra, Cantidad)
VALUES 
(1, 1, '2025-03-11', 2),
(2, 1, '2025-03-11', 3),
(3, 1, '2025-10-20', 1);


INSERT INTO #Ventas (IdProducto, IdCliente, FechaCompra, Cantidad)
VALUES 
(4, 2, '2025-05-11', 10),
(5, 2, '2025-05-11', 5),
(3, 2, '2025-10-21', 8);


INSERT INTO #Ventas (IdProducto, IdCliente, FechaCompra, Cantidad)
VALUES 
(4, 3, '2025-06-11', 13),
(2, 3, '2025-06-11', 26),
(1, 3, '2025-10-22', 18);

--PUNTO 1

;WITH Q1 AS (
    SELECT 
        c.Nombre AS Cliente,
        p.Nombre AS Producto,
        p.Precio,
        v.Cantidad,
        (p.Precio * v.Cantidad) AS Total,
        v.FechaCompra
    FROM #Ventas v
    INNER JOIN #Clients c ON v.IdCliente = c.Id
    INNER JOIN #Products p ON v.IdProducto = p.Id
    WHERE MONTH(v.FechaCompra) = 10 AND YEAR(v.FechaCompra) = 2025
)
SELECT *
FROM Q1
ORDER BY Cliente;


--PUNTO 2

;WITH Q2 AS (
    SELECT 
        c.Nombre AS Cliente,
        SUM(p.Precio * v.Cantidad) AS TotalComprado
    FROM #Ventas v
    INNER JOIN #Clients c ON v.IdCliente = c.Id
    INNER JOIN #Products p ON v.IdProducto = p.Id
    GROUP BY c.Nombre
)

SELECT *
FROM Q2
ORDER BY Cliente;

--PUNTO 3

DECLARE @IdCliente INT = 2;

;WITH Q3 AS (
    SELECT 
        c.Nombre AS Cliente,
        p.Nombre AS Producto,
        v.Cantidad,
        (p.Precio * V.Cantidad) AS Total,
        v.FechaCompra
    FROM #Ventas v
    INNER JOIN #Clients c ON v.IdCliente = c.Id
    INNER JOIN #Products p ON v.IdProducto = p.Id
    WHERE V.IdCliente = @IdCliente
)

SELECT * 
FROM Q3
ORDER BY Cliente;
      
--

DROP TABLE #Ventas
DROP TABLE #Clients
DROP TABLE #Products