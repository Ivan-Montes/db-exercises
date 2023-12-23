# DAM_BD_UT04_Ejercicios

La empresa El Desván, que se dedica a la rama textil ha decidido informatizar su gestión de pedidos. Para ello BK programación desarrollará para ellos la base de datos. El gerente le ha explicado cómo funciona la gestión de pedidos y Juan, que será quien se encargue de crear el modelo, las tablas y las consultas, ha recogido la siguiente información:

- A cada cliente se le entrega un resguardo con los datos de cada pedido que hace. De cada cliente registraremos su código de cliente, nombre, apellidos, edad.
- Los datos de un pedido son el número, fecha, gastos de envío si los hay, el importe total y fecha prevista de entrega
- Cada pedido consta de varias líneas de producto y cada línea se identifica por un número de línea (1, 2,…) del correspondiente pedido. Una línea contiene la información de un producto (código, nombre, cantidad, importe)


Con todos estos datos se ha llegado al siguiente modelo entidad-relación (a falta de completar con 
el resto de atributos de las entidades):

![DAM_BD_UT04_MER](./images/DAM_BD_UT04_MER.JPG "Database MER")


### ACLARACIONES

En la tabla PEDIDOS el atributo TOTAL es el IMPORTE_TOTAL del pedido pero sin GASTOS DE ENVIO

Tabla Lineas: 
El campo IMPORTE ya tiene calculado la cantidad del producto x precio del producto La columna NUM es el numero de la linea de ese producto en la factura

---

## Consultas

 1 Número e importe total de todos los pedidos realizados en los últimos 60 días.

```sql
SELECT 
	count(num) "Nº Pedidos", 
	sum(total) "Total"
FROM 
	pedidos
WHERE 
	fecha > ( SELECT 
				max(fecha) 
			  FROM 
				pedidos 
			) - 60
```

```
DECLARE

	fecha_max DATE;
	num_pedidos Pedidos.NUM%TYPE;
	sum_total Pedidos.TOTAL%TYPE;
	l_msg VARCHAR2(255);

BEGIN
	
	SELECT 
		MAX(FECHA)
	INTO 
		fecha_max  
	FROM 
		pedidos;

	SELECT 
		count(num) "Nº Pedidos",
		sum(total) "Total"
	INTO 
		num_pedidos, 
		sum_total
	FROM
		pedidos
	WHERE
		fecha > fecha_max - 60;

	DBMS_OUTPUT.PUT_LINE('Nº Pedidos: ' || ' ' || num_pedidos);
	DBMS_OUTPUT.PUT_LINE('Total: ' || ' ' || sum_total);
	
	EXCEPTION 
        WHEN OTHERS THEN
        l_msg := SQLERRM;  
        dbms_output.put_line('Excepción desconocida con mensaje => ' || l_msg);
END;
```

 2 Número e importe de los pedidos cuyo importe esté entre 100 y 200 €

```sql
SELECT 
	num "Nº Pedido", total "Importe"
FROM 
	pedidos
WHERE 
	total BETWEEN 100 AND 200
ORDER BY 
	num
```

```
DECLARE
	
	CURSOR c_pedidos IS
		SELECT 
			num,
			total
		FROM
			pedidos
		WHERE 
			total BETWEEN 100 AND 200
		ORDER BY 
			num;

BEGIN
	
	dbms_output.put_line(rpad('#', 10, '#'));
	dbms_output.put_line(rpad('-', 10, '-'));
	dbms_output.put_line(
		rpad('Num', 5) ||
		rpad('Total', 5)
	);
	dbms_output.put_line(rpad('-', 10, '-'));
	FOR r_pedido IN c_pedidos
	LOOP
		dbms_output.put_line(
		rpad(r_pedido.num,5) ||
		rpad(r_pedido.total, 5)
	);
	dbms_output.put_line(rpad('-', 10, '-'));
	END LOOP;
	dbms_output.put_line(rpad('#', 10, '#'));

END;
```

 3 Código y nombre de los productos ordenados ascendentemente por precio y nombre

