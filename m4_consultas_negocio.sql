--Creamos la base de Datos
create database ventas_tech_db;
GO
--La seleccionamos
USE ventas_tech_db;
GO
--Eliminamos tablas para que funcione el script
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS generos;

--Creamos las tablas

--Generos de los clientes:
CREATE TABLE generos(
id_genero int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre_genero varchar(50)
);

--Ubicacion de nuestras sucursales:
CREATE TABLE territorios(
id_territorio int NOT NULL IDENTITY(1,1) PRIMARY KEY,
pais varchar(50)NOT NULL,
region varchar(50) NOT NULL,
zona varchar(50)NOT NULL
);

--Categoria de nuestros productos:
CREATE TABLE categorias(
id_categoria int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre_categoria varchar(50) NOT NULL,
descripcion varchar(200)
);

--Informacion de nuestros clientes:
CREATE TABLE clientes(
id_cliente int not null IDENTITY(1,1) PRIMARY KEY,
nombre_cliente varchar(50) NOT NULL,
email varchar(150) UNIQUE,
ciudad varchar(50) NOT NULL,
segmento varchar(50) NOT NULL,
fecha_registro date NOT NULL,
id_genero int NOT NULL,
CONSTRAINT FK_Fact_Genero FOREIGN KEY (id_genero) REFERENCES generos(id_genero)
);

--Informacion de nuestros productos: 
CREATE TABLE productos(
id_producto int NOT NULL IDENTITY(1,1) PRIMARY KEY,
nombre_producto varchar(50) NOT NULL,
id_categoria int NOT NULL,
precio decimal(10,2) NOT NULL,
stock int DEFAULT 0 NOT NULL,
activo TINYINT DEFAULT 1,
CONSTRAINT FK_Fact_Categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

--Tabla de Hechos:
CREATE TABLE ventas(
id_venta int NOT NULL IDENTITY(1,1) PRIMARY KEY,
fecha_venta date NOT NULL,
id_cliente int NOT NULL,
id_territorio int NOT NULL,
id_producto int NOT NULL,
cantidad int NOT NULL,
precio_unitario decimal(10,2) NOT NULL,
canal varchar(50) NOT NULL,

CONSTRAINT FK_Fact_Cliente    FOREIGN KEY (id_cliente)    REFERENCES clientes(id_cliente),
CONSTRAINT FK_Fact_Territorio FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio),
CONSTRAINT FK_Fact_Producto   FOREIGN KEY (id_producto)     REFERENCES productos(id_producto)
);

--Insertamos Datos
INSERT INTO generos VALUES ('Masculino');
INSERT INTO generos VALUES ('Femenino');
INSERT INTO generos VALUES ('No Binario');
INSERT INTO generos VALUES ('Otro');

INSERT INTO territorios VALUES ('Argentina','Norte', 'Salta');
INSERT INTO territorios VALUES ('Argentina','Norte', 'Jujuy');
INSERT INTO territorios VALUES ('Argentina','Cuyo', 'Mendoza');
INSERT INTO territorios VALUES ('Argentina','Cuyo', 'San Juan');
INSERT INTO territorios VALUES ('Argentina','Pampeana', 'Buenos Aires');
INSERT INTO territorios VALUES ('Argentina','Pampeana', 'Córdoba');
INSERT INTO territorios VALUES ('Argentina','Patagonica', 'Santa Cruz');
INSERT INTO territorios VALUES ('Argentina','Patagonica', 'Neuquén');


