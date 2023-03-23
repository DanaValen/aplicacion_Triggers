create database supermercado1;

CREATE TABLE supermercado1.tipoProducto(
idtipoproducto int (18) not null,
nombreTipoProducto varchar (50) not null,
PRIMARY KEY (idTipoProducto));

insert into tipoProducto(idTipoProducto,nombreTipoProducto)
values (1,'aseoPersonal'),(2,'granos'),(3,'despensa');

CREATE TABLE supermercado1.inventario(
idProducto int (18) not null,
cantidad int(18)  null default null,
PRIMARY KEY (idProducto)); 

insert into inventario(idProducto,cantidad)
values (15,50),(20,50),(3,50);

CREATE TABLE supermercado1.producto(
idProducto int (18) not null,
idTipoProducto int(18)  null default null,
nombreProducto varchar (50) not null,
valorVenta int (18) not null,
PRIMARY KEY (idProducto));

ALTER TABLE `supermercado1`.`producto` 
ADD CONSTRAINT `idtipoproducto`
  FOREIGN KEY (`idTipoProducto`)
  REFERENCES `supermercado1`.`tipoproducto` (`idTipoProducto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

insert into producto(idProducto,idtipoproducto,nombreProducto,valorVenta)
values (15,2,'lentejas',2000),(20,1,'cepillo de dientes',1500),(3,3,'azucar',3000);


CREATE TABLE supermercado1.factura(
numerofactura int not null auto_increment,
idProducto int (18) not null,
Cantidad int(18)  null default null,
fechaVenta datetime,
PRIMARY KEY (numerofactura));

ALTER TABLE `supermercado1`.`factura` 
ADD CONSTRAINT `idproducto`
  FOREIGN KEY (`idProducto`)
  REFERENCES `supermercado1`.`producto` (`idProducto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

insert into factura(numerofactura,idproducto,Cantidad,fechaVenta) values (1,20,3,now());
insert into factura(numerofactura,idproducto,Cantidad,fechaVenta) values (2,3,6,now());
insert into factura(numerofactura,idproducto,Cantidad,fechaVenta) values (3,15,5,now());

delimiter //
CREATE TRIGGER actualizar_inventario AFTER INSERT ON factura
FOR EACH ROW
BEGIN
   UPDATE inventario SET cantidad = cantidad - NEW.cantidad WHERE idProducto = NEW.idproducto;
END;

select * from inventario