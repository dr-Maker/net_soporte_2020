
-- create database net2020_soporte;

use net2020_soporte;

-- ******************************
drop table tbl_usuario;
drop table tbl_perfil;

drop table seguimiento;
drop table asignado;
drop table soporte;
drop table solicitud;
drop table tiposolicitud;

drop table cliente;
drop table operador;
drop table sucursal;

drop table persona;

drop table tipoplan;
drop table estado;

drop table tbl_comuna;
drop table tbl_provincia;
drop table tbl_region;

-- ******************************

create table tbl_region(
idregion int not null,
desc_region varchar(100) not null,
primary key(idregion));

create table tbl_provincia(
idprovincia int not null,
desc_provincia varchar(100) not null,
idregion int not null,
primary key(idprovincia),
foreign key(idregion) references tbl_region(idregion));

create table tbl_comuna(
idcomuna int not null,
desc_comuna varchar(100) not null,
idregion int not null,
idprovincia int not null,
primary key(idcomuna),
foreign key(idprovincia) references tbl_provincia(idprovincia),
foreign key(idregion) references tbl_region(idregion));

-- ******************************

create table estado(
idestado int not null,
desc_estado varchar(50),
primary key(idestado)
);

create table tipoplan(
idplan int not null,
desc_plan varchar(50) not null,
costo int not null,
primary key(idplan)
);

create table tiposolicitud(
idtiposol int not null,
desc_tiposol varchar(50) not null,
numdias int not null,
primary key(idtiposol)
);

create table sucursal(
idsucursal int not null,
idregion int not null,
idcomuna int not null,
desc_sucursal varchar(50) not null,
primary key(idsucursal),
foreign key(idregion) references tbl_region(idregion),
foreign key(idcomuna) references tbl_comuna(idcomuna)
);

create table persona(
idpersona bigint identity(1021, 1), 
rut varchar(10) not null,
dv varchar(1) not null,
ap_paterno varchar(50) not null,
ap_materno varchar(50) not null,
nombres varchar(50) not null,
email varchar(50) not null,
telefono int not null,
dir_calle varchar(100) not null,
dir_numero int not null,
idcomuna int not null,
primary key(idpersona),
unique(rut),
unique(email),
foreign key(idcomuna) references tbl_comuna(idcomuna)
);

create table cliente(
idcliente bigint identity(2222, 1), 
idpersona bigint not null,
idplan int not null,
fechaini date not null,
primary key(idcliente),
foreign key(idpersona) references persona(idpersona),
foreign key(idplan) references tipoplan(idplan)
);

create table solicitud(
idsolicitud bigint identity(5341, 1),
idcliente bigint not null,
idtiposol int,
fecha date not null,
desc_solicitud varchar(255) not null,
idestado int not null,
fecha_tope date,
primary key(idsolicitud),
foreign key(idcliente) references cliente(idcliente),
foreign key(idtiposol) references tiposolicitud(idtiposol)
);

create table operador(
idoperador bigint identity(3333, 1), 
idpersona bigint not null,
idsucursal int not null,
primary key(idoperador),
foreign key(idpersona) references persona(idpersona),
foreign key(idsucursal) references sucursal(idsucursal)
);

create table soporte(
idsoporte bigint identity(5432,1),
idsolicitud bigint not null,
fecha datetime not null,
desc_soporte varchar(255) not null,
idestado int not null,
primary key(idsoporte),
foreign key(idsolicitud) references solicitud(idsolicitud),
foreign key(idestado) references estado(idestado)
);

create table asignado(
idasignado bigint identity(6543,1),
idsoporte bigint not null,
idoperador bigint not null,
primary key(idasignado),
foreign key(idsoporte) references soporte(idsoporte),
foreign key(idoperador) references operador(idoperador)
);

create table seguimiento(
idseguimiento bigint identity(10753,1),
idasignado bigint not null,
fecha int not null,
desc_seguimiento varchar(255),
idestado int not null,
primary key(idseguimiento),
foreign key(idasignado) references asignado(idasignado),
foreign key(idestado) references estado(idestado)
);

-- ******************************

create table tbl_perfil(
idperfil int not null,
desc_perfil varchar(50) not null,
primary key(idperfil),
);

create table tbl_usuario(
idusuario int identity(2321,1),
idpersona bigint not null,
idperfil int not null,
usuario varchar(50) not null,
clave  varchar(255) not null,
primary key(idusuario),
unique (usuario),
foreign key(idpersona) references persona(idpersona),
foreign key(idperfil) references tbl_perfil(idperfil)
);


