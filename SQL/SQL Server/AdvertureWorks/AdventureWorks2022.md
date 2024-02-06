# AdvertureWorks 2022

Consultas para la base de datos de Microsoft AdvertureWorks del [backup 2022](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)


## Consultas

1.- Mostrar solamente el nro. de empleado (BusinessEntityID) y cargo (Title).

```sql
SELECT
	BusinessEntityID, Title
FROM
	Person.Person
ORDER BY
	BusinessEntityID
```

2.- Escribir una consulta que muestre el pago histórico de los empleados y un incremento del 20% en 3 formatos diferentes, con las siguientes cabeceras “Sin formato”, “Redondeado a 1 digito decimal”, “truncado a 1 digito”. Usar función ROUND.

```sql
SELECT
	(Rate * PayFrequency) * 1.20 AS "Sin formato",
	FORMAT(ROUND((Rate * PayFrequency) * 1.20, 1), 'N1') AS "Redondeado a 1 digito decimal",
	FORMAT(ROUND((Rate * PayFrequency) * 1.20, 1, 1), 'N1') AS "truncado a 1 digito"
FROM
	HumanResources.EmployeePayHistory
ORDER BY
	BusinessEntityID
```

3.- Listar Todos los nombres y grupos de los distintos departamentos

```sql
SELECT
	Name,
	GroupName
FROM
	HumanResources.Department
ORDER BY
	GroupName
```

4.- Listar sin repetir, todos los nombres de grupos de los departamentos. 

```sql
SELECT DISTINCT
	GroupName
FROM
	HumanResources.Department
ORDER BY
	GroupName
```

5.- Crear una consulta que muestre el Nombre, numero, color, precio y tamaño de los productos que cuesten mas de $10,00

```sql
SELECT 
	ProductNumber,
	Name,
	Color,
	Size,
	ListPrice
FROM
	Production.Product
WHERE
	ListPrice > 10
ORDER BY
	ListPrice DESC
```

6.- Escribir y ejecutar una sentencia SELECT que devuelva los productos cuyo número de producto comience con LJ

```sql
SELECT 
	ProductNumber,
	Name,
	Color,
	Size,
	ListPrice
FROM
	Production.Product
WHERE
	ProductNumber LIKE 'LJ%'
ORDER BY
	ProductNumber
```

7.- Crear una consulta que muestre el número y nombre en una sola columna, separados por un guión para todos los productos de color ‘Black’.

```sql
SELECT 
	ProductNumber + ' - ' + Name,
	Color
FROM
	Production.Product
WHERE
	Color LIKE 'black'
ORDER BY
	ProductNumber
```

8.- Crear una consulta que muestre los productos cuyos precios estén entre 10,00 y 100,00.

```sql
SELECT 
	ProductNumber,
	Name,
	Color,
	Size,
	ListPrice
FROM
	Production.Product
WHERE
	ListPrice BETWEEN 10 AND 100
ORDER BY
	ListPrice DESC
```

9.- Crear una consulta que muestre los productos que hayan salido a la venta entre los año 2001 y 2003, ordenar el resultado por dicha fecha en forma descendente. Tabla a utilizar: Production.Product, columna: SellStartDate

```sql
SELECT 
	ProductNumber,
	Name,
	Color,
	Size,
	ListPrice,
	SellStartDate
FROM
	Production.Product
WHERE
	YEAR(SellStartDate) BETWEEN 2011 AND 2013
ORDER BY
	SellStartDate DESC,
	ListPrice DESC
```

10.- Crear una consulta que muestre los productos ordenado alfabéticamente dentro de cada subcategoría solamente para las subcategorías 1 y 2. Production.Product, columna: ProductSubcategoryID

```sql

```

11.- Crear una consulta que muestre los empleados y su cargo cuyo login comience con la letra ‘k’ (Posición 17). Utilizar la tabla: HumanResources.Employee y columna: LoginID

```sql

```

