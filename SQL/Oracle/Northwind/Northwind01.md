# Northwind 01

Consultas para la base de datos de Microsoft "Northwind". Originalmente para SQL Server pero portada a Oracle XE

![Northwind](./images/Northwind_E-R_Diagram.png "Nothwind E-R" )   
 	      
## Consultas   
       
   1.Utilizando la base de datos Northwind . Genere una lista de selección de la tabla Employees (Empleado) donde solo se genere una columna de salida y esta contenga los campos: EmployeeID, LastName y FirstName.
 


2.Utilizando la tabla Employees liste las columnas EmployeeID, LastName, FirstName, además envié dos mensajes en conjunto con cada fila utilizando para cada uno una de las opciones de literales. 


   3.Suponga que queremos ver aquellos productos (Tabla Products) cuyos valores se encuentran entre los 4 y 20 Dólares. 



   4.Liste los campos de la tabla productos que tengan exactamente un precio de 18, 19 y 10 dolares. 



   5.Encontrar todos los apellidos (LastName) en la tabla Employees que comiencen con la letra S. Use el carácter comodín %. 


   6.Para recuperar el apellido de los Empleados cuya primera letra comienza entre A y M. Utilice el comodín [ ].




   7.Usar Base de Datos Pubs . Para recuperar la información de un autor cuyo ID comienza con el numero 724, sabiendo que cada ID tiene el formato de tres dígitos seguidos por un guión, seguido por dos dígitos, otro guión y finalmente cuatro dígitos. Utilizar el comodín _ .



   8.Usar base de datos Northwind . Liste todos los campos de la tabla Suppliers cuya columna Región sea NULL. 



   9.Usando la base de dato PUBS. Calcula la suma de las ventas del año hasta la fecha (ytd_sales) de todos los libros de la tabla titles . 





   10.Usando la base de datos PUBS. Puede averiguar el precio promedio de todos los libros si se duplicaran los precios ( tabla titles ). 



   11 Usando la base de dato PUBS. Muestre el mayor valor de las las ventas del año (ytd_sales) de todos los libros de la tabla titles. 



   12.Usando la base de dato PUBS. Muestre el mínimo valor de las ventas del año (ytd_sales) de todos los libros de la tabla titles. 



   13.Usando la base de datos PUBS. Cuente las filas de la tabla titles. 



   14.Usando la base de datos PUBS. Cuente los datos de la tabla titles, cuyo tipo (TYPE) sea business . 


   15.Utilizando la base de datos PUBS. Liste las suma de las ventas por año ( ytd_sales ) hasta la fecha, clasificándolas por tipo (TYPE) de titulo (titles). 



   16.Liste las sumas de las ventas por año (ydt_sales) hasta la fecha, clasificándolas por tipo (TYPE) y pub_id.



   17.Utilizando el ultimo ejemplo. Liste solamente los grupos cuyo pub_id sea igual a 0877. Pista, usar having



   18.De la base de datos PUBS. Combine las tablas stores y discounts para mostrar que tienda (stor_id) ofrece un descuento y el tipo de descuento (discounttype).



   19.Utilice el mismo ejemplo anterior solo utilice en el from la instrucción FULL OUTER JOIN. 




   20.Utilice el mismo ejemplo anterior solo utilice en el from la instrucción LEFT OUTER JOIN. 



   21.Utilice el mismo ejemplo anterior solo utilice en el from la instrucción RIGHT OUTER JOIN. 




   22.Usando base de datos Northwind . Muestre los Productos (ID del Producto, Nombre y Precio Unitario) que tengan un precio unitario igual al Máximo. 




   23.Usando base de datos Northwind . Muestre los Productos (ID del Producto, Nombre y Precio Unitario) que tengan un precio unitario igual al Mínimo. 



   24.Realice una unión de las consultas anidadas vistas anteriormente. Usando ambas opciones de unión (Con y Sin ALL).
