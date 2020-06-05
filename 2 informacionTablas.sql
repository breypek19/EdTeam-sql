use edteam
Go

--Ingreso datos de los paises

insert into pais values('Colombia'), ('Peru'), ('Argentina'), ('Mexico'), ('España'), ('Chile'), ('Bolivia')



--Ingreso datos de los clientes de la zapateria


         insert into clientes values 
('1067948438', 'Breyner', 'Marin Palomino', '2020-06-05', 1), 
('1066786324', 'Jose Antonio', 'Ramirez Perez', '1996-05-27', 1),
('72143788', 'Willman Rafael', 'Marin Parra', '1969-09-30', 1),
('10987634', 'Jaime', 'Navarro florez', '1980-03-20', 5),
('22528591', 'Marcel ', 'Hoyos Morelo', '1993-12-10', 2),
('10905678', 'Antonio ', 'Jimenez Rua', '1992-07-09', 2),
('10543621', 'Andrea ', 'Pretelt lopez', '1997-03-10', 4)
 

--Tipos de presentacion en los que vienen los productos
  --Usé estos tipos de zapatos para los productos de la zapateria
insert into presentacionProductos values
('cuero'), ('sintetico'), ('gamuza'), ('goma'), ('charol'), ('tejido')


insert into marca values
('Adidas'),('Reebok'), ('Puma'), ('Nike'), ('Skechers')


--Ingreso datos de los productos.
insert into productos (nombre, valor,porcentajeImp, idp, id_marca) values  
('Running Runfalcon', 160000, 19, 1, 1 ),
('Royal Jogger', 170000, 15, 1, 1),
('Tenis de Training', 155000, 19, 2, 5),
('Running Ultraboost', 385000, 19, 1,1),
('Running Ballast Mid', 180000, 15, 5, 3),
('Dynmight 2.0', 160000, 15, 6, 5),
('Tenis Downshifter', 250000, 19, 6, 4)


--ingreso de productos. Para este ejercicio uso dos entradas para ingresar los productos
--Hemos omitido atributos en relacion a los proveedores u origen, ya que para este ejercicio no seria importante
insert into Entrada_Inventario values
('2020-01-01')

insert into Entrada_Inventario values
 ('2020-02-10')


--ingreso de los detalles de los productos
insert into Detalle_Entrada (id_entrada, id_producto, cantidad) values
(1,1,50), (1,2, 30), (1,3, 15), (1,4,35)

insert into Detalle_Entrada (id_entrada, id_producto, cantidad) values
(2,1,10), (2,3,10), (2,4, 10), (2,5,25), (2,6,45), (2,7,50)


--Ingreso las ventas o cabeceras de las facturas

insert into ventas (fecha, identi_cliente) values 
('2020-01-03', '1067948438'),
('2020-01-03', '72143788'),
('2020-02-10', '1066786324'),
('2020-03-20', '22528591'),
('2020-03-20', '72143788'),
('2020-05-15', '1067948438'),
('2020-05-16', '10987634')


--Ingreso  de los detalles que conforman la facturacion para cada caso
insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(1,3,155000,19,1), (1,2,170000,15,2)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(2,2,170000,15,1), (2,1,160000,19,1), (2,5,180000,15,3)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(3,2,170000,15,1), (3,1,160000,19,1), (3,5,180000,15,3)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(4,7,250000,19,1), (4,3,155000,19,2)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(5,1,160000,19,2), (5,4,385000,19,1)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(6,6,160000,15,1)

insert into detalle_ventas (id_v, id_producto, precio, porcentajeImp, cantidad) values
(7,3,155000,19,1), (7,2,170000,15,1)