-- ******************************
insert into tbl_region values('1', 'Tarapacá');
insert into tbl_region values('2', 'Antofagasta');
insert into tbl_region values('3', 'Atacama');
insert into tbl_region values('4', 'Coquimbo');
insert into tbl_region values('5', 'Valparaíso');
insert into tbl_region values('6', 'Libertador General Bernardo O Higgins');
insert into tbl_region values('7', 'Maule');
insert into tbl_region values('8', 'Biobío');
insert into tbl_region values('9', 'La Araucanía');
insert into tbl_region values('10', 'Los Lagos');
insert into tbl_region values('11', 'Aysén del General Carlos Ibáñez del Campo');
insert into tbl_region values('12', 'Magallanes y de la Antártica Chilena');
insert into tbl_region values('13', 'Metropolitana de Santiago');
insert into tbl_region values('14', 'Los Ríos');
insert into tbl_region values('15', 'Arica y Parinacota');
insert into tbl_region values('16', 'Ñuble');

insert into tbl_provincia values('11', 'Iquique', '1');
insert into tbl_provincia values('14', 'Tamarugal', '1');
insert into tbl_provincia values('21', 'Antofagasta', '2');
insert into tbl_provincia values('22', 'El Loa', '2');
insert into tbl_provincia values('23', 'Tocopilla', '2');
insert into tbl_provincia values('31', 'Copiapó', '3');
insert into tbl_provincia values('32', 'Chañaral', '3');
insert into tbl_provincia values('33', 'Huasco', '3');
insert into tbl_provincia values('41', 'Elqui', '4');
insert into tbl_provincia values('42', 'Choapa', '4');
insert into tbl_provincia values('43', 'Limarí', '4');
insert into tbl_provincia values('51', 'Valparaíso', '5');
insert into tbl_provincia values('52', 'Isla de Pascua', '5');
insert into tbl_provincia values('53', 'Los Andes', '5');
insert into tbl_provincia values('54', 'Petorca', '5');
insert into tbl_provincia values('55', 'Quillota', '5');
insert into tbl_provincia values('56', 'San Antonio', '5');
insert into tbl_provincia values('57', 'San Felipe de Aconcagua', '5');
insert into tbl_provincia values('58', 'Marga Marga', '5');
insert into tbl_provincia values('61', 'Cachapoal', '6');
insert into tbl_provincia values('62', 'Cardenal Caro', '6');
insert into tbl_provincia values('63', 'Colchagua', '6');
insert into tbl_provincia values('71', 'Talca', '7');
insert into tbl_provincia values('72', 'Cauquenes', '7');
insert into tbl_provincia values('73', 'Curicó', '7');
insert into tbl_provincia values('74', 'Linares', '7');
insert into tbl_provincia values('81', 'Concepción', '8');
insert into tbl_provincia values('82', 'Arauco', '8');
insert into tbl_provincia values('83', 'Biobío', '8');
insert into tbl_provincia values('91', 'Cautín', '9');
insert into tbl_provincia values('92', 'Malleco', '9');
insert into tbl_provincia values('101', 'Llanquihue', '10');
insert into tbl_provincia values('102', 'Chiloé', '10');
insert into tbl_provincia values('103', 'Osorno', '10');
insert into tbl_provincia values('104', 'Palena', '10');
insert into tbl_provincia values('111', 'Coihaique', '11');
insert into tbl_provincia values('112', 'Aisén', '11');
insert into tbl_provincia values('113', 'Capitán Prat', '11');
insert into tbl_provincia values('114', 'General Carrera', '11');
insert into tbl_provincia values('121', 'Magallanes', '12');
insert into tbl_provincia values('122', 'Antártica Chilena', '12');
insert into tbl_provincia values('123', 'Tierra del Fuego', '12');
insert into tbl_provincia values('124', 'Última Esperanza', '12');
insert into tbl_provincia values('131', 'Santiago', '13');
insert into tbl_provincia values('132', 'Cordillera', '13');
insert into tbl_provincia values('133', 'Chacabuco', '13');
insert into tbl_provincia values('134', 'Maipo', '13');
insert into tbl_provincia values('135', 'Melipilla', '13');
insert into tbl_provincia values('136', 'Talagante', '13');
insert into tbl_provincia values('141', 'Valdivia', '14');
insert into tbl_provincia values('142', 'Ranco', '14');
insert into tbl_provincia values('151', 'Arica', '15');
insert into tbl_provincia values('152', 'Parinacota', '15');
insert into tbl_provincia values('161', 'Diguillín', '16');
insert into tbl_provincia values('162', 'Itata', '16');
insert into tbl_provincia values('163', 'Punilla', '16');

