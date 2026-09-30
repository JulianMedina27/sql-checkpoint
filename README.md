# RetailPro — Análisis de ventas con SQL Server

Proyecto del curso **Analista de Datos (CoderHouse)**. Modela las ventas de RetailPro, una tienda de tecnología, y responde preguntas del equipo comercial con consultas SQL.

## Modelo de datos

Base `ventas_tech_db`: una tabla de hechos (`ventas`) y cinco dimensiones (`clientes`, `productos`, `categorias`, `territorios`, `generos`). Todas las claves foráneas son `NOT NULL`.

## Herramientas

- **Microsoft SQL Server** y **SQL Server Management Studio (SSMS) 22**.
- **Git y GitHub**.
- **IA generativa (Claude)** como copiloto para documentar y revisar el código.

> Los scripts están en **T-SQL** (`IDENTITY`, `GO`, `TOP`, `MONTH()`): no corren sin cambios en MySQL ni PostgreSQL.

## Archivos

| Archivo | Contenido |
|---|---|
| `ventas_tech_db.sql` | Crea la base, las tablas y carga los datos |
| `m4_consultas_negocio.sql` | Lo anterior + consultas de negocio (`GROUP BY`, `HAVING`, `CASE WHEN`) |
| `m5_consultas_joins.sql` | Lo anterior + consultas con `INNER JOIN`, `LEFT JOIN` y `UNION ALL` |

## Cómo ejecutar

1. Abrir SSMS y conectarse a una instancia de SQL Server.
2. Abrir `m5_consultas_joins.sql` y presionar **F5**. Incluye la creación de la base y todas las consultas de M4 y M5, así que alcanza con ese script.

A tener en cuenta:

- Cada script **borra y recrea las tablas** (`DROP TABLE IF EXISTS`).
- Si la base ya existe, el `create database` inicial da error; se puede ignorar, el resto sigue ejecutándose.

## Hallazgos principales

Sobre 16 ventas (febrero a abril de 2024) y $12.080 de facturación:

- **Laptop Pro 15** genera el 59,6 % de la facturación ($7.200).
- **Marzo** fue el mes de mayor facturación ($6.444); febrero fue el único por debajo del promedio mensual.
- Los **clientes 1 y 5** concentran el 63,6 % de la facturación.
- El **Mouse Inalámbrico** es el más vendido en unidades (15) pero aporta solo el 3,5 %.

El volumen de datos es chico: los resultados sirven para validar las consultas más que para sacar conclusiones de tendencia.