```sql
SELECT 
	codigo,
	nombre  
FROM
	productos 
ORDER BY 
	precio, 
	nombre
```

```
DECLARE
	
	CURSOR c_productos IS
		SELECT 
			codigo,
			nombre  
		FROM
			productos 
		ORDER BY 
			precio, 
			nombre;	

BEGIN
	
	dbms_output.put_line('### Resultados ###');
	FOR r_productos IN c_productos
	LOOP
		dbms_output.put_line(r_productos.codigo || ' -- ' || r_productos.nombre);
	END LOOP;
	dbms_output.put_line('### Fin ###');

END;
```

 4 Clientes cuyo segundo apellido sea Perez

```sql
SELECT 
	* 
FROM 
	clientes
WHERE 
	apellidos LIKE '% Perez'
ORDER BY 
	codigo 
```

```
DECLARE
	
	CURSOR c_clientes IS 
		SELECT 
			* 
		FROM 
			clientes
		WHERE 
			apellidos LIKE '% Perez'
		ORDER BY 
			codigo ;

BEGIN
	
	dbms_output.put_line(rpad('-',35,'-'));
	dbms_output.put_line(
			rpad('Cod',5) ||
			rpad('Nombre',10) || 
			rpad('Apellidos',15) ||
			rpad('Edad',5) 
		);
	dbms_output.put_line(rpad('-',35,'-'));
	FOR r_clientes IN c_clientes
	LOOP
		dbms_output.put_line(
			rpad(r_clientes.codigo,5) ||
			rpad(r_clientes.nombre,10) || 
			rpad(r_clientes.apellidos,15) ||
			rpad(r_clientes.edad,5) 
		);
	dbms_output.put_line(rpad('-',35,'-'));
	END LOOP;
END;
```

 5 Número total de productos que vende la empresa (en la columna debe aparecer “Nº de productos”)

```sql
SELECT 
	count(*) AS "Nº de productos"
FROM
	productos
```

 6 Número total de productos que no han sido pedidos

```sql
SELECT 
	count(p.codigo) AS "Nº de productos no pedidos"
FROM
	productos p
LEFT JOIN lineas l
	ON l.producto = p.codigo
WHERE 
	l.producto IS NULL 
ORDER BY
	p.codigo
```

```sql
SELECT 
	count(codigo) AS "Nº de productos no pedidos"
FROM 
	productos
WHERE 
	codigo NOT IN(SELECT producto FROM lineas)
```

 7 De cada pedido, mostrar su número, importe total y datos del cliente

```sql
SELECT 
	p.num AS "Nº de pedido",
	p.total AS "Importe",
	c.codigo AS "Codigo de cliente",
	c.nombre AS "Nombre",
	c.apellidos AS "Apellidos",
	c.edad AS "Edad"
FROM
	pedidos p 
INNER JOIN clientes c
	ON p.cliente = c.codigo	
ORDER BY
	p.num
```

```
DECLARE
	
	CURSOR c_pedidos_clientes IS
		SELECT 
			p.num,
			p.total,
			c.codigo,
			c.nombre,
			c.apellidos,
			c.edad
		FROM
			pedidos p 
		INNER JOIN clientes c
			ON p.cliente = c.codigo	
		ORDER BY
			p.num;

BEGIN
	dbms_output.put_line(rpad('-',65,'-'));
	dbms_output.put_line(
			rpad('Nº', 5) ||
			rpad('Importe', 10) || 
			rpad('Cliente', 10) ||
			rpad('Nombre', 15) ||
			rpad('Apellidos', 20) ||
			lpad('Edad', 5) 
		);
	dbms_output.put_line(rpad('-',65,'-'));
	FOR r_pedidos_clientes IN c_pedidos_clientes
	LOOP
		dbms_output.put_line(
			rpad(r_pedidos_clientes.num,5) ||
			rpad(r_pedidos_clientes.total,10) || 
			rpad(r_pedidos_clientes.codigo,10) ||
			rpad(r_pedidos_clientes.nombre,15) ||
			rpad(r_pedidos_clientes.apellidos,20) ||
			lpad(r_pedidos_clientes.edad,5) 
		);
		dbms_output.put_line(rpad('-',65,'-'));
	END LOOP;
END;
```

 8 Código, nombre del cliente y número total de pedidos que ha hecho cada cliente, ordenado de más a menos pedidos

