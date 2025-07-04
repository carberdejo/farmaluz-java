DROP DATABASE IF EXISTS BD_FARMALUZ;
CREATE DATABASE BD_FARMALUZ;
USE BD_FARMALUZ;

CREATE TABLE tb_laboratorio(
	id_lab int auto_increment primary key,
    name_lab varchar(200) not null
);
CREATE TABLE tb_categoria(
	id_cate int auto_increment primary key,
    name_cate varchar(200) not null
);
CREATE TABLE tb_proveedor(
	id_prov int auto_increment primary key,
    name_prov varchar(200) not null,
    nom_encargado varchar(200) not null,
    ape_encargado varchar(200) not null,
    ruc VARCHAR(11) not null,
    direccion varchar(200) not null,
    telefono varchar(15) not null,
    email varchar(100),
    fec_inicio date not null
);

CREATE TABLE tb_cliente(
	id_clien int auto_increment primary key,
    nombre_clien varchar(200) not null,
	apellido_clien varchar(200) not null,
    dni_clien char(8) not null,
    telefono_clien char(9) not null
);

CREATE TABLE tb_usuario(
	id_usu int auto_increment primary key,
    nombre_usu varchar(200) not null,
	apellido_usu varchar(200) not null,
    dni_usu char(8) not null,
    telefono_usu char(9) not null,
    direccion_usu varchar(200) not null,
    nick_usu varchar(50) not null unique,
    password_usu varchar(100) not null,
    rol char (10) check(rol in('EMP','ADMIN'))
);


CREATE TABLE tb_producto(
	id_produc int auto_increment primary key,
    name_pro varchar(200) not null,
    descripcion varchar(300) not null,
    precio decimal(3.2) not null,
    stock int not null,
    fec_entrada date default(CURRENT_DATE),
    fec_ultimo date default(CURRENT_DATE),
    id_lab int references tb_laboratorio(id_lab),
    id_cate int references tb_categoria(id_cate),
    id_prov int references tb_proveedor(id_prov)
);
CREATE TABLE tb_comprobante(
	id_cdp int auto_increment primary key,
    tipo varchar(20),
    id_cli int null references tb_cliente(id_clien),
    id_ven int references tb_usuario(id_usu),
    fecha date 
);

CREATE TABLE tb_Detallecomprobante(
	id_cdp int references tb_comprobante(id_cdp),
    id_pro int references tb_producto (id_produc),
    cantidad int ,
    importe decimal(3.2),
    primary key(id_cdp,id_pro)   
);

CREATE TABLE tb_notificaciones(
	id_noti int auto_increment primary key,
    id_usu int references tb_usuario(id_usu),
    mensaje VARCHAR(255),
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    titulo VARCHAR(100),
    link_referencia VARCHAR(255),
    tipo VARCHAR(50),
    objeto_id INT
);


--  REGISTROS

INSERT INTO tb_categoria (name_cate) VALUES
('Antibióticos'),('Analgésicos'),('Antiinflamatorios'),('Antigripales'),
('Antialérgicos'),('Antifúngicos'),('Vitaminas y Suplementos'),
('Cuidado Digestivo'),('Dermatológicos'),('Sistema Nervioso Central');

INSERT INTO tb_laboratorio (name_lab) VALUES
('Genfar'),('Bayer'),('Pfizer'),
('Roche'),('Novartis'),('Sanofi'),('GSK'),
('Abbott'),('Medifarma'),('Johnson & Johnson');