insert into tbl_comuna values('1101', 'Iquique', '1', '11');
insert into tbl_comuna values('1107', 'Alto Hospicio', '1', '11');
insert into tbl_comuna values('1401', 'Pozo Almonte', '1', '14');
insert into tbl_comuna values('1402', 'Camiña', '1', '14');
insert into tbl_comuna values('1403', 'Colchane', '1', '14');
insert into tbl_comuna values('1404', 'Huara', '1', '14');
insert into tbl_comuna values('1405', 'Pica', '1', '14');
insert into tbl_comuna values('2101', 'Antofagasta', '2', '21');
insert into tbl_comuna values('2102', 'Mejillones', '2', '21');
insert into tbl_comuna values('2103', 'Sierra Gorda', '2', '21');
insert into tbl_comuna values('2104', 'Taltal', '2', '21');
insert into tbl_comuna values('2201', 'Calama', '2', '22');
insert into tbl_comuna values('2202', 'Ollagüe', '2', '22');
insert into tbl_comuna values('2203', 'San Pedro de Atacama', '2', '22');
insert into tbl_comuna values('2301', 'Tocopilla', '2', '23');
insert into tbl_comuna values('2302', 'María Elena', '2', '23');
insert into tbl_comuna values('3101', 'Copiapó', '3', '31');
insert into tbl_comuna values('3102', 'Caldera', '3', '31');
insert into tbl_comuna values('3103', 'Tierra Amarilla', '3', '31');
insert into tbl_comuna values('3201', 'Chañaral', '3', '32');
insert into tbl_comuna values('3202', 'Diego de Almagro', '3', '32');
insert into tbl_comuna values('3301', 'Vallenar', '3', '33');
insert into tbl_comuna values('3302', 'Alto del Carmen', '3', '33');
insert into tbl_comuna values('3303', 'Freirina', '3', '33');
insert into tbl_comuna values('3304', 'Huasco', '3', '33');
insert into tbl_comuna values('4101', 'La Serena', '4', '41');
insert into tbl_comuna values('4102', 'Coquimbo', '4', '41');
insert into tbl_comuna values('4103', 'Andacollo', '4', '41');
insert into tbl_comuna values('4104', 'La Higuera', '4', '41');
insert into tbl_comuna values('4105', 'Paiguano', '4', '41');
insert into tbl_comuna values('4106', 'Vicuña', '4', '41');
insert into tbl_comuna values('4201', 'Illapel', '4', '42');
insert into tbl_comuna values('4202', 'Canela', '4', '42');
insert into tbl_comuna values('4203', 'Los Vilos', '4', '42');
insert into tbl_comuna values('4204', 'Salamanca', '4', '42');
insert into tbl_comuna values('4301', 'Ovalle', '4', '43');
insert into tbl_comuna values('4302', 'Combarbalá', '4', '43');
insert into tbl_comuna values('4303', 'Monte Patria', '4', '43');
insert into tbl_comuna values('4304', 'Punitaqui', '4', '43');
insert into tbl_comuna values('4305', 'Río Hurtado', '4', '43');
insert into tbl_comuna values('5101', 'Valparaíso', '5', '51');
insert into tbl_comuna values('5102', 'Casablanca', '5', '51');
insert into tbl_comuna values('5103', 'Concón', '5', '51');
insert into tbl_comuna values('5104', 'Juan Fernández', '5', '51');
insert into tbl_comuna values('5105', 'Puchuncaví', '5', '51');
insert into tbl_comuna values('5107', 'Quintero', '5', '51');
insert into tbl_comuna values('5109', 'Viña del Mar', '5', '51');
insert into tbl_comuna values('5201', 'Isla de Pascua', '5', '52');
insert into tbl_comuna values('5301', 'Los Andes', '5', '53');
insert into tbl_comuna values('5302', 'Calle Larga', '5', '53');
insert into tbl_comuna values('5303', 'Rinconada', '5', '53');
insert into tbl_comuna values('5304', 'San Esteban', '5', '53');
insert into tbl_comuna values('5401', 'La Ligua', '5', '54');
insert into tbl_comuna values('5402', 'Cabildo', '5', '54');
insert into tbl_comuna values('5403', 'Papudo', '5', '54');
insert into tbl_comuna values('5404', 'Petorca', '5', '54');
insert into tbl_comuna values('5405', 'Zapallar', '5', '54');
insert into tbl_comuna values('5501', 'Quillota', '5', '55');
insert into tbl_comuna values('5502', 'Calera', '5', '55');
insert into tbl_comuna values('5503', 'Hijuelas', '5', '55');
insert into tbl_comuna values('5504', 'La Cruz', '5', '55');
insert into tbl_comuna values('5506', 'Nogales', '5', '55');
insert into tbl_comuna values('5601', 'San Antonio', '5', '56');
insert into tbl_comuna values('5602', 'Algarrobo', '5', '56');
insert into tbl_comuna values('5603', 'Cartagena', '5', '56');
insert into tbl_comuna values('5604', 'El Quisco', '5', '56');
insert into tbl_comuna values('5605', 'El Tabo', '5', '56');
insert into tbl_comuna values('5606', 'Santo Domingo', '5', '56');
insert into tbl_comuna values('5701', 'San Felipe', '5', '57');
insert into tbl_comuna values('5702', 'Catemu', '5', '57');
insert into tbl_comuna values('5703', 'Llaillay', '5', '57');
insert into tbl_comuna values('5704', 'Panquehue', '5', '57');
insert into tbl_comuna values('5705', 'Putaendo', '5', '57');
insert into tbl_comuna values('5706', 'Santa María', '5', '57');
insert into tbl_comuna values('5801', 'Quilpué', '5', '58');
insert into tbl_comuna values('5802', 'Limache', '5', '58');
insert into tbl_comuna values('5803', 'Olmué', '5', '58');
insert into tbl_comuna values('5804', 'Villa Alemana', '5', '58');
insert into tbl_comuna values('6101', 'Rancagua', '6', '61');
insert into tbl_comuna values('6102', 'Codegua', '6', '61');
insert into tbl_comuna values('6103', 'Coinco', '6', '61');
insert into tbl_comuna values('6104', 'Coltauco', '6', '61');
insert into tbl_comuna values('6105', 'Doñihue', '6', '61');
insert into tbl_comuna values('6106', 'Graneros', '6', '61');
insert into tbl_comuna values('6107', 'Las Cabras', '6', '61');
insert into tbl_comuna values('6108', 'Machalí', '6', '61');
insert into tbl_comuna values('6109', 'Malloa', '6', '61');
insert into tbl_comuna values('6110', 'Mostazal', '6', '61');
insert into tbl_comuna values('6111', 'Olivar', '6', '61');
insert into tbl_comuna values('6112', 'Peumo', '6', '61');
insert into tbl_comuna values('6113', 'Pichidegua', '6', '61');
insert into tbl_comuna values('6114', 'Quinta de Tilcoco', '6', '61');
insert into tbl_comuna values('6115', 'Rengo', '6', '61');
insert into tbl_comuna values('6116', 'Requínoa', '6', '61');
insert into tbl_comuna values('6117', 'San Vicente', '6', '61');
insert into tbl_comuna values('6201', 'Pichilemu', '6', '62');
insert into tbl_comuna values('6202', 'La Estrella', '6', '62');
insert into tbl_comuna values('6203', 'Litueche', '6', '62');
insert into tbl_comuna values('6204', 'Marchihue', '6', '62');
insert into tbl_comuna values('6205', 'Navidad', '6', '62');
insert into tbl_comuna values('6206', 'Paredones', '6', '62');
insert into tbl_comuna values('6301', 'San Fernando', '6', '63');
insert into tbl_comuna values('6302', 'Chépica', '6', '63');
insert into tbl_comuna values('6303', 'Chimbarongo', '6', '63');
insert into tbl_comuna values('6304', 'Lolol', '6', '63');
insert into tbl_comuna values('6305', 'Nancagua', '6', '63');
insert into tbl_comuna values('6306', 'Palmilla', '6', '63');
insert into tbl_comuna values('6307', 'Peralillo', '6', '63');
insert into tbl_comuna values('6308', 'Placilla', '6', '63');
insert into tbl_comuna values('6309', 'Pumanque', '6', '63');
insert into tbl_comuna values('6310', 'Santa Cruz', '6', '63');
insert into tbl_comuna values('7101', 'Talca', '7', '71');
insert into tbl_comuna values('7102', 'Constitución', '7', '71');
insert into tbl_comuna values('7103', 'Curepto', '7', '71');
insert into tbl_comuna values('7104', 'Empedrado', '7', '71');
insert into tbl_comuna values('7105', 'Maule', '7', '71');
insert into tbl_comuna values('7106', 'Pelarco', '7', '71');
insert into tbl_comuna values('7107', 'Pencahue', '7', '71');
insert into tbl_comuna values('7108', 'Río Claro', '7', '71');
insert into tbl_comuna values('7109', 'San Clemente', '7', '71');
insert into tbl_comuna values('7110', 'San Rafael', '7', '71');
insert into tbl_comuna values('7201', 'Cauquenes', '7', '72');
insert into tbl_comuna values('7202', 'Chanco', '7', '72');
insert into tbl_comuna values('7203', 'Pelluhue', '7', '72');
insert into tbl_comuna values('7301', 'Curicó', '7', '73');
insert into tbl_comuna values('7302', 'Hualañé', '7', '73');
insert into tbl_comuna values('7303', 'Licantén', '7', '73');
insert into tbl_comuna values('7304', 'Molina', '7', '73');
insert into tbl_comuna values('7305', 'Rauco', '7', '73');
insert into tbl_comuna values('7306', 'Romeral', '7', '73');
insert into tbl_comuna values('7307', 'Sagrada Familia', '7', '73');
insert into tbl_comuna values('7308', 'Teno', '7', '73');
insert into tbl_comuna values('7309', 'Vichuquén', '7', '73');
insert into tbl_comuna values('7401', 'Linares', '7', '74');
insert into tbl_comuna values('7402', 'Colbún', '7', '74');
insert into tbl_comuna values('7403', 'Longaví', '7', '74');
insert into tbl_comuna values('7404', 'Parral', '7', '74');
insert into tbl_comuna values('7405', 'Retiro', '7', '74');
insert into tbl_comuna values('7406', 'San Javier', '7', '74');
insert into tbl_comuna values('7407', 'Villa Alegre', '7', '74');
insert into tbl_comuna values('7408', 'Yerbas Buenas', '7', '74');
insert into tbl_comuna values('8101', 'Concepción', '8', '81');
insert into tbl_comuna values('8102', 'Coronel', '8', '81');
insert into tbl_comuna values('8103', 'Chiguayante', '8', '81');
insert into tbl_comuna values('8104', 'Florida', '8', '81');
insert into tbl_comuna values('8105', 'Hualqui', '8', '81');
insert into tbl_comuna values('8106', 'Lota', '8', '81');
insert into tbl_comuna values('8107', 'Penco', '8', '81');
insert into tbl_comuna values('8108', 'San Pedro de la Paz', '8', '81');
insert into tbl_comuna values('8109', 'Santa Juana', '8', '81');
insert into tbl_comuna values('8110', 'Talcahuano', '8', '81');
insert into tbl_comuna values('8111', 'Tomé', '8', '81');
insert into tbl_comuna values('8112', 'Hualpén', '8', '81');
insert into tbl_comuna values('8201', 'Lebu', '8', '82');
insert into tbl_comuna values('8202', 'Arauco', '8', '82');
insert into tbl_comuna values('8203', 'Cañete', '8', '82');
insert into tbl_comuna values('8204', 'Contulmo', '8', '82');
insert into tbl_comuna values('8205', 'Curanilahue', '8', '82');
insert into tbl_comuna values('8206', 'Los Alamos', '8', '82');
insert into tbl_comuna values('8207', 'Tirúa', '8', '82');
insert into tbl_comuna values('8301', 'Los Angeles', '8', '83');
insert into tbl_comuna values('8302', 'Antuco', '8', '83');
insert into tbl_comuna values('8303', 'Cabrero', '8', '83');
insert into tbl_comuna values('8304', 'Laja', '8', '83');
insert into tbl_comuna values('8305', 'Mulchén', '8', '83');
insert into tbl_comuna values('8306', 'Nacimiento', '8', '83');
insert into tbl_comuna values('8307', 'Negrete', '8', '83');
insert into tbl_comuna values('8308', 'Quilaco', '8', '83');
insert into tbl_comuna values('8309', 'Quilleco', '8', '83');
insert into tbl_comuna values('8310', 'San Rosendo', '8', '83');
insert into tbl_comuna values('8311', 'Santa Bárbara', '8', '83');
insert into tbl_comuna values('8312', 'Tucapel', '8', '83');
insert into tbl_comuna values('8313', 'Yumbel', '8', '83');
insert into tbl_comuna values('8314', 'Alto Biobío', '8', '83');
insert into tbl_comuna values('9101', 'Temuco', '9', '91');
insert into tbl_comuna values('9102', 'Carahue', '9', '91');
insert into tbl_comuna values('9103', 'Cunco', '9', '91');
insert into tbl_comuna values('9104', 'Curarrehue', '9', '91');
insert into tbl_comuna values('9105', 'Freire', '9', '91');
insert into tbl_comuna values('9106', 'Galvarino', '9', '91');
insert into tbl_comuna values('9107', 'Gorbea', '9', '91');
insert into tbl_comuna values('9108', 'Lautaro', '9', '91');
insert into tbl_comuna values('9109', 'Loncoche', '9', '91');
insert into tbl_comuna values('9110', 'Melipeuco', '9', '91');
insert into tbl_comuna values('9111', 'Nueva Imperial', '9', '91');
insert into tbl_comuna values('9112', 'Padre Las Casas', '9', '91');
insert into tbl_comuna values('9113', 'Perquenco', '9', '91');
insert into tbl_comuna values('9114', 'Pitrufquén', '9', '91');
insert into tbl_comuna values('9115', 'Pucón', '9', '91');
insert into tbl_comuna values('9116', 'Saavedra', '9', '91');
insert into tbl_comuna values('9117', 'Teodoro Schmidt', '9', '91');
insert into tbl_comuna values('9118', 'Toltén', '9', '91');
insert into tbl_comuna values('9119', 'Vilcún', '9', '91');
insert into tbl_comuna values('9120', 'Villarrica', '9', '91');
insert into tbl_comuna values('9121', 'Cholchol', '9', '91');
insert into tbl_comuna values('9201', 'Angol', '9', '92');
insert into tbl_comuna values('9202', 'Collipulli', '9', '92');
insert into tbl_comuna values('9203', 'Curacautín', '9', '92');
insert into tbl_comuna values('9204', 'Ercilla', '9', '92');
insert into tbl_comuna values('9205', 'Lonquimay', '9', '92');
insert into tbl_comuna values('9206', 'Los Sauces', '9', '92');
insert into tbl_comuna values('9207', 'Lumaco', '9', '92');
insert into tbl_comuna values('9208', 'Purén', '9', '92');
insert into tbl_comuna values('9209', 'Renaico', '9', '92');
insert into tbl_comuna values('9210', 'Traiguén', '9', '92');
insert into tbl_comuna values('9211', 'Victoria', '9', '92');
insert into tbl_comuna values('10101', 'Puerto Montt', '10', '101');
insert into tbl_comuna values('10102', 'Calbuco', '10', '101');
insert into tbl_comuna values('10103', 'Cochamó', '10', '101');
insert into tbl_comuna values('10104', 'Fresia', '10', '101');
insert into tbl_comuna values('10105', 'Frutillar', '10', '101');
insert into tbl_comuna values('10106', 'Los Muermos', '10', '101');
insert into tbl_comuna values('10107', 'Llanquihue', '10', '101');
insert into tbl_comuna values('10108', 'Maullín', '10', '101');
insert into tbl_comuna values('10109', 'Puerto Varas', '10', '101');
insert into tbl_comuna values('10201', 'Castro', '10', '102');
insert into tbl_comuna values('10202', 'Ancud', '10', '102');
insert into tbl_comuna values('10203', 'Chonchi', '10', '102');
insert into tbl_comuna values('10204', 'Curaco de Vélez', '10', '102');
insert into tbl_comuna values('10205', 'Dalcahue', '10', '102');
insert into tbl_comuna values('10206', 'Puqueldón', '10', '102');
insert into tbl_comuna values('10207', 'Queilén', '10', '102');
insert into tbl_comuna values('10208', 'Quellón', '10', '102');
insert into tbl_comuna values('10209', 'Quemchi', '10', '102');
insert into tbl_comuna values('10210', 'Quinchao', '10', '102');
insert into tbl_comuna values('10301', 'Osorno', '10', '103');
insert into tbl_comuna values('10302', 'Puerto Octay', '10', '103');
insert into tbl_comuna values('10303', 'Purranque', '10', '103');
insert into tbl_comuna values('10304', 'Puyehue', '10', '103');
insert into tbl_comuna values('10305', 'Río Negro', '10', '103');
insert into tbl_comuna values('10306', 'San Juan de la Costa', '10', '103');
insert into tbl_comuna values('10307', 'San Pablo', '10', '103');
insert into tbl_comuna values('10401', 'Chaitén', '10', '104');
insert into tbl_comuna values('10402', 'Futaleufú', '10', '104');
insert into tbl_comuna values('10403', 'Hualaihué', '10', '104');
insert into tbl_comuna values('10404', 'Palena', '10', '104');
insert into tbl_comuna values('11101', 'Coihaique', '11', '111');
insert into tbl_comuna values('11102', 'Lago Verde', '11', '111');
insert into tbl_comuna values('11201', 'Aisén', '11', '112');
insert into tbl_comuna values('11202', 'Cisnes', '11', '112');
insert into tbl_comuna values('11203', 'Guaitecas', '11', '112');
insert into tbl_comuna values('11301', 'Cochrane', '11', '113');
insert into tbl_comuna values('11302', 'O Higgins', '11', '113');
insert into tbl_comuna values('11303', 'Tortel', '11', '113');
insert into tbl_comuna values('11401', 'Chile Chico', '11', '114');
insert into tbl_comuna values('11402', 'Río Ibáñez', '11', '114');
insert into tbl_comuna values('12101', 'Punta Arenas', '12', '121');
insert into tbl_comuna values('12102', 'Laguna Blanca', '12', '121');
insert into tbl_comuna values('12103', 'Río Verde', '12', '121');
insert into tbl_comuna values('12104', 'San Gregorio', '12', '121');
insert into tbl_comuna values('12201', 'Cabo de Hornos', '12', '122');
insert into tbl_comuna values('12202', 'Antártica', '12', '122');
insert into tbl_comuna values('12301', 'Porvenir', '12', '123');
insert into tbl_comuna values('12302', 'Primavera', '12', '123');
insert into tbl_comuna values('12303', 'Timaukel', '12', '123');
insert into tbl_comuna values('12401', 'Natales', '12', '124');
insert into tbl_comuna values('12402', 'Torres del Paine', '12', '124');
insert into tbl_comuna values('13101', 'Santiago', '13', '131');
insert into tbl_comuna values('13102', 'Cerrillos', '13', '131');
insert into tbl_comuna values('13103', 'Cerro Navia', '13', '131');
insert into tbl_comuna values('13104', 'Conchalí', '13', '131');
insert into tbl_comuna values('13105', 'El Bosque', '13', '131');
insert into tbl_comuna values('13106', 'Estación Central', '13', '131');
insert into tbl_comuna values('13107', 'Huechuraba', '13', '131');
insert into tbl_comuna values('13108', 'Independencia', '13', '131');
insert into tbl_comuna values('13109', 'La Cisterna', '13', '131');
insert into tbl_comuna values('13110', 'La Florida', '13', '131');
insert into tbl_comuna values('13111', 'La Granja', '13', '131');
insert into tbl_comuna values('13112', 'La Pintana', '13', '131');
insert into tbl_comuna values('13113', 'La Reina', '13', '131');
insert into tbl_comuna values('13114', 'Las Condes', '13', '131');
insert into tbl_comuna values('13115', 'Lo Barnechea', '13', '131');
insert into tbl_comuna values('13116', 'Lo Espejo', '13', '131');
insert into tbl_comuna values('13117', 'Lo Prado', '13', '131');
insert into tbl_comuna values('13118', 'Macul', '13', '131');
insert into tbl_comuna values('13119', 'Maipú', '13', '131');
insert into tbl_comuna values('13120', 'Ñuñoa', '13', '131');
insert into tbl_comuna values('13121', 'Pedro Aguirre Cerda', '13', '131');
insert into tbl_comuna values('13122', 'Peñalolén', '13', '131');
insert into tbl_comuna values('13123', 'Providencia', '13', '131');
insert into tbl_comuna values('13124', 'Pudahuel', '13', '131');
insert into tbl_comuna values('13125', 'Quilicura', '13', '131');
insert into tbl_comuna values('13126', 'Quinta Normal', '13', '131');
insert into tbl_comuna values('13127', 'Recoleta', '13', '131');
insert into tbl_comuna values('13128', 'Renca', '13', '131');
insert into tbl_comuna values('13129', 'San Joaquín', '13', '131');
insert into tbl_comuna values('13130', 'San Miguel', '13', '131');
insert into tbl_comuna values('13131', 'San Ramón', '13', '131');
insert into tbl_comuna values('13132', 'Vitacura', '13', '131');
insert into tbl_comuna values('13201', 'Puente Alto', '13', '132');
insert into tbl_comuna values('13202', 'Pirque', '13', '132');
insert into tbl_comuna values('13203', 'San José de Maipo', '13', '132');
insert into tbl_comuna values('13301', 'Colina', '13', '133');
insert into tbl_comuna values('13302', 'Lampa', '13', '133');
insert into tbl_comuna values('13303', 'Tiltil', '13', '133');
insert into tbl_comuna values('13401', 'San Bernardo', '13', '134');
insert into tbl_comuna values('13402', 'Buin', '13', '134');
insert into tbl_comuna values('13403', 'Calera de Tango', '13', '134');
insert into tbl_comuna values('13404', 'Paine', '13', '134');
insert into tbl_comuna values('13501', 'Melipilla', '13', '135');
insert into tbl_comuna values('13502', 'Alhué', '13', '135');
insert into tbl_comuna values('13503', 'Curacaví', '13', '135');
insert into tbl_comuna values('13504', 'María Pinto', '13', '135');
insert into tbl_comuna values('13505', 'San Pedro', '13', '135');
insert into tbl_comuna values('13601', 'Talagante', '13', '136');
insert into tbl_comuna values('13602', 'El Monte', '13', '136');
insert into tbl_comuna values('13603', 'Isla de Maipo', '13', '136');
insert into tbl_comuna values('13604', 'Padre Hurtado', '13', '136');
insert into tbl_comuna values('13605', 'Peñaflor', '13', '136');
insert into tbl_comuna values('14101', 'Valdivia', '14', '141');
insert into tbl_comuna values('14102', 'Corral', '14', '141');
insert into tbl_comuna values('14103', 'Lanco', '14', '141');
insert into tbl_comuna values('14104', 'Los Lagos', '14', '141');
insert into tbl_comuna values('14105', 'Máfil', '14', '141');
insert into tbl_comuna values('14106', 'Mariquina', '14', '141');
insert into tbl_comuna values('14107', 'Paillaco', '14', '141');
insert into tbl_comuna values('14108', 'Panguipulli', '14', '141');
insert into tbl_comuna values('14201', 'La Unión', '14', '142');
insert into tbl_comuna values('14202', 'Futrono', '14', '142');
insert into tbl_comuna values('14203', 'Lago Ranco', '14', '142');
insert into tbl_comuna values('14204', 'Río Bueno', '14', '142');
insert into tbl_comuna values('15101', 'Arica', '15', '151');
insert into tbl_comuna values('15102', 'Camarones', '15', '151');
insert into tbl_comuna values('15201', 'Putre', '15', '152');
insert into tbl_comuna values('15202', 'General Lagos', '15', '152');
insert into tbl_comuna values('16101', 'Chillán', '16', '161');
insert into tbl_comuna values('16102', 'Bulnes', '16', '161');
insert into tbl_comuna values('16103', 'Chillán Viejo', '16', '161');
insert into tbl_comuna values('16104', 'El Carmen', '16', '161');
insert into tbl_comuna values('16105', 'Pemuco', '16', '161');
insert into tbl_comuna values('16106', 'Pinto', '16', '161');
insert into tbl_comuna values('16107', 'Quillón', '16', '161');
insert into tbl_comuna values('16108', 'San Ignacio', '16', '161');
insert into tbl_comuna values('16109', 'Yungay', '16', '161');
insert into tbl_comuna values('16201', 'Quirihue', '16', '162');
insert into tbl_comuna values('16202', 'Cobquecura', '16', '162');
insert into tbl_comuna values('16203', 'Coelemu', '16', '162');
insert into tbl_comuna values('16204', 'Ninhue', '16', '162');
insert into tbl_comuna values('16205', 'Portezuelo', '16', '162');
insert into tbl_comuna values('16206', 'Ranquil', '16', '162');
insert into tbl_comuna values('16207', 'Treguaco', '16', '162');
insert into tbl_comuna values('16301', 'San Carlos', '16', '163');
insert into tbl_comuna values('16302', 'Coihueco', '16', '163');
insert into tbl_comuna values('16303', 'Ñiquén', '16', '163');
insert into tbl_comuna values('16304', 'San Fabián', '16', '163');
insert into tbl_comuna values('16305', 'San Nicolás', '16', '163');
-- ******************************