12.- Crear una consulta para mostrar los 10 empleados con mayor cantidad de horas de vacaciones. Utilizar la tabla: HumanResources.Employee y columnas: LoginID, Title, VacationHours

```sql

```

13.- Crear una consulta que permita calcular un incremento de 10% para los que tienen menos de 50 hs. De vacaciones, 10% para los que tienen entre 50 y 70 hs. De vacaciones y un 5 % para el resto. Utilizar la tabla: HumanResources.Employee y columna: VacationHours

```sql

```

14.- Informar la cantidad de Empleados masculinos y femeninos (Gender = ‘M’ y Gender = ‘F’) de la tabla: HumanResources.Employee

```sql

```

15.- Informar la suma total de edades, la cantidad de personas y el promedio de edad.

```sql

```

16.- Mostrar la cantidad total de productos, el peso total de los productos y el peso promedio de cada uno de ellos. Colocar etiquetas representativas en las columnas.

```sql

```

17.- Mostrar la cantidad total de productos por subcategoría. Utilizar la tabla: Production.Product y la columna: ProductSubcategoryID

```sql

```

18.- Mostrar el monto del producto de mayor costo para cada subcategoría, excluir los productos cuya subcategoría sea nula. Utilizar la tabla: Production.Product y la columna ProductSubcategory

```sql

```

19.- Mostrar la cantidad total de unidades de medidas diferentes utilizadas en la tabla Productos.
Utilizar la tabla: Production.Product y la columna SizeUnitMeasureCode

```sql

```

20.- Mostrar el promedio de precios por subcategorías solo para los que superen los $100. Utilizar la tabla: Production.Product y las columnas ProductSubcategoryID y ListPrice

```sql

```

21.- Mostrar en una sola consulta la cantidad de productos de color blanco, negro y amarillo. Utilizar la tabla: Production.Product y la columna Color

```sql

```

22.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría a la que pertenecen cada uno de los productos. Mostrar solamente los departamentos que tienen color asignado. Utilizar para esta consulta las tablas: Production.Product y Production.ProductSubcategory

```sql

```

23.- Mostrar que variedad de colores de productos existen para las subcategorías que estén ubicadas entre 1 y 20

```sql

```

24.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría y el número y nombre de la categoría a la que pertenecen cada uno de los productos. Usar alias para identificar los nombres de categoría y subcategoría
Utilizar para esta consulta las tablas:
Production.Product
Production.ProductSubcategory
Production.ProductCategory

```sql

```

25.- Idem anterior solo para la categoría Bikes

```sql

```

26.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría a la que pertenecen cada uno de los productos. En la misma consulta mostrar los productos que no tienen subcategoría asignada.

```sql

```

27.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre del modelo del producto. En la misma consulta mostrar todos los modelos que no están asignados a ningún producto.

```sql

```

28.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre del modelo del producto. En la misma consulta mostrar todos los modelos que no están asignados a ningún producto y los productos que no tengan asignados ningún modelo.

```sql

```

29.- Escriba una consulta que muestre los productos que tienen el mismo color que el producto de nombre ‘Chain’. Excluir al producto ‘Chain’ del listado.

```sql

```

30.- Escriba una consulta que muestre los productos cuyo precio estén por encima del precio promedio general, ordenar el resultado por precio del producto en forma ascendente

```sql

```

31.- Utilizando Subconsultas, Escriba una consulta que muestre los productos que pertenecen a la misma categoría a la que pertenece el producto “Road-150 Red, 62”.

```sql

```

32.- Mostrar todos los productos que hayan tenido ventas en el año 2003. Utilizar las tablas: Production.Product y Production.TransactionHistory Columna: TransactionDate

```sql

```

33.- Mostrar el nombre de los vendedores que hayan vendido al menos una unidad del o de los producto/s con menor precio. Utilizar las tablas: Purchasing.ProductVendor, Purchasing.Vendor, Production.Product (ListPrice)

```sql

```