```sql
SELECT 
	p.CLIENTE,
	(SELECT c.nombre || ' ' || c.apellidos FROM clientes c WHERE c.codigo = p.cliente) AS "Datos Cliente",
	count(p.num) AS "Pedidos"
FROM
	pedidos p
GROUP BY
	p.cliente
ORDER BY
	count(p.num) DESC
```

```sql
SELECT 
	p.CLIENTE,	
	c.nombre,
	count(p.num) AS "Pedidos"
FROM
	pedidos p
INNER JOIN clientes c
	ON p.cliente = c.codigo
GROUP BY
	p.cliente, c.nombre
ORDER BY
	count(p.num) DESC
```

 9 Código, nombre del cliente y número total de pedidos que ha realizado cada cliente durante 2016

```sql
SELECT 
	p.CLIENTE,
	(SELECT c.nombre || ' ' || c.apellidos FROM clientes c WHERE c.codigo = p.cliente) AS "Datos Cliente",
	count(p.num) AS "Pedidos"
FROM
	pedidos p
WHERE 
	EXTRACT(YEAR FROM p.FECHA) = '2016'
GROUP BY
	p.cliente
ORDER BY
	count(p.num) DESC
```

```
DECLARE
	
	TYPE t_pedidos_clientes IS RECORD (
		cod_cliente pedidos.cliente%TYPE,
		nombre_cliente varchar2(64),
		cantidad_pedidos varchar2(64)
	);	

	CURSOR c_pedidos_clientes IS
		SELECT 
			p.cliente,
			(SELECT c.nombre || ' ' || c.apellidos FROM clientes c WHERE c.codigo = p.cliente),
			count(p.num)
		FROM
			pedidos p
		WHERE 
			EXTRACT(YEAR FROM p.FECHA) = '2016'
		GROUP BY
			p.cliente
		ORDER BY
			count(p.num) DESC;
		
	r_pedidos_clientes t_pedidos_clientes;

BEGIN
	dbms_output.put_line(rpad('#',5,'#'));
	dbms_output.put_line(rpad('-',40,'-'));
	dbms_output.put_line(
			rpad('Cod', 5) ||
			rpad('Nombre y Apellidos', 25) ||
			lpad('Nº Pedidos', 10) 
		);
	dbms_output.put_line(rpad('-',40,'-'));
	OPEN c_pedidos_clientes;
	LOOP
		FETCH c_pedidos_clientes INTO r_pedidos_clientes;
		EXIT WHEN c_pedidos_clientes%notfound;	
			dbms_output.put_line(
				rpad(r_pedidos_clientes.cod_cliente, 5) ||
				rpad(r_pedidos_clientes.nombre_cliente, 25) ||
				lpad(r_pedidos_clientes.cantidad_pedidos, 10)
			);	
			dbms_output.put_line(rpad('-',40,'-'));
	END LOOP;
	CLOSE c_pedidos_clientes;
	dbms_output.put_line(rpad('#',5,'#'));
	
END;
````
 10 Código, nombre y número total de pedidos de los clientes que han realizado más de un pedido

```sql
SELECT 
	c.codigo, 
	c.nombre || ' ' || c.apellidos AS "Nombre Completo",
	count(p.NUM) AS "Nº Pedidos"
FROM
	clientes c
INNER JOIN
	pedidos p
	ON p.cliente = c.codigo
GROUP BY 
	C.codigo,
	c.nombre,
	c.apellidos
HAVING
	count(p.num) > 1
```

```
DECLARE

	TYPE t_clientes_pedidos IS record(
		l_cod clientes.codigo%TYPE,
		l_nombre varchar2(64),
		l_num_pedidos number
	);

	r_clientes_pedidos t_clientes_pedidos;
	
	CURSOR c_clientes_pedidos IS
		SELECT 
			c.codigo, 
			c.nombre || ' ' || c.apellidos,
			count(p.NUM)
		FROM
			clientes c
		INNER JOIN
			pedidos p
			ON p.cliente = c.codigo
		GROUP BY 
			C.codigo,
			c.nombre,
			c.apellidos
		HAVING
			count(p.num) > 1
		;
	
BEGIN
	dbms_output.put_line(rpad('#',5,'#'));
	dbms_output.put_line(rpad('-',40,'-'));
	dbms_output.put_line(
			rpad('Cod', 5) ||
			rpad('Nombre y Apellidos', 25) ||
			lpad('Nº Pedidos', 10) 
		);
	dbms_output.put_line(rpad('-',40,'-'));
	OPEN c_clientes_pedidos;
	LOOP
		FETCH c_clientes_pedidos INTO r_clientes_pedidos;
		EXIT WHEN c_clientes_pedidos%notfound;
			dbms_output.put_line(
				rpad(r_clientes_pedidos.l_cod,5) ||
				rpad(r_clientes_pedidos.l_nombre, 25) ||
				lpad(r_clientes_pedidos.l_num_pedidos, 10) 
			);		
			dbms_output.put_line(rpad('-',40,'-'));
	END LOOP;
	CLOSE c_clientes_pedidos;
	dbms_output.put_line(rpad('#',5,'#'));
END;
```

 11 Para cada pedido mostrar su número, código del cliente y nº total de líneas que tiene

```sql

```

 12 Código de cliente, nombre de producto y cantidad total que ha pedido cada cliente de cada producto

```sql

```

 13 Para cada cliente mostrar su código, nombre , numero e importe total de cada uno de sus pedidos

```sql

```

 14 Para cada cliente menor de edad mostrar su código y nombre, el importe total más alto, el más 
bajo de los pedidos que ha realizado

```sql

```

 15 Mostrar el código del producto, el nº de veces que ha sido pedido y la cantidad total de unidades 
que se han pedido (los que no hayan sido pedidos también deben ser mostrados con estos valores a 
0) (combinación externa)

```sql

```

 16 Datos del producto del que más unidades se han pedido

```sql

```

 17 Datos del producto más caro del pedido 1

```sql

```

 18 Datos del producto más caro de cada pedido (con una consulta correlacionada)

```sql

```
 
 19 Código de cada cliente y cantidad total que se ha gastado en 2016

```sql

```
 
 20 Cantidad total gastada y código de cliente de los que menos han gastado en 2016

```sql

```

 21 Para cada cliente mostrar su código y la suma total del importe de sus pedidos y gastos de envÍo

```sql

```

 22 Número de pedido , importe total y cliente de los pedidos que no tienen gastos de envío (debe aparecer un 0 en la columna de gastos de envío y pon una etiqueta a ese campo)

```sql

```

 23 Datos del pedido más caro y del más barato

```sql

```
 
 24 Sentencia que muestre los productos con este formato 

![24](./images/24.PNG "Formato 24")

```sql

```

 25 Escribe los datos de los pedidos y su clientes con el siguiente formato:

![25](./images/24.PNG "Formato 25")

```sql

```

 26 (Solo con subconsultas, sin combinar tablas) Datos de los clientes que han pedido el producto de nombre ‘PANTALON’

```sql

```
 27 (Sin subconsultas) Datos de los clientes que han pedido el producto de nombre ‘PANTALON’

```sql

```
 28 Para cada cliente, mostrar los datos del pedido cuyo importe sea superior al importe l medio de sus pedidos

```sql

```
 29 Lista de todos los pedidos con mostrando también los días previstos de espera para el envío

```sql

```
 30 Pedidos con el mínimo nº de días previsto de espera

```sql

```

