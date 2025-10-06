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

--

DROP TABLE #Clients
DROP TABLE #Products