INSERT INTO tb_proveedor (
    name_prov, nom_encargado, ape_encargado, ruc, direccion, telefono, email, fec_inicio
) VALUES
('Distribuidora PerúMed', 'Carlos', 'Ramírez', '20123456789', 'Av. Brasil 1234, Lima', '987654321', 'contacto@perumed.com', '2018-03-15'),
('Farmalog SAC', 'Lucía', 'Paredes', '20234567890', 'Jr. Ayacucho 456, Arequipa', '956123789', 'ventas@farmalog.pe', '2019-06-20'),
('Red Salud Suministros', 'Marco', 'Gonzales', '20345678901', 'Calle San Martín 789, Trujillo', '998765432', 'info@redsalud.com', '2020-01-10'),
('Droguería Santa Cruz', 'Patricia', 'López', '20456789012', 'Av. Venezuela 321, Cusco', '912345678', 'santacruz@drogueriasc.pe', '2017-09-25'),
('Biomedic Importaciones', 'Fernando', 'Quispe', '20567890123', 'Av. Larco 741, Lima', '934567890', 'contacto@biomedic.pe', '2021-02-14'),
('Salud Pharma S.A.C.', 'Andrea', 'Mendoza', '20678901234', 'Av. Industrial 456, Chiclayo', '987123456', 'ventas@saludpharma.pe', '2016-07-01'),
('Laboratorios del Sur', 'Jorge', 'Ríos', '20789012345', 'Calle Colón 654, Arequipa', '945612378', 'lab.sur@correo.pe', '2022-05-30'),
('Quimfarma Perú', 'Sandra', 'Delgado', '20890123456', 'Av. Grau 888, Piura', '978561234', 'info@quimfarma.com.pe', '2015-11-05'),
('Drofarma', 'Luis', 'Cruz', '20901234567', 'Jr. Puno 234, Huancayo', '962345879', 'atencion@drofarma.pe', '2018-08-12'),
('FarmaDistribuciones Andes', 'Verónica', 'Silva', '20998765432', 'Av. Primavera 567, Lima', '951234789', 'contacto@farmaandes.pe', '2019-10-28');

INSERT INTO tb_producto (
    name_pro, descripcion, precio, stock, fec_entrada, fec_ultimo, id_lab, id_cate, id_prov
) VALUES
('Amoxicilina 500mg', 'Amoxicilina, Lactosa, Estearato de magnesio, Gelatina', 12.50, 120, '2025-05-10', '2025-06-10', 1, 1, 1),
('Paracetamol 500mg', 'Paracetamol, Almidón, Povidona, Talco, Estearato de magnesio', 4.20, 300, '2025-04-20', '2025-06-01', 2, 2, 2),
('Ibuprofeno 400mg', 'Ibuprofeno, Celulosa microcristalina, Almidón pregelatinizado, Dióxido de silicio', 6.30, 180, '2025-04-25', '2025-06-05', 3, 3, 3),
('Loratadina 10mg', 'Loratadina, Lactosa, Almidón de maíz, Estearato de magnesio', 3.50, 250, '2025-03-18', '2025-06-03', 4, 5, 4),
('Omeprazol 20mg', 'Omeprazol, Manitol, Laurilsulfato de sodio, Fosfato disódico, Talco', 5.10, 140, '2025-05-01', '2025-06-04', 1, 8, 5),
('Vitamina C 1g', 'Ácido ascórbico, Bicarbonato de sodio, Sorbitol, Aroma de naranja', 2.90, 100, '2025-04-12', '2025-06-02', 5, 7, 6),
('Miconazol 2%', 'Miconazol, Alcohol cetílico, Parafina, Propilenglicol, Agua purificada', 7.80, 70, '2025-05-14', '2025-06-06', 6, 6, 7),
('Ibuprofeno jarabe', 'Ibuprofeno, Sorbitol, Aroma frutal, Agua purificada, Sacarina', 6.00, 90, '2025-03-25', '2025-06-01', 2, 3, 8),
('Clorfenamina 4mg', 'Clorfenamina, Lactosa, Almidón, Estearato de magnesio', 1.90, 300, '2025-02-10', '2025-05-28', 3, 5, 9),
('Diazepam 10mg', 'Diazepam, Celulosa, Almidón, Estearato de magnesio, Lactosa', 9.50, 60, '2025-04-30', '2025-06-09', 7, 10, 10),
('Cetirizina 10mg', 'Cetirizina diclorhidrato, Lactosa, Estearato de magnesio, Celulosa', 4.80, 150, '2025-04-15', '2025-06-11', 4, 5, 3),
('Salbutamol Inhalador', 'Salbutamol, Propelente HFA-134a, Etanol, Agua purificada', 15.00, 80, '2025-03-22', '2025-06-07', 2, 9, 4),
('Metformina 850mg', 'Metformina, Povidona, Talco, Estearato de magnesio, Hipromelosa', 6.70, 200, '2025-04-28', '2025-06-12', 6, 1, 2),
('Aspirina 100mg', 'Ácido acetilsalicílico, Almidón, Lactosa, Estearato de magnesio', 2.20, 320, '2025-05-02', '2025-06-10', 3, 2, 1),
('Ranitidina 150mg', 'Ranitidina, Celulosa, Dióxido de silicio, Estearato de magnesio', 5.40, 130, '2025-04-10', '2025-06-08', 1, 8, 5),
('Clorhexidina Gel', 'Clorhexidina, Glicerina, Agua, Carbómero, Trietanolamina', 8.30, 75, '2025-05-05', '2025-06-06', 5, 6, 6),
('Dexametasona 0.5mg', 'Dexametasona, Lactosa, Almidón de maíz, Estearato de magnesio', 3.10, 210, '2025-04-14', '2025-06-10', 7, 5, 7),
('Ambroxol Jarabe', 'Ambroxol, Sorbitol, Saborizante, Agua purificada, Conservantes', 6.20, 95, '2025-03-30', '2025-06-02', 2, 3, 8),
('Fluconazol 150mg', 'Fluconazol, Lactosa, Celulosa microcristalina, Estearato de magnesio', 10.50, 50, '2025-05-08', '2025-06-09', 6, 6, 9),
('Hierro + Ácido Fólico', 'Sulfato ferroso, Ácido fólico, Lactosa, Estearato de magnesio', 3.80, 180, '2025-04-18', '2025-06-05', 4, 7, 10);