insert into estado values(1, 'Creada');
insert into estado values(2, 'Pendiente');
insert into estado values(3, 'Asignado');
insert into estado values(4, 'Postergado');
insert into estado values(5, 'Rechazado');
insert into estado values(6, 'Resuelto');

insert into tipoplan values(1, 'Básico', 11990);
insert into tipoplan values(2, 'Medio', 19990);
insert into tipoplan values(3, 'Optimo', 29990);
insert into tipoplan values(4, 'Full master', 45990);

insert into tiposolicitud values(1, 'Ciontrato', 2);
insert into tiposolicitud values(2, 'Soporte', 4);
insert into tiposolicitud values(3, 'Reclamo', 10);
insert into tiposolicitud values(4, 'Renuncia', 10);

insert into tbl_perfil values(1, 'Administrador');
insert into tbl_perfil values(2, 'Supervisor');
insert into tbl_perfil values(3, 'Operador');
insert into tbl_perfil values(4, 'Delegado');
insert into tbl_perfil values(5, 'Cliente');

insert into sucursal values(1, 13, 13101, 'Santiago');
insert into sucursal values(2, 13, 13123, 'Providencia');
insert into sucursal values(3, 13, 13201, 'Puente Alto');
insert into sucursal values(4, 5, 5101, 'Valparaíso');
insert into sucursal values(5, 6, 6101, 'Rancagua');

