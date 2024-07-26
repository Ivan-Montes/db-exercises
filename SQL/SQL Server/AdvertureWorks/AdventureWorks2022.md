# AdvertureWorks 2022

Consultas para la base de datos de Microsoft AdvertureWorks del [backup 2022](https://github.com/Microsoft/sql-server-samples/releases/tag/adventureworks)


## Consultas

1.- Mostrar solamente el nro. de empleado (BusinessEntityID) y cargo (Title). Tabla Person.Person.

```sql
SELECT
	BusinessEntityID, Title
FROM
	Person.Person
ORDER BY
	BusinessEntityID
```

2.- Escribir una consulta que muestre el pago histórico de los empleados y un incremento del 20% en 3 formatos diferentes, con las siguientes cabeceras “Sin formato”, “Redondeado a 1 digito decimal”, “truncado a 1 digito”. Usar función ROUND. TablaHumanResources.EmployeePayHistory.

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

3.- Listar Todos los nombres y grupos de los distintos departamentos. Tabla HumanResources.Department.

```sql
SELECT
	Name,
	GroupName
FROM
	HumanResources.Department
ORDER BY
	GroupName
```

4.- Listar sin repetir, todos los nombres de grupos de los departamentos. Tabla HumanResources.Department.

```sql
SELECT DISTINCT
	GroupName
FROM
	HumanResources.Department
ORDER BY
	GroupName
```

5.- Crear una consulta que muestre el Nombre, numero, color, precio y tamaño de los productos que cuesten mas de $10,00. Tabla Production.Product.

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

6.- Escribir y ejecutar una sentencia SELECT que devuelva los productos cuyo número de producto comience con LJ Tabla Production.Product.

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

7.- Crear una consulta que muestre el número y nombre en una sola columna, separados por un guión para todos los productos de color ‘Black’. Tabla Production.Product.

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

8.- Crear una consulta que muestre los productos cuyos precios estén entre 10,00 y 100,00. Tabla Production.Product.

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

9.- Crear una consulta que muestre los productos que hayan salido a la venta entre los año 2011 y 2013, ordenar el resultado por dicha fecha en forma descendente. Tabla a utilizar: Production.Product, columna: SellStartDate

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
SELECT 
	Name,
	ProductSubcategoryID
FROM
	Production.Product
WHERE
	ProductSubcategoryID = 1 OR ProductSubcategoryID = 2 
GROUP BY
	ProductSubcategoryID,
	Name
ORDER BY
	Name
```

11.- Crear una consulta que muestre los empleados y su cargo cuyo login comience con la letra ‘k’ (Posición 17). Utilizar la tabla: HumanResources.Employee y columna: LoginID

```sql
SELECT 
	LoginID,
	BusinessEntityID,
	JobTitle
FROM
	HumanResources.Employee
WHERE
	SUBSTRING(LoginID,17,1) LIKE 'k%'
ORDER BY
	LoginID
```

12.- Crear una consulta para mostrar los 10 empleados con mayor cantidad de horas de vacaciones. Utilizar la tabla: HumanResources.Employee y columnas: LoginID, Title, VacationHours

```sql
SELECT TOP 10
	LoginID,
	JobTitle,
	VacationHours
FROM
	HumanResources.Employee
ORDER BY
	VacationHours DESC,
	JobTitle
```

13.- Crear una consulta que permita calcular un incremento de 15% para los que tienen menos de 50 hs. De vacaciones, 10% para los que tienen entre 50 y 70 hs. De vacaciones y un 5 % para el resto. Utilizar la tabla: HumanResources.Employee y columna: VacationHours

```sql
SELECT
	LoginID,
	JobTitle,
	VacationHours,
	CASE 
		WHEN VacationHours < 50 THEN VacationHours * 1.15
		WHEN VacationHours < 70 THEN VacationHours * 1.05
		ELSE VacationHours * 1.10
	END AS "Vacaciones Normalizadas"
FROM
	HumanResources.Employee
ORDER BY
	VacationHours DESC,
	JobTitle
```

14.- Informar la cantidad de Empleados masculinos y femeninos (Gender = ‘M’ y Gender = ‘F’) de la tabla: HumanResources.Employee

```sql
SELECT 
	Gender,
	COUNT(Gender) AS "Cantidad"
FROM
	HumanResources.Employee
GROUP BY
	Gender
ORDER BY
	"Cantidad" DESC
```

15.- Informar la suma total de edades, la cantidad de personas y el promedio de edad. Tabla HumanResources.Employee.

```sql
SELECT 
	COUNT(BusinessEntityID) AS "Cantidad Personas",
	AVG(DATEDIFF(YEAR, BirthDate, CONVERT(DATE, GETDATE()))) AS "Media de edad",
	SUM(DATEDIFF(YEAR, BirthDate, CONVERT(DATE, GETDATE()))) AS "Suma de edades"
FROM
	HumanResources.Employee
```

16.- Mostrar la cantidad total de productos, el peso total de los productos y el peso promedio de cada uno de ellos. Colocar etiquetas representativas en las columnas.

```sql
SELECT 
	COUNT(ProductId) AS "Cantidad de Productos",
	CAST(ROUND(AVG(Weight),2) AS NUMERIC(12,2)) AS "Peso Medio de los Productos",
	SUM(Weight) AS "Peso Total de los Productos"
FROM
	Production.Product
```

17.- Mostrar la cantidad total de productos por subcategoría. Utilizar la tabla: Production.Product y la columna: ProductSubcategoryID

```sql
SELECT 
	COUNT(ProductId) AS "Cantidad de Productos",
	ProductSubcategoryID AS "Subcategoría"
FROM
	Production.Product
GROUP BY
	ProductSubcategoryID
ORDER BY
	"Cantidad de Productos" DESC
```

18.- Mostrar el monto del producto de mayor costo para cada subcategoría, excluir los productos cuya subcategoría sea nula. Utilizar la tabla: Production.Product y la columna ProductSubcategory

```sql
SELECT 
	p.ProductSubcategoryID AS Subcategoria_ID,
	MAX(p.listprice) AS Precio_Mayor
FROM
	Production.Product p
WHERE
	p.ProductSubcategoryID IS NOT NULL
GROUP BY
	p.ProductSubcategoryID
```

```sql
SELECT 
	ProductSubcategoryID AS "Subcategoría",
	ListPrice
FROM
	Production.Product p
WHERE
	ProductSubcategoryID IS NOT NULL
GROUP BY
	ProductSubcategoryID,
	ListPrice
HAVING
	 ListPrice >= ALL (
			SELECT pp.ListPrice
			FROM Production.Product pp
			WHERE pp.ProductSubcategoryID = p.ProductSubcategoryID
			)
ORDER BY
	ProductSubcategoryID
```

19.- Mostrar la cantidad total de unidades de medidas diferentes utilizadas en la tabla Productos.
Utilizar la tabla: Production.Product y la columna SizeUnitMeasureCode

```sql
SELECT 
	COUNT(DISTINCT SizeUnitMeasureCode)
FROM
	Production.Product
WHERE
	SizeUnitMeasureCode IS NOT NULL
GROUP BY
	SizeUnitMeasureCode
```

```sql
SELECT
	COUNT(*)
FROM
	(
	SELECT 
		SizeUnitMeasureCode
	FROM
		Production.Product
	WHERE
		SizeUnitMeasureCode IS NOT NULL
	GROUP BY
		SizeUnitMeasureCode
	) p
```

20.- Mostrar el promedio de precios por subcategorías solo para los promedios que superen los $100. Utilizar la tabla: Production.Product y las columnas ProductSubcategoryID y ListPrice

```sql
SELECT 
	ProductSubcategoryID AS "Subcategoría",
	AVG(ListPrice) AS "Precio Medio"
FROM
	Production.Product
WHERE
	ProductSubcategoryID IS NOT NULL
GROUP BY
	ProductSubcategoryID
HAVING	
	AVG(ListPrice) > 100
ORDER BY
	AVG(ListPrice) DESC
```

21.- Mostrar en una sola consulta la cantidad de productos de color blanco, negro y amarillo. Utilizar la tabla: Production.Product y la columna Color

```sql
SELECT 
	Color,
	COUNT(COLOR) AS "Cantidad"
FROM
	Production.Product
WHERE
	Color IN('white', 'black','yellow')
GROUP BY
	Color
ORDER BY
	"Cantidd" DESC
```

22.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría a la que pertenecen cada uno de los productos. Mostrar solamente los departamentos que tienen color asignado. Utilizar para esta consulta las tablas: Production.Product y Production.ProductSubcategory

```sql
SELECT 
	p.ProductID,
	p.Name,
	p.Color,
	ps.ProductSubcategoryID,
	ps.Name
FROM
	Production.Product p
INNER JOIN
	Production.ProductSubcategory ps
	ON ps.ProductSubcategoryID = p.ProductSubcategoryID
WHERE
	Color IS NOT NULL
ORDER BY
	ps.ProductSubcategoryID
```

23.- Mostrar que variedad de colores de productos existen para las subcategorías que estén ubicadas entre 1 y 20

```sql
SELECT 
	Color
FROM
	Production.Product
WHERE
	Color IS NOT NULL AND 
	ProductSubcategoryID BETWEEN 1 AND 20
GROUP BY
	Color
ORDER BY
	Color
```

```sql
SELECT DISTINCT
	Color
FROM
	Production.Product
WHERE
	Color IS NOT NULL AND 
	ProductSubcategoryID BETWEEN 1 AND 20
ORDER BY
	Color
```

24.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría y el número y nombre de la categoría a la que pertenecen cada uno de los productos. Usar alias para identificar los nombres de categoría y subcategoría
Utilizar para esta consulta las tablas:
Production.Product
Production.ProductSubcategory
Production.ProductCategory

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	ps.ProductSubcategoryID,
	ps.Name AS "Nombre Subcategoría",
	pc.ProductCategoryID,
	pc.Name AS "Nombre Categoría"
FROM
	Production.Product p
INNER JOIN
	Production.ProductSubcategory ps
	ON ps.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN
	Production.ProductCategory pc
	ON pc.ProductCategoryID = ps.ProductCategoryID

ORDER BY
	pc.ProductCategoryID,
	ps.ProductSubcategoryID,
	p.Name 
```

25.- Idem anterior solo para la categoría Bikes

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	ps.ProductSubcategoryID,
	ps.Name AS "Nombre Subcategoría",
	pc.ProductCategoryID,
	pc.Name AS "Nombre Categoría"
FROM
	Production.Product p
INNER JOIN
	Production.ProductSubcategory ps
	ON ps.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN
	Production.ProductCategory pc
	ON pc.ProductCategoryID = ps.ProductCategoryID
WHERE
	pc.Name LIKE 'bikes'
ORDER BY
	pc.ProductCategoryID,
	ps.ProductSubcategoryID,
	p.Name 
```

26.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre de la subcategoría a la que pertenecen cada uno de los productos. En la misma consulta mostrar los productos que no tienen subcategoría asignada. Tabla Product y ProductSubcategory.

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	ps.ProductSubcategoryID,
	ps.Name AS "Nombre Subcategoría"
FROM
	Production.Product p
LEFT JOIN
	Production.ProductSubcategory ps
	ON ps.ProductSubcategoryID = p.ProductSubcategoryID
ORDER BY
	ps.ProductSubcategoryID,
	p.Name 
```

27.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre del modelo del producto. En la misma consulta mostrar todos los modelos que no están asignados a ningún producto. Tabla Product y ProductModel.

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	pm.ProductModelID,
	pm.Name AS "Nombre Modelo"
FROM
	Production.Product p
RIGHT JOIN
	Production.ProductModel pm
	ON pm.ProductModelID = p.ProductModelID
ORDER BY
	p.ProductID,
	p.Name
```

28.- Escribir una consulta para visualizar número y nombre del producto, el número y el nombre del modelo del producto. En la misma consulta mostrar todos los modelos que no están asignados a ningún producto y los productos que no tengan asignados ningún modelo. Tabla Product y ProductModel.

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	pm.ProductModelID,
	pm.Name AS "Nombre Modelo"
FROM
	Production.Product p
FULL JOIN
	Production.ProductModel pm
	ON pm.ProductModelID = p.ProductModelID
ORDER BY
	p.ProductID,
	p.Name
```

29.- Escriba una consulta que muestre los productos que tienen el mismo color que el producto de nombre ‘Chain’. Excluir al producto ‘Chain’ del listado. Tabla Product.

```sql
SELECT 
	ProductID,
	Name AS "Nombre Producto",
	Color
FROM
	Production.Product
WHERE
	Color LIKE (
		SELECT TOP 1 Color 
		FROM Production.Product 
		WHERE Name LIKE 'Chain'
		) AND
	Name NOT LIKE 'Chain'
ORDER BY
	ProductID,
	Name
```

30.- Escriba una consulta que muestre los productos cuyo precio estén por encima del precio promedio general, ordenar el resultado por precio del producto en forma ascendente. Tabla Product.

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	p.ListPrice AS "Precio"
FROM
	Production.Product p
WHERE
	ListPrice > ALL (
			SELECT AVG(pp.ListPrice)
			FROM Production.Product pp
			)
ORDER BY
	p.ListPrice,
	p.Name
```

31.- Utilizando Subconsultas, Escriba una consulta que muestre los productos que pertenecen a la misma categoría a la que pertenece el producto “Road-150 Red, 62”.

```sql
SELECT 
	p.ProductID,
	p.Name AS "Nombre Producto",
	p.ListPrice AS "Precio",
	p.ProductSubcategoryID AS "Subcategoría"
FROM
	Production.Product p
WHERE
	ProductSubcategoryID IN (
		SELECT
			ProductSubcategoryID
		FROM
			Production.ProductSubcategory
		WHERE
			ProductCategoryID = (
			SELECT
				ProductCategoryID
			FROM
				Production.ProductSubcategory
			WHERE
				ProductSubcategoryID = (
					SELECT 
						pp.ProductSubcategoryID
					FROM 
						Production.Product pp
					WHERE 
						pp.Name LIKE 'Road-150 Red, 62'
			)))
ORDER BY
	p.Name
```

32.- Mostrar todos los productos que hayan tenido ventas en el año 2013. Utilizar las tablas: Production.Product y Production.TransactionHistory Columna: TransactionDate

```sql
SELECT
	p.ProductID,
	p.Name AS "Nombre Producto",
	YEAR(t.TransactionDate) AS "Año"
FROM
	Production.Product p
INNER JOIN
	Production.TransactionHistory t
	ON t.ProductID = p.ProductID
WHERE
	YEAR(t.TransactionDate) = 2013
GROUP BY
	p.ProductID,
	p.Name,
	YEAR(t.TransactionDate)
ORDER BY
	p.ProductID
```

33.- Mostrar el nombre de los vendedores que hayan vendido al menos una unidad del o de los producto/s con menor precio. Utilizar las tablas: Purchasing.ProductVendor, Purchasing.Vendor, Production.Product (ListPrice)

```sql
SELECT
	pv.BusinessEntityID AS "Vendedor ID",
	v.Name AS "Nombre"
FROM
	Production.Product p
INNER JOIN
	Purchasing.ProductVendor pv
	ON pv.ProductID = p.ProductID
INNER JOIN
	Purchasing.Vendor v
	ON v.BusinessEntityID = pv.BusinessEntityID
WHERE
	p.ListPrice > 0 AND
	p.ListPrice <= ALL  (
			SELECT pp.ListPrice
			FROM Production.Product pp
			WHERE pp.ListPrice > 0
			)
ORDER BY
	pv.BusinessEntityID
```

34.- Mostrar a todos los empleados (LastName, FirstName, Id, GroupName)que se encuentran en el departamento de Manufacturing or Quality Assurance (Columna GroupName, tablas Department, EmployeeDepartmentHistory, Person)

```sql
SELECT 
	p.LastName,
	p.FirstName,
	p.BusinessEntityID,
	d.Name AS "Departamento",
	d.GroupName AS "Grupo Departamental"
FROM
	HumanResources.Department d
INNER JOIN
	HumanResources.EmployeeDepartmentHistory ed
	ON ed.DepartmentID = d.DepartmentID
INNER JOIN
	HumanResources.Employee e
	ON e.BusinessEntityID = ed.BusinessEntityID
INNER JOIN
	Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE
	d.GroupName LIKE 'manufacturing' OR
	d.GroupName LIKE 'QUALITY ASSURANCE'
ORDER BY
	p.LastName,
	p.FirstName
```

35.- Indicar el listado de los empleados del sexo masculino y que son solteros. Tablas Emloyee y Person

```sql
SELECT 
	p.LastName,
	p.FirstName,
	p.BusinessEntityID,
	e.Gender,
	e.MaritalStatus
FROM
	HumanResources.Employee e
INNER JOIN
	Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE
	e.Gender LIKE 'M' AND
	e.MaritalStatus LIKE 'S'
ORDER BY
	p.LastName,
	p.FirstName
```

36.- Empleados cuyo apellido sea con la letra "S". Tabla Person.Person

```sql
SELECT 
	LastName,
	FirstName,
	BusinessEntityID
FROM	
	Person.Person 
WHERE
	LastName LIKE 'S%'
ORDER BY
	LastName,
	FirstName
```

37.- Los empleados que son del estado de Florida. Tablas: Person,BusinessEntity,BusinessEntityAddress,Address,StateProvince. Campos: LastName, FirstName, BusinessEntityID, StateProvinceID, nombre de la provincia. 	

```sql
SELECT 
	LastName,
	FirstName,
	p.BusinessEntityID,
	s.StateProvinceID,
	s.Name	
FROM	
	Person.Person p
INNER JOIN
	Person.BusinessEntity be
	ON be.BusinessEntityID = p.BusinessEntityID
INNER JOIN
	Person.BusinessEntityAddress ba
	ON ba.BusinessEntityID = be.BusinessEntityID
INNER JOIN
	Person.Address a
	ON a.AddressID = ba.AddressID
INNER JOIN
	Person.StateProvince s
	ON s.StateProvinceID = a.StateProvinceID
WHERE
	s.Name LIKE 'FLORIDA%'
ORDER BY
	LastName,
	FirstName
```

38.- La suma de las ventas hechas por cada empleado, y agrupadas por año Tablas Sales.SalesPersonQuotaHistory y Person.Person. Campos: BusinessEntityID,LastName,FirstName, SalesQuota, QuotaDate.

```sql
SELECT 
	s.BusinessEntityID,
	LastName,
	FirstName,
	SUM(SalesQuota) AS "Sumatorio Ventas",
	YEAR(QuotaDate) AS "Año"
FROM	
	Sales.SalesPersonQuotaHistory s
INNER JOIN
	Person.Person p
	ON p.BusinessEntityID = s.BusinessEntityID
GROUP BY
	s.BusinessEntityID,
	YEAR(QuotaDate),
	LastName,
	FirstName
ORDER BY
	s.BusinessEntityID,
	YEAR(QuotaDate) DESC
```

39.- El producto más vendido. Tabla Sales.SalesOrderDetail y Production.Product. Campos ProductID, Name, ProductSubcategoryID, OrderQty


```sql
WITH cte_accumulative_sales AS (
SELECT
	ProductID,
	SUM(OrderQty) AS unidades_vendidas
FROM
	Sales.SalesOrderDetail
GROUP BY
	ProductID
)

SELECT	
	p.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	cte_as.unidades_vendidas
FROM
	cte_accumulative_sales cte_as
INNER JOIN
	Production.Product p
	ON p.ProductID = cte_as.ProductID
WHERE
	cte_as.unidades_vendidas >= ALL (SELECT unidades_vendidas
								FROM cte_accumulative_sales)
;
```

```sql
SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	SUM(OrderQty) AS "Unidades Totales"
	
FROM
	Sales.SalesOrderDetail s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
GROUP BY
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID
HAVING
	SUM(OrderQty) >= ALL (
			SELECT SUM(OrderQty) 
			FROM Sales.SalesOrderDetail 
			GROUP BY ProductID
			)
ORDER BY
	s.ProductID
```

```sql
DECLARE @accumulative_sales INT = (
									SELECT MAX(sum_orderqty)
									FROM (
										SELECT SUM(OrderQty) AS sum_orderqty 
										FROM Sales.SalesOrderDetail 
										GROUP BY ProductID
										)
								   AS subquery);
SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	SUM(OrderQty) AS "Unidades Totales"
	
FROM
	Sales.SalesOrderDetail s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
GROUP BY
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID
HAVING
	SUM(OrderQty) = @accumulative_sales
ORDER BY
	s.ProductID
```

40.- El producto menos vendido, Tabla Sales.SalesOrderDetail y Production.Product. Campos ProductID, Name, ProductSubcategoryID, OrderQty

```sql
WITH cte_accumulative_sales AS (
SELECT
	ProductID, 
	SUM(OrderQty) AS sumatory_sales
FROM
	Sales.SalesOrderDetail
GROUP BY
	ProductID
),

cte_min_accumulative_sales AS (
SELECT
	MIN(sumatory_sales) AS min_sumatory_sales
FROM
	cte_accumulative_sales
)

SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	sumatory_sales
FROM
	cte_accumulative_sales s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
WHERE
	sumatory_sales =  (
						SELECT min_sumatory_sales
						FROM cte_min_accumulative_sales
						)
ORDER BY
	s.ProductID;
```

```sql
SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	SUM(OrderQty) AS "Unidades Totales"
	
FROM
	Sales.SalesOrderDetail s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
GROUP BY
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID
HAVING
	SUM(OrderQty) <= ALL (
			SELECT SUM(OrderQty) 
			FROM Sales.SalesOrderDetail 
			GROUP BY ProductID
			)
ORDER BY
	s.ProductID
```
```sql
DECLARE @min_sale INT = (
						SELECT MIN(sum_qty)
						FROM (
							SELECT SUM(OrderQty) AS sum_qty 
							FROM Sales.SalesOrderDetail 
							GROUP BY ProductID
							) sq_sum_qty
						);

SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	SUM(OrderQty) AS "Unidades Totales"	
FROM
	Sales.SalesOrderDetail s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
GROUP BY
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID
HAVING
	SUM(OrderQty) = @min_sale
ORDER BY
	s.ProductID;
```

41.- Listado de productos por número de ventas ordenado de mayor a menor. Tablas Sales.SalesOrderDetail y Production.Product. Campos ProductID, Name y OrderQty.

```sql
SELECT
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID,
	SUM(OrderQty) AS "Unidades Totales"	
FROM
	Sales.SalesOrderDetail s
INNER JOIN
	Production.Product p
	ON p.ProductID = s.ProductID
GROUP BY
	s.ProductID,
	p.Name,
	p.ProductSubcategoryID
ORDER BY
	SUM(OrderQty) DESC,
	p.Name
```

42.- Las ventas por territorio. Tablas SalesOrderHeader y SalesTerritory. Campos TerritoryID, Name, SubTotal, TotalDue.

```sql
SELECT
	SUM(SubTotal) AS "Total sin IVA ni portes",
	SUM(TotalDue) AS "Total",
	s.TerritoryID,
	t.Name
FROM
	Sales.SalesOrderHeader s
INNER JOIN
	Sales.SalesTerritory t
	ON t.TerritoryID = s.TerritoryID
GROUP BY
	s.TerritoryID,
	t.Name
ORDER BY
	SUM(SubTotal) DESC,
	SUM(TotalDue) DESC
```
