

CREATE TABLE CLIENTES (	
CODIGO NUMBER(4,0)  PRIMARY KEY,	
NOMBRE VARCHAR2(30) NOT NULL,	
APELLIDOS VARCHAR2(30) NOT NULL, 	
EDAD	NUMBER(2,0) NOT NULL	
);

CREATE TABLE PEDIDOS (
NUM	NUMBER(5,0) PRIMARY KEY,	
FECHA	DATE NOT NULL,
GASTOS_ENVIO	NUMBER(5,2),	
FECHA_PREVISTA DATE NOT NULL,
TOTAL NUMBER(10,2) ,
CLIENTE NUMBER(4,0),
CONSTRAINT CLIENTES_FK FOREIGN KEY (CLIENTE) REFERENCES CLIENTES (CODIGO)
);


CREATE TABLE PRODUCTOS (
CODIGO  NUMBER(5,0) PRIMARY KEY,
NOMBRE  VARCHAR2(30) NOT NULL,
PRECIO   NUMBER(7,2) NOT NULL
);

CREATE TABLE  LINEAS    (	
NUM NUMBER(2,0), 
NUM_PEDIDO NUMBER(5,0), 
PRODUCTO NUMBER(5,0) NOT NULL , 
CANTIDAD NUMBER(8,0) NOT NULL , 
IMPORTE NUMBER(6,2), 
 CONSTRAINT DETALLE_PK PRIMARY KEY (NUM, NUM_PEDIDO) , 
 CONSTRAINT PEDIDO_FK FOREIGN KEY (NUM_PEDIDO)
  REFERENCES  PEDIDOS (NUM) , 
 CONSTRAINT PRODUCTO_FK FOREIGN KEY (PRODUCTO)
  REFERENCES  PRODUCTOS (CODIGO) 
   );









