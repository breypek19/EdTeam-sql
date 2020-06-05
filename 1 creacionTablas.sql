
--Creacion de Bd
create database edteam
Go

use edteam
Go


--Creacion de tablas
create table pais(
idpais int identity(1,1) not null,
nombre varchar(20) not null,
constraint pk_pais primary key(idpais)
);



create table clientes(
identificacion varchar(15) not null,
nombre varchar(30) not null,
apellidos varchar(30) not null,
fecha_nacim date not null,
idpais int not null,
constraint pk_cliente primary key(identificacion),
constraint fk_cliente foreign key(idpais) references pais(idpais)
);

--creamos esta tabla para establacer las presentaciones de los productos
create table presentacionProductos (
idp int identity(1,1) not null,
nombre varchar(20) not null,
constraint pk_presentacion primary key(idp)
);

create table marca(
id_marca int identity(1,1) not null,
nombre varchar(30) not null,
constraint pk_marca primary key(id_marca)
)

-- A esta tabla he añadido un campo stock, el cual se va a modificar con los movimientos de entrada y salida.
-- Cuando creamos el producto en esta tabla no se sabe con certeza cuantas instancias o ejemplares hay de él, por eso 
--lo inicializamos en 0. Posteriormente cuando se hagan entradas, se ira modificando este valor
create table productos(
id_producto int identity(1,1) not null,
nombre varchar(30) not null,
valor int not null,
porcentajeImp int not null,
stock int not null DEFAULT 0,
idp int not null,
id_marca int not null,
constraint pk_productos primary key(id_producto),
constraint fk_presenproductos foreign key(idp) references presentacionProductos(idp),
constraint fk_marcap foreign key(id_marca) references marca(id_marca)
);


/* En este problema opté por no poner el valor total de la venta en esta tabla, ya que es un valor que se puede calcular
   con la cantidad de productos y el precio. Sin embargo, aveces debido a la cantidad de datos y rendimiento, es mejor tener el total aqui. 
   */
create table ventas(
id_venta int identity(1,1) not null,
identi_cliente varchar(15) not null,
fecha date not null,
constraint pk_ventas primary key(id_venta),
constraint fk_clientes foreign key(identi_cliente) references clientes(identificacion) 
);


/*
En la tabla detalleventas agregamos una redundancia en el caso del precio y el impuesto del producto, ya que es posible que estos valores 
 se modifiquen en la tabla productos a los largo del tiempo; Sino tuviesemos estos valores en esta tabla,
 cuando se modiquen en productos, se modificaran para todas las ventas.  
 Es por ello que se usan estos campos para tener los valores actuales.
 El porcentaje de impuesto es importante si queremos mostrarle los detalles  de la compra al cliente, 
 cuanto paga sin y con los impuestos.
 En esta tabla van a estar almacenadas todas las salidas o ventas de productos                                                                                                                                           */

create table detalle_ventas(
id_v int not null,
id_producto int not null,
precio int not null,
porcentajeImp int not null,
cantidad int not null,
constraint pk_ventayproductos primary key(id_v, id_producto),
constraint fk_venta foreign key(id_v) references ventas(id_venta),
constraint fk_producto foreign key(id_producto) references productos(id_producto)
);

-- omitiremos el campo de proveedores u origen de la entrada de los productos. 
-- Como una entrada o ingreso puede tener muchos productos, creamos dos tablas que nos permitan almacenar estos datos.
create table Entrada_Inventario(
id int identity(1,1) not null,
fecha date not null,
constraint pk_entrada primary key(id) 
);

/* En esta tabla se almacenaran las entradas de productos provenientes de proveedores o por produccion.
se ha decidido asi, ya que en ella quedara el registro de las entradas que se hagan, y en la tabla de detalleventas quedaran las salidas
para asi poder controlar el stock
                                                                      */
																  
create table Detalle_Entrada(
id_entrada int  not null,
id_producto int not null,
cantidad int not null,
constraint pk_inventario primary key(id_entrada,id_producto),
constraint fk_entrada foreign key(id_entrada) references Entrada_Inventario(id),
constraint fk_producto_entrada foreign key(id_producto) references productos (id_producto)
);

Go


------------Opcionalmente se crearon triggers para controlar el stock----------
--Para este ejercicio se usaran dos disparadores para ir controlando los movimientos de entrada y salida 

--1. trigger que se hace en la tabla Detalle_Entrada que permite actualizar el inventario o stock de productos

CREATE TRIGGER entrada 
on Detalle_Entrada
For insert  As
 -- Si en el insert solo hay un solo registro, osea, un solo producto con su cantidad, actualizo el stock de 
  -- ese producto en especifico
BEGIN                         
IF @@ROWCOUNT = 1            
   UPDATE productos
   SET stock = stock + cantidad  
   FROM inserted  
   WHERE productos.id_producto = inserted.id_producto
 

   /* Si  hay muchos productos con sus cantidades para insertar al mismo tiempo, hay que actualizar cada stock 
  de cada producto                                                                           */
ELSE  
 
      UPDATE productos                  
   SET stock = stock +                   
      (SELECT cantidad  
      FROM inserted  
      WHERE productos.id_producto  
       = inserted.id_producto)  
   WHERE productos.id_producto IN  
      (SELECT id_producto FROM inserted)
End

Go



--2. trigger de salida en la tabla detallaventas que me va actualizar el inventario o stock de productos cuando 
--   se realicen ventas
---  Se ha omitido que antes de actualizar el stock se tendria que validar si aún quedan ejemplares para la venta
CREATE TRIGGER salida
on detalle_ventas
For insert  As
 -- Si en el insert de detalleventa solo hay un solo registro, osea, un solo producto con su cantidad, actualizo el stock de 
  -- ese producto en especifico                        
IF @@ROWCOUNT = 1            
   UPDATE productos
   SET stock = stock - cantidad  
   FROM inserted  
   WHERE productos.id_producto = inserted.id_producto
 
   /* Si  hay muchos productos con sus cantidades para insertar al mismo tiempo, hay que actualizar cada stock 
  de cada producto. Aqui la subconsulta se va a ejecutar para cada registro, para que me retorne la cantidad a restar                                                                           */
ELSE  
      UPDATE productos                  
   SET stock = stock -                  
      (SELECT cantidad  
      FROM inserted  
      WHERE productos.id_producto  
       = inserted.id_producto)  
   WHERE productos.id_producto IN  
      (SELECT id_producto FROM inserted)  