-- personas
insert into persona values('11111111', '1', 'Lorca', 'Parra', 'Patirck', 'palorca@soporte.net', '976293482', 'Bellavista', '13001', '13123');
insert into persona values('22222222', '2', 'Jemenez', 'Lopez', 'Ximena', 'xijemenez@soporte.net', '963654814', 'Bellavista', '13002', '13123');
insert into persona values('33333333', '3', 'Reveco', 'Mena', 'Karla', 'kareveco@soporte.net', '964396074', 'Bellavista', '13003', '13123');
insert into persona values('44444444', '4', 'Barahona', 'Pavez', 'Daniel', 'dabarahona@soporte.net', '963340933', 'Bellavista', '13004', '13123');
insert into persona values('55555555', '5', 'Lillo', 'Baschman', 'Jaime', 'jalillo@soporte.net', '972263607', 'Bellavista', '13005', '13123');
insert into persona values('66666666', '6', 'Jara', 'Ad-Huajel', 'Beatriz', 'bejara@soporte.net', '965692907', 'Bellavista', '13006', '13123');
insert into persona values('77777777', '7', 'Kolsch', 'Meyer', 'Martina', 'makolsch@soporte.net', '976456066', 'Bellavista', '13007', '13123');
insert into persona values('88888888', '8', 'Aguilla', 'Rustom', 'Alejandra', 'alaguilla@soporte.net', '975444455', 'Bellavista', '13008', '13123');
insert into persona values('99999999', '9', 'Garcia', 'Baradit', 'Salvador', 'sagarcia@soporte.net', '963184360', 'Bellavista', '13009', '13123');

-- usuario
insert into tbl_usuario values(1021, 1, 'palorca', 'OABPmiw1HEg=');

select u.*, p.idperfil, p.desc_perfil
from tbl_usuario u
join tbl_perfil p on u.idperfil = p.idperfil 
where u.usuario = 'palorca' 
and u.clave = 'OABPmiw1HEg=';
