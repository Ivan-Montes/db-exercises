﻿

INSERT INTO CLIENTES VALUES ('0001', 'Luis', 'Garcia Perez', 30);
INSERT INTO CLIENTES VALUES ('0002', 'Maria', 'Lopez Garrido', 50);
INSERT INTO CLIENTES VALUES ('0003', 'Javier', 'Gamez Valiente', 30);
INSERT INTO CLIENTES VALUES ('0004', 'Luis Mª', 'Rico Martin', 17);
INSERT INTO CLIENTES VALUES ('0005', 'Ana Belen', 'Dimas Marco', 15);
INSERT INTO CLIENTES VALUES ('0006', 'Jose Luis', 'Garcia Sanchez', 50);
INSERT INTO CLIENTES VALUES ('0007', 'Mª Pilar', 'Perez Bermejo', 45);

INSERT INTO PEDIDOS VALUES (1, to_date('10/10/2015','dd/mm/yyyy'), NULL,to_date('10/11/2015','dd/mm/yyyy'), 310, '0001');
INSERT INTO PEDIDOS VALUES (2, to_date('10/02/2016','dd/mm/yyyy'),    5,to_date('10/03/2016','dd/mm/yyyy'), 185, '0001');
INSERT INTO PEDIDOS VALUES (3, to_date('20/02/2016','dd/mm/yyyy'),    3,to_date('20/04/2016','dd/mm/yyyy'), 180, '0001');
INSERT INTO PEDIDOS VALUES (4, to_date('25/03/2016','dd/mm/yyyy'), NULL,to_date('20/04/2016','dd/mm/yyyy'), 100, '0002');
INSERT INTO PEDIDOS VALUES (5, to_date('25/03/2016','dd/mm/yyyy'), NULL,to_date('20/05/2016','dd/mm/yyyy'), 135, '0003');
INSERT INTO PEDIDOS VALUES (6, to_date('15/04/2016','dd/mm/yyyy'), NULL,to_date('20/05/2016','dd/mm/yyyy'), 45 , '0004');
INSERT INTO PEDIDOS VALUES (7, to_date('15/04/2016','dd/mm/yyyy'), NULL,to_date('20/05/2016','dd/mm/yyyy'), 45 , '0005');
INSERT INTO PEDIDOS VALUES (8, to_date('15/05/2016','dd/mm/yyyy'),   10,to_date('20/06/2016','dd/mm/yyyy'), 45 , '0006');
INSERT INTO PEDIDOS VALUES (9, to_date('15/07/2016','dd/mm/yyyy'),   10,to_date('20/09/2016','dd/mm/yyyy'), 85 , '0007');
INSERT INTO PEDIDOS VALUES (10,to_date('15/01/2017','dd/mm/yyyy'),   10,to_date('15/02/2017','dd/mm/yyyy'), 90 , '0007');

INSERT INTO PRODUCTOS VALUES (10001, 'PANTALÓN', 50);
INSERT INTO PRODUCTOS VALUES (10002, 'PANTALÓN PITILLO', 60);
INSERT INTO PRODUCTOS VALUES (10003, 'PANTALÓN CAMPANA', 55);
INSERT INTO PRODUCTOS VALUES (20001, 'CAMISA M/L', 65);
INSERT INTO PRODUCTOS VALUES (20002, 'CAMISA M/C', 45);
INSERT INTO PRODUCTOS VALUES (30001, 'VESTIDO C', 80);
INSERT INTO PRODUCTOS VALUES (30002, 'VESTIDO L', 90);
INSERT INTO PRODUCTOS VALUES (40001, 'FALDA LARGA', 50);
INSERT INTO PRODUCTOS VALUES (40002, 'FALDA CORTA', 45);
INSERT INTO PRODUCTOS VALUES (40003, 'FALDA MINI', 40);

INSERT INTO LINEAS VALUES (1,1, 10001, 2, 100);
INSERT INTO LINEAS VALUES (2,1, 30001, 1, 80);
INSERT INTO LINEAS VALUES (3,1, 20001, 2, 130);
INSERT INTO LINEAS VALUES (1,2, 20001, 1, 65);
INSERT INTO LINEAS VALUES (2,2, 40003, 3, 120);
INSERT INTO LINEAS VALUES (1,3, 30002, 2, 180);
INSERT INTO LINEAS VALUES (1,4, 10001, 2, 100);
INSERT INTO LINEAS VALUES (1,5, 20002, 2, 90);
INSERT INTO LINEAS VALUES (2,5, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,6, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,7, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,8, 40002, 1, 45);
INSERT INTO LINEAS VALUES (1,9, 40003, 1, 40);
INSERT INTO LINEAS VALUES (2,9, 20002, 1, 45);
INSERT INTO LINEAS VALUES (1,10,20002, 2, 90);