INSERT INTO tb_usuario (nombre_usu,apellido_usu,dni_usu,telefono_usu,direccion_usu,nick_usu,password_usu,rol) VALUES
('cristian','Cotrina','9836812','96672124','los postes 972','cris','cris123','ADMIN'),
('frank','Martel','9900624','9654124','Chimu 214','frank','frank123','EMP');

INSERT INTO tb_cliente (nombre_clien, apellido_clien, dni_clien, telefono_clien) VALUES
('Carlos', 'Gonzales', '12345678', '987654321'),
('Lucía', 'Fernández', '87654321', '912345678'),
('Juan', 'Ramírez', '45678912', '998877665'),
('María', 'Lozano', '23456789', '901122334'),
('Pedro', 'Quispe', '34567891', '987112233');


-- CONSULTAS
SELECT * FROM TB_PRODUCTO WHERE ID_LAB = 1;

select * from tb_cliente;
select * from tb_comprobante;
select * from tb_Detallecomprobante;
select * from tb_notificaciones;
select * from tb_usuario;

DELIMITER $$
CREATE PROCEDURE SP_BUSCAR_PRODUCTO(IN NOMBRE VARCHAR(100))
BEGIN
	SELECT * FROM TB_PRODUCTO WHERE name_pro LIKE concat(NOMBRE,'%');
END$$
DELIMITER ;

Select cb.id_cdp,p.id_produc,c.nombre_clien,p.name_pro, m.name_cate,l.name_lab,p.precio,dc.cantidad,dc.importe 
from tb_producto p join tb_categoria m join tb_laboratorio l join 
tb_DetalleComprobante dc join tb_Comprobante cb join tb_cliente c 
where p.id_cate = m.id_cate and p.id_lab = l.id_lab and p.id_produc=dc.id_pro and dc.id_cdp = cb.id_cdp 
and cb.id_cli = c.id_clien and m.id_cate=1 order by dc.importe DESC;