INSERT INTO categorias VALUES ('Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES ('Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES ('Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES ('Almacenamiento', 'Discos y memorias');

INSERT INTO clientes VALUES ('María López', 'maria@mail.com', 'Buenos Aires', 'Particular', '2024-01-05', 2);
INSERT INTO clientes VALUES ('Carlos Ruiz', 'carlos@mail.com', 'Córdoba', 'Particular', '2024-01-10', 1);
INSERT INTO clientes VALUES ('Ana Gómez', 'ana@mail.com', 'Rosario', 'Particular', '2024-02-01', 2);
INSERT INTO clientes VALUES ('Pedro Sanz', 'pedro@mail.com', 'Mendoza', 'Particular', '2024-02-15', 3);
INSERT INTO clientes VALUES ('Laura Torres', 'laura@mail.com', 'Tucumán', 'Particular', '2024-03-01', 4);

INSERT INTO productos VALUES ('Laptop Pro 15', 1, 1200.00, 15, 1);
INSERT INTO productos VALUES ('Mouse Inalámbrico', 2,   28.00, 80, 1);
INSERT INTO productos VALUES ('Monitor 4K 27"', 1,  450.00, 12, 1);
INSERT INTO productos VALUES ('Auriculares BT Pro', 3,  120.00, 35, 1);
INSERT INTO productos VALUES ('SSD Externo 1TB', 4,  130.00, 18, 1);
INSERT INTO productos VALUES ('Teclado Mecánico', 2,   95.00, 40, 1);

INSERT INTO ventas VALUES ('2024-03-05', 1, 4, 1, 2, 1200.00, 'Online');
INSERT INTO ventas VALUES ('2024-03-06', 2, 5, 2, 5,   28.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-03-07', 3, 2, 3, 1,  450.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-03-08', 1, 1, 4, 2,  120.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-03-10', 4, 3, 5, 3,  130.00, 'Online');
INSERT INTO ventas VALUES ('2024-03-11', 2, 6, 6, 4,   95.00, 'Online');
INSERT INTO ventas VALUES ('2024-03-12', 5, 5, 1, 1, 1200.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-03-13', 3, 8, 2, 8,   28.00, 'Online');
INSERT INTO ventas VALUES ('2024-03-14', 4, 7, 4, 1,  120.00, 'Online');
INSERT INTO ventas VALUES ('2024-03-15', 5, 5, 3, 2,  450.00, 'Online');


select * from generos;
select * from territorios;
select * from categorias;
select * from clientes;
select * from productos;
select * from ventas;

--Consulta 1
--Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
SELECT
	MONTH(fecha_venta) AS Mes, --Tuve que usar MONTH() porque EXTRACT() no funciona en "SQL Server Management Studio" como pedia la consigna. 
	SUM(cantidad * precio_unitario) AS TotalFacturado,
	COUNT(id_venta) AS CantidadDePedidos,
	AVG(cantidad * precio_unitario) AS TicketPromedio
FROM Ventas
GROUP BY MONTH(fecha_venta);

--Consulta 2
--Top 5 de productos por total facturado, mostrando las unidades vendidas y el total generado. limitá el resultado a 5.
SELECT TOP 5 --Acá tuve que usar "TOP" por "LIMIT" porque tampoco funciona en "SQL Server Management Studio" 
	id_producto,
	SUM(cantidad) AS UnidadesVendidas,
	SUM(cantidad * precio_unitario) AS TotalGenerado
FROM Ventas
GROUP BY id_producto
ORDER BY TotalGenerado DESC;

--Consulta 3
--Clientes recurrentes que hayan realizado más de un pedido, mostrando la cantidad de pedidos y el total gastado.
SELECT
	id_cliente,
	COUNT(id_venta) AS CantidadDePedidos,
	SUM(Cantidad * precio_unitario) AS TotalGastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT(id_venta) > 1
ORDER BY TotalGastado DESC;

--Consulta 4
--Meses por encima/por debajo del promedio Total facturado por mes, con una columna adicional que etiquete con CASE WHEN si ese mes quedó 'Por encima' o 'Por debajo' del promedio mensual general.
--Agrego registros adicionales para poder hacer el calculo de Meses por encima y por debajo del promedio
-- Ventas de febrero:
INSERT INTO ventas VALUES ('2024-02-05', 1, 1, 1, 1, 1200.00, 'Online');
INSERT INTO ventas VALUES ('2024-02-12', 2, 2, 2, 2, 28.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-02-20', 3, 3, 4, 2, 120.00, 'Online');

-- Ventas de abril:
INSERT INTO ventas VALUES ('2024-04-05', 4, 4, 1, 2, 1200.00, 'Online');
INSERT INTO ventas VALUES ('2024-04-12', 5, 5, 3, 3, 450.00, 'Fisico');
INSERT INTO ventas VALUES ('2024-04-20', 1, 1, 5, 3, 130.00, 'Online');

SELECT
    MONTH(fecha_venta) AS Mes, -- Creamos una columna Mes para agrupar las ventas por mes.
    SUM(cantidad * precio_unitario) AS TotalFacturado, -- A cada Fila Mes le calculamos el TotalFacturado
    CASE
        WHEN SUM(cantidad * precio_unitario) > -- Comparamos el TotalFacturado de cada mes con el promedio mensual.
        (
            SELECT AVG(VentasMensuales.TotalMensual) -- Calculamos el promedio de los Totales Mensuales.
            FROM
            (
                SELECT  -- Dentro del select calculamos el total facturado de cada mes.
                    MONTH(fecha_venta) AS Mes, -- Columna con los Meses
                    SUM(cantidad * precio_unitario) AS TotalMensual -- Columna con los Totales Mensuales
                FROM Ventas
                GROUP BY MONTH(fecha_venta) 
            ) AS VentasMensuales -- Tabla creada con las columna Mes y TotalMensuales
        )
        THEN 'Por encima' -- Si el total del mes supera el promedio, lo clasificamos como "Por encima".
        ELSE 'Por debajo' -- Si no lo supera, lo clasificamos como "Por debajo".
    END AS Clasificacion -- cremos la columna Clasificacion
FROM Ventas
GROUP BY MONTH(fecha_venta)
ORDER BY TotalFacturado DESC;

-- HALLAZGOS
-- 1. El producto 1 fue el que más facturación generó, con $7200, representando aproximadamente el 62% de la facturación total.
-- 2. Marzo fue el mes con mayor facturación, con $6444, y quedó por encima del promedio mensual de $4026,67.
-- 3. El cliente 1 fue el cliente recurrente que más gastó, con $4230 en 4 pedidos.






