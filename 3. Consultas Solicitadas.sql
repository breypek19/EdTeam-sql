
use edteam
Go

--  1. Total facturacion del cliente con identificacion=106794844838
-- Muestra los datos del cliente escogido junto con su factura total

select concat(c.apellidos, ',' , c.nombre) as 'Nombre Completo', sum(d.precio*d.cantidad) as 
'Facturacion Total del Cliente'  from clientes c 
inner join ventas v on c.identificacion=v.identi_cliente
inner join detalle_ventas d on v.id_venta=d.id_v where c.identificacion='1067948438'
group by  concat(c.apellidos, ',' , c.nombre)





--2. Total facturacion del producto con id=5
   --Se muestra el nombre del producto escogido y su facturacion total.

select concat(m.nombre, ' ', p.nombre) as 'Nombre del Producto', sum(dv.precio * dv.cantidad) as 'facturacion del Producto' 
 from productos p  join marca m on p.id_marca = m.id_marca
inner join detalle_ventas dv on p.id_producto = dv.id_producto where p.id_producto=5
 group by concat(m.nombre, ' ', p.nombre)


--3.facturacion rango de fechas
--Se muestra la facturacion total entre la fecha inicial y fecha de Cierre 

select min(fecha) as 'Fecha inicio', max(fecha) as 'Fecha Cierre',  sum(precio*cantidad) as 'facturacion Total' 
from ventas v inner join detalle_ventas d on v.id_venta = d.id_v
where fecha between '2020-01-03' and '2020-02-10'



--4. Clientes unicos que tienen alguna compra

-- relaciono tabla  clientes y tabla ventas para obtener los que han realizado alguna compra
-- uso group by para devolver  datos unicos. Uso la identificacion tambien porque quizas hayan clientes que tengan
-- el mismo nombre y apellido, pero con la identificacion compruebo que sean unicos

select concat(c.apellidos, ',' , c.nombre) as 'Nombre' ,  identificacion from clientes c 
 inner join ventas v on c.identificacion=v.identi_cliente
 group by concat(c.apellidos, ',' , c.nombre), identificacion 




