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
email varchar(150) NOT NULL,
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