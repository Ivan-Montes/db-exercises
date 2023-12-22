# DAM_BD_UT04_Ejercicios

La empresa El Desván, que se dedica a la rama textil ha decidido informatizar su gestión de pedidos. Para ello BK programación desarrollará para ellos la base de datos. El gerente le ha explicado cómo funciona la gestión de pedidos y Juan, que será quien se encargue de crear el modelo, las tablas y las consultas, ha recogido la siguiente información:

- A cada cliente se le entrega un resguardo con los datos de cada pedido que hace. De cada cliente registraremos su código de cliente, nombre, apellidos, edad.
- Los datos de un pedido son el número, fecha, gastos de envío si los hay, el importe total y fecha prevista de entrega
- Cada pedido consta de varias líneas de producto y cada línea se identifica por un número de línea (1, 2,…) del correspondiente pedido. Una línea contiene la información de un producto (código, nombre, cantidad, importe)


Con todos estos datos se ha llegado al siguiente modelo entidad-relación (a falta de completar con 
el resto de atributos de las entidades):

![DAM_BD_UT04_MER](./DAM_BD_UT04_MER.JPG "Database MER")


### ACLARACIONES

En la tabla PEDIDOS el atributo TOTAL es el IMPORTE_TOTAL del pedido pero sin GASTOS DE ENVIO

Tabla Lineas: 
El campo IMPORTE ya tiene calculado la cantidad del producto x precio del producto La columna NUM es el numero de la linea de ese producto en la factura

---

## Consultas

1.Número e importe total de todos los pedidos realizados en los últimos 60 días.

```sql

```

2.Número e importe de los pedidos cuyo importe esté entre 100 y 200 €

```

```

3.Código y nombre de los productos ordenados ascendentemente por precio y nombre

```

```

4.Clientes cuyo segundo apellido sea Perez

```

```

5.Número total de productos que vende la empresa (en la columna debe aparecer “Nº de productos”)

```

```

6.Número total de productos que no han sido pedidos

```

```

7.De cada pedido, mostrar su número, importe total y datos del cliente

```

```

8.Código, nombre del cliente y número total de pedidos que ha hecho cada cliente, ordenado de más a menos pedidos

```

```

9.Código, nombre del cliente y número total de pedidos que ha realizado cada cliente durante 2016

```

```

10.Código, nombre y número total de pedidos de los clientes que han realizado más de un pedido

```

```

11.Para cada pedido mostrar su número, código del cliente y nº total de líneas que tiene

```

```

12.Código de cliente, nombre de producto y cantidad total que ha pedido cada cliente de cada producto

```

```

13.Para cada cliente mostrar su código, nombre , numero e importe total de cada uno de sus pedidos

```

```

14.Para cada cliente menor de edad mostrar su código y nombre, el importe total más alto, el más 
bajo de los pedidos que ha realizado

```

```

15.Mostrar el código del producto, el nº de veces que ha sido pedido y la cantidad total de unidades 
que se han pedido (los que no hayan sido pedidos también deben ser mostrados con estos valores a 
0) (combinación externa)

```

```

16.Datos del producto del que más unidades se han pedido

```

```

17.Datos del producto más caro del pedido 1

```

```

18.Datos del producto más caro de cada pedido (con una consulta correlacionada)

```

```
 
19.Código de cada cliente y cantidad total que se ha gastado en 2016

```

```
 
20.Cantidad total gastada y código de cliente de los que menos han gastado en 2016

```

```

21.Para cada cliente mostrar su código y la suma total del importe de sus pedidos y gastos de envÍo

```

```

22.Número de pedido , importe total y cliente de los pedidos que no tienen gastos de envío (debe aparecer un 0 en la columna de gastos de envío y pon una etiqueta a ese campo)

```

```

23.Datos del pedido más caro y del más barato

```

```
 
24.Sentencia que muestre los productos con este formato

```

```

25.Escribe los datos de los pedidos y su clientes con el siguiente formato:

```

```

26.(Solo con subconsultas, sin combinar tablas) Datos de los clientes que han pedido el producto de nombre ‘PANTALON’

```

```
27.(Sin subconsultas) Datos de los clientes que han pedido el producto de nombre ‘PANTALON’

```

```
28.Para cada cliente, mostrar los datos del pedido cuyo importe sea superior al importe l medio de sus pedidos

```

```
29.Lista de todos los pedidos con mostrando también los días previstos de espera para el envío

```

```
30.Pedidos con el mínimo nº de días previsto de espera

```

```

