# Northwind 01

Consultas para la base de datos de Microsoft "Northwind". Originalmente para SQL Server pero portada a Oracle XE

[![Diagrama ER de BD Northwind](./images/northwind_er.png "Nothwind E-R")](https://github.com/Microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs)
    
## Uso
      
- Lanzar desde dentro de la carpeta principal "Northwind & Pubs" para crear la BD:

```bash
docker run -d --name oracle-sql-nwnd \
-p 1521:1521 -p 5500:5500 \
-e ORACLE_PWD=12345 \
-v oracle-sql-nwnd-vol:/opt/oracle/oradata \
-v .:/opt/oracle/scripts/startup \
container-registry.oracle.com/database/express:21.3.0-xe
```

- Parar o arrancar el contenedor previamente creado

```bash
docker stop oracle-sql-nwnd
docker start oracle-sql-nwnd
```
   
- Datos de conexión

```
host: localhost
database: xe
user: sys
role: sysdba
password: 12345
```

## Consultas 
       
1 Utilizando la base de datos Northwind. Genere una lista de selección de la tabla Employees (Empleado) donde solo se genere una columna de salida y esta contenga los campos: EmployeeID, LastName y FirstName.
   
```sql
SELECT
    employeeid || '/ ' ||
    lastname || ', ' ||
    firstname || '.' AS "Nombre Completo"
FROM
    employees
ORDER BY
    employeeid
```
  
2 Utilizando la tabla Employees liste las columnas EmployeeID, LastName, FirstName, además añada dos columnas cada una con un mensaje fijo. 

```sql
SELECT
    employeeid AS "Id",
    lastname AS "Apellido",
    firstname AS "Nombre",
    'Indefinido' AS "Contrato",
    'Activo' AS "Estado"
FROM
    employees
ORDER BY
    employeeid
```
    
3 Suponga que queremos ver aquellos productos (Tabla Products) cuyos valores se encuentran entre los 4 y 20 Dólares. 

```sql
SELECT
    productid,
    productname,
    unitprice,
    discontinued
FROM
    products
WHERE
    unitprice BETWEEN 4 AND 20
ORDER BY
    unitprice DESC
```
  
4 Liste los campos de la tabla productos que tengan exactamente un precio de 18, 19 y 10 dolares. 

```sql
SELECT
    productid,
    productname,
    unitprice,
    discontinued
FROM
    products
WHERE
    unitprice IN(18,19,10)
ORDER BY
    unitprice DESC
```

5 Encontrar todos los apellidos (LastName) en la tabla Employees que comiencen con la letra S. Use el carácter comodín %. 
   
```sql
SELECT
    employeeid AS "ID",
    lastname AS "APELLIDO",
    firstname AS "NOMBRE",
    title AS "PUESTO"    
FROM
    employees
WHERE
    lastname like 'S%'
ORDER BY
    employeeid,
    lastname
```

6 Para recuperar el apellido de los Empleados cuya primera letra comienza entre A y M. Utilice el comodín [ ].

```sql
SELECT
    employeeid AS "ID",
    lastname AS "APELLIDO",
    firstname AS "NOMBRE",
    title AS "PUESTO"    
FROM
    employees
WHERE
    REGEXP_LIKE( lastname, '^[A-M]' )
ORDER BY
    lastname,
    firstname
```
   
7 Liste todos los campos de la tabla Suppliers cuya columna Región sea NULL. 

```sql
SELECT
    supplierid AS "ID",
    companyname AS "Nombre",
    contactname AS "Contacto",
    city AS "Ciudad",
    region
from 
    SUPPLIERS
WHERE 
    REGION is NULL
ORDER BY
    companyname
```
  
8 Muestre los Productos (ID del Producto, Nombre y Precio Unitario) que tengan un precio unitario igual al Máximo. Tabla products

```sql
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
            SELECT
                MAX(p1.unitprice)
            FROM
                products p1                
    )
ORDER BY
    productname
```

```sql
WITH CTE_MAX_PRICE AS(
	SELECT Max(UNITPRICE) AS MAX_PRICE
	FROM products)
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
INNER JOIN CTE_MAX_PRICE CTE
	ON CTE.MAX_PRICE = UNITPRICE 
```

9 Muestre los Productos (ID del Producto, Nombre y Precio Unitario) que tengan un precio unitario igual al Mínimo. 

```sql
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
        SELECT
            MIN(p1.unitprice)
        FROM
            products p1                
    )
ORDER BY
    productname
```

```sql
WITH CTE_MIN_PRICE AS(
	SELECT MIN(UNITPRICE) AS MIN_PRICE
	FROM products)
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
INNER JOIN CTE_MIN_PRICE CTE
	ON CTE.MIN_PRICE = UNITPRICE 
```

10 Realice una unión de las consultas anidadas vistas anteriormente. Usando ambas opciones de unión (Con y Sin ALL).
  
```sql
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
        SELECT
            MAX(p1.unitprice)
        FROM
            products p1                
    )    
UNION
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
        SELECT
            MIN(p1.unitprice)
        FROM
            products p1                
    )
ORDER BY
    "Precio Unitario" ASC
```

```sql
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
        SELECT
            MAX(p1.unitprice)
        FROM
            products p1                
    )    
UNION ALL
SELECT
    productid AS "Id",
    productname AS "Nombre",
    unitprice AS "Precio Unitario"
FROM 
    products
WHERE
    unitprice = (
        SELECT
            MIN(p1.unitprice)
        FROM
            products p1                
    )
ORDER BY
    "Precio Unitario" ASC
```
                    
11 Crear una consulta que muestre el nombre de empleado y el número de empleados que cada uno de los empleados tiene a su cargo. Tabla employees

```sql
SELECT
    e.lastname || ', ' || e.firstname AS "Nombre Completo",    
    (select count(*) from employees ee where ee.reportsto = e.employeeid) AS "Nºde Empleados"
FROM
    employees e
ORDER BY
    lastname 
```

```sql
SELECT
    lastname || ', ' || firstname AS "Nombre Completo",
    "Nºde Empleados"
FROM
    employees e
INNER JOIN 
    (SELECT
        reportsto,
        count(employeeid) AS "Nºde Empleados"
    FROM
        employees
    GROUP BY
        reportsto
    ORDER BY
        reportsto) e1
    ON e1.reportsto = e.employeeid
ORDER BY
    lastname
```

12 Mostrar una consulta que muestre el nombre del producto, el número de unidades totales vendidas, de aquel producto del que mas unidades haya vendido la empresa. Tabla products y orderdetails
                 
```sql
WITH CTE_SALES_BY_PRO AS(
SELECT 
	productid,
	SUM(QUANTITY) AS "CANTIDAD_VENDIDA",
	RANK () OVER(ORDER BY SUM(QUANTITY) DESC) AS "ranking"
FROM
	OrderDetails
GROUP BY
	productid
),
CTE_MAX_SALES AS (
SELECT 
*
FROM 
CTE_SALES_BY_PRO
WHERE 
"ranking" = 1
)
SELECT 
	p.productname,
    CANTIDAD_VENDIDA
FROM 
products p
INNER JOIN CTE_MAX_SALES CTE
	ON CTE.productid = p.productid 
```
                        
```sql
SELECT
    p.productname,
    SUM(quantity) AS "CANTIDAD_VENDIDA"
FROM
    products p
INNER JOIN 
     orderdetails o
     ON o.productid = p.productid
GROUP BY
    p.productname
HAVING
    SUM(quantity) >= ALL (
        SELECT SUM(quantity)
        FROM orderdetails
        GROUP BY productid
        )
```

13 Mostrar una consulta que obtenga el nombre completo de empleado, el número de pedidos que ha tramitado, y el dinero que ha generado en la empresa, de todos aquellos empleados que han tramitado pedidos. Ordenar según la cantidad de pedidos en orden descendente. En caso de existir algún empleado que no haya tramitado pedidos se mostrará en las columnas número de pedidos y generado un valor nulo. Tablas employees, orders, y orderdetails. Campos lastname,firstname,unitprice,quantity

```sql
SELECT
    e.lastname || ', ' || e.firstname AS "Nombre Completo",
    COUNT(o.orderid) AS "Nº de Pedidos",
    SUM(od."Sumatorio cantidad x precio") AS "Dinero Generado"
FROM
    employees e
LEFT JOIN orders o
    ON o.employeeid = e.employeeid
LEFT JOIN ( 
	SELECT 
		orderid,
	    ROUND(SUM(unitprice * quantity),2) AS "Sumatorio cantidad x precio"
	FROM
		orderdetails
	GROUP BY
		orderid) od
	ON od.orderid = o.orderid
GROUP BY
    e.lastname,
    e.firstname
ORDER BY
    "Nº de Pedidos" DESC
```

14 Modificar el ejercicio anterior para que muestre en los valores nulos de las columnas número de pedidos y dinero generado un 0.

```sql
SELECT
    e.lastname || ', ' || e.firstname AS "Nombre Completo",
     COALESCE(COUNT(o.orderid),0) AS "Nº de Pedidos",
     COALESCE(SUM(od."Sumatorio cantidad x precio"),0) AS "Dinero Generado"
FROM
    employees e
LEFT JOIN orders o
    ON o.employeeid = e.employeeid
LEFT JOIN ( 
	SELECT 
		orderid,
	    ROUND(SUM(unitprice * quantity),2) AS "Sumatorio cantidad x precio"
	FROM
		orderdetails
	GROUP BY
		orderid) od
	ON od.orderid = o.orderid
GROUP BY
    e.lastname,
    e.firstname
ORDER BY
    "Nº de Pedidos" DESC
```

15 Modificar el ejercicio anterior para que muestre en lugar de un 0 las cadenas "Sin Pedidos" y "Sin dinero".

```sql
SELECT
    e.lastname || ', ' || e.firstname AS "Nombre Completo",
    CASE 
      WHEN COUNT(o.orderid) IS NULL OR COUNT(o.orderid) = 0
      THEN 'Sin Pedidos'
      ELSE TO_CHAR(COUNT(o.orderid))
    END AS "Nº de Pedidos",
    CASE
      WHEN SUM(od."Sumatorio cantidad x precio") IS NULL
      THEN 'Sin dinero'
      ELSE TO_CHAR(SUM(od."Sumatorio cantidad x precio"))
    END AS "Dinero Generado" 
FROM
    employees e
LEFT JOIN orders o
    ON o.employeeid = e.employeeid
LEFT JOIN ( 
	SELECT 
		orderid,
	    ROUND(SUM(unitprice * quantity),2) AS "Sumatorio cantidad x precio"
	FROM
		orderdetails
	GROUP BY
		orderid) od
	ON od.orderid = o.orderid
GROUP BY
    e.lastname,
    e.firstname
ORDER BY
    "Nº de Pedidos" DESC
```

16 Crear una consulta que muestre el nombre completo de empleado, el número de pedidos tramitado por cada empleado, de aquellos empleados que han tramitado 5 o mas pedidos. Ordenar según la cantidad de pedidos en orden descendente. Tablas employees, orders

```sql
SELECT
    e.lastname || ', ' || e.firstname AS "Nombre Completo",
    COUNT(o.orderid) Numero_de_Pedidos      
FROM
    employees e
INNER JOIN 
    orders o
    ON o.employeeid = e.employeeid
GROUP BY
    e.lastname,
    e.firstname
HAVING
    COUNT(o.orderid) >= 5
ORDER BY
    Numero_de_Pedidos DESC  
```

17 Crear una consulta que muestre el nombre del cliente, el número de pedidos que nos ha realizado el cliente, el dinero que nos ha dejado en la empresa, de todos los clientes que sean de USA y que nos han realizado 2 o mas pedidos.Tablas customers, orders, orderdetails. Campos companyname, unitprice, quantity.

```sql
SELECT
    c.companyname AS "Company Name",
    COUNT(o.orderid) AS "Numero de Pedidos",
    SUM(od."Sumatorio Cantidad x Precio") AS "Dinero dejado en la empresa"
FROM
    customers c
INNER JOIN orders o
    ON o.customerid = c.customerid 
INNER JOIN (
		SELECT orderid, SUM(quantity * unitprice) AS "Sumatorio Cantidad x Precio"
		FROM orderdetails
		GROUP BY orderid) od
	ON od.orderid = o.orderid	
WHERE
    c.country = 'USA'
GROUP BY
    c.companyname
HAVING
    COUNT(o.orderid) >= 2
ORDER BY
    "Numero de Pedidos" DESC 
```

18 Crear una consulta que muestre ID, nombre completo del jefe y el número de empleados a su cargo de aquel jefe que mas empleados tenga a su cargo. Tabla employees

```sql
SELECT
    e.reportsto AS "Jefe Id",
    ee.lastname || ', ' || ee.firstname AS "Nombre Completo",
    COUNT(*) AS "Nº de Empleados"
FROM
    employees e
INNER JOIN
    employees ee
    ON ee.employeeid = e.reportsto
GROUP BY
    e.reportsto,
    ee.lastname,
    ee.firstname
HAVING
    COUNT(*) >= ALL
        (
        SELECT COUNT(*)
        FROM employees
        GROUP BY reportsto
        )
```

```sql
WITH CTE_REPORTS_AND_ID AS(
	SELECT 
		reportsto AS "ID",
		COUNT(reportsto) AS "Count ReportsTo"
	FROM
	    employees
	GROUP BY
		reportsto
),
CTE_COUNT_REPORTS AS (
	SELECT 
		COUNT(reportsto) AS "sumatorio"
	FROM
	    employees
	GROUP BY
		reportsto)
SELECT
	e.employeeid AS "Jefe Id",
    e.lastname || ', ' || e.firstname AS "Nombre Completo",
	tb_count_emps."Count ReportsTo" AS "Empleados a cargo"
FROM
    employees e
INNER JOIN CTE_REPORTS_AND_ID tb_count_emps
	ON tb_count_emps."ID" = e.employeeid	
WHERE
	tb_count_emps."Count ReportsTo" >= ALL (
	SELECT "sumatorio"
	FROM CTE_COUNT_REPORTS
	)
```

19 Obtener el nombre de la compañia y el número de pedidos del cliente que mas pedidos ha realizado en la empresa.Tablas customers, orders. Campos companyname

```sql
SELECT
   c.companyname AS "Nombre",
   COUNT(o.orderid) AS "Nº de Pedidos"
FROM
    customers c
INNER JOIN 
    orders o
    ON o.customerid = c.customerid
GROUP BY
    c.companyname
HAVING 
	COUNT(orderid) = (
		SELECT MAX("CUENTEO")
		FROM(SELECT COUNT(*)AS "CUENTEO"
			 FROM orders
			 GROUP BY customerid)			 
	)
```

```sql
WITH CTE_COUNT_ORDERS AS(
	SELECT 
		COUNT(orderid) AS "CUENTEO", 
		customerid, 
		RANK() OVER(ORDER BY COUNT(orderid) DESC) AS "ranking"
	FROM orders
	GROUP BY customerid
)	    
SELECT
	companyname,
	"CUENTEO" AS "Cantidad de Pedidos"
FROM
    customers c
INNER JOIN CTE_COUNT_ORDERS tb_count_orders
	ON tb_count_orders.CUSTOMERID = c.CUSTOMERID	
WHERE 
	"ranking" = 1
```

20 Obtener el nombre de la compañia y el volumen de negocio del cliente que mas volumen de negocio nos ha dejado en la empresa. Tablas customers, orders, orderdetails.

```sql
SELECT
   c.companyname AS "Nombre",
   ROUND(SUM(oo.unitprice * oo.quantity),2) AS "Dinero Generado" 
FROM
    customers c
INNER JOIN 
    orders o
    ON o.customerid = c.customerid
INNER JOIN 
     orderdetails oo
     ON oo.orderid = o.orderid
GROUP BY
    c.companyname
HAVING 
    ROUND(SUM(oo.unitprice * oo.quantity),2) >= ALL
            (
            SELECT
                ROUND(SUM(unitprice * quantity),2)
            FROM
                orderdetails o1 
            INNER JOIN 
                orders o2
                ON o2.orderid = o1.orderid
            GROUP BY
                customerid
            )
```

```sql
WITH CTE_SALES AS(
	SELECT
		customerid,
        ROUND(SUM(unitprice * quantity),2) AS "Sumatorio ventas"
    FROM
        orderdetails od 
    INNER JOIN 
        orders o
        ON o.orderid = od.orderid
    GROUP BY
        customerid
            ),
CTE_MAX AS(
	SELECT MAX("Sumatorio ventas") AS "Max Venta"
	FROM CTE_SALES	
)
SELECT
   c.companyname AS "Nombre",
   "Sumatorio ventas" AS "Dinero Generado" 
FROM
   customers c
INNER JOIN CTE_SALES cte
    ON cte.customerid = c.customerid
WHERE 
    "Sumatorio ventas" = (
    	SELECT "Max Venta"
    	FROM CTE_MAX
    )
```
 