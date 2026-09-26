-- Procedimiento Alamcenado Canal 
-- INSERT 
DELIMITER //
CREATE PROCEDURE sp_Select_Canal() 
BEGIN
select ca_id_canal , can_nombre, ca_tipo 
from canal;
END //
DELIMITER ;

-- INSERT 
DELIMITER //
CREATE PROCEDURE sp_Insert_Canal(IN p_can_nombre VARCHAR(80), IN p_tipo VARCHAR(15))
BEGIN
     insert into canal(can_nombre, can_tipo)
     values (p_can_nombre, p_tipo);
END //
DELIMITER ;

-- UPDATE 

DELIMITER //
CREATE PROCEDURE sp_Update_Canal(IN p_can_id_canal INT,IN p_can_nombre VARCHAR(80), IN p_can_tipo ENUM('Red Social', 'Buscador', 'Email')
)
BEGIN
    UPDATE canal 
    SET can_nombre = p_can_nombre, can_tipo = p_can_tipo
    WHERE can_id_canal = p_can_id_canal;
END //
DELIMITER ;

-- DELETE

DELIMITER //
CREATE PROCEDURE sp_Delete_Canal(IN p_can_id_canal INT)
BEGIN
    DELETE FROM canal 
    WHERE can_id_canal = p_can_id_canal;
END //
DELIMITER ;

-- contar cantidad de Canales 
DELIMITER //
CREATE PROCEDURE sp_count_canal(OUT p_quantity INT)
BEGIN
    SELECT COUNT(can_id_canal) INTO p_quantity 
    FROM canal;
END //
DELIMITER ;

-- 2. Declarar la variable y ejecutar el procedimiento
CALL sp_count_canal(@quantity);

-- 3. Obtener el valor almacenado en la variable
SELECT @quantity;
select @cantidad;

-- uniones de tabla canal  y campaña 
SELECT * 
FROM canal 
INNER JOIN campania 
ON canal.can_id_canal = campania.canal_can_id_canal;
-- poniendole un alias 
SELECT cam.cam_nombre, cam.cam_presupuesto, cam.cam_fecha_inicio, cam.cam_fecha_final, canal.can_nombre
FROM canal 
INNER JOIN campania AS cam 
ON canal.can_id_canal = cam.canal_can_id_canal;

-- REPLACE 
SELECT REPLACE(can_tipo, 'Red Social', 'Redes Sociales') AS resultado 
FROM canal 
LIMIT 1;

-- Ejemplo con la función REPEAT
SELECT can_id_canal,
       can_nombre,
       can_tipo,
       REPEAT(can_nombre, 2) AS nombre_repetido
FROM canal;

-- Ejemplo con la función LENGTH
SELECT can_id_canal,
       can_nombre,
       can_tipo,
       LENGTH(can_nombre) AS longitud_nombre_bytes
FROM canal;


-- Procedimiento Alamcenado Cliente 
DELIMITER //
CREATE PROCEDURE sp_Select_Cliente() 
BEGIN
select cli_id_cliente , cli_nombre, cli_apellido, cli_correo, cli_telefono, cli_ciudad, cli_fecha_registro
from Cliente;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_insert_Cliente(IN p_cli_nombre VARCHAR(100),IN p_cli_apellido VARCHAR( 100), IN p_cli_correo VARCHAR(100), IN p_cli_telefono VARCHAR(25), IN p_cli_ciudad VARCHAR(45), IN p_cli_fecha_registro DATE)
BEGIN
insert into canal(cli_nombre, cli_apellido, cli_correo, cli_telefono, cli_ciudad, cli_fecha_registro)
     values (p_cli_nombre, p_cli_apellido, p_cli_correo, p_cli_telefono,p_cli_ciudad,p_cli_fecha_registro );
END //
DELIMITER ;

-- UPDATE 

DELIMITER //
CREATE PROCEDURE sp_Update_Cliente(IN p_cli_id_cliente INT,IN p_cli_nombre VARCHAR(100),IN p_cli_apellido VARCHAR(100),IN p_cli_correo VARCHAR(100),IN p_cli_telefono VARCHAR(25),IN p_cli_ciudad VARCHAR(45),IN p_cli_fecha_registro DATE)
BEGIN
    UPDATE cliente 
    SET cli_nombre = p_cli_nombre, cli_apellido = p_cli_apellido, cli_correo = p_cli_correo, cli_telefono = p_cli_telefono, cli_ciudad = p_cli_ciudad, cli_fecha_registro = p_cli_fecha_registro
    WHERE cli_id_cliente = p_cli_id_cliente;
END //
DELIMITER ;

-- DELETE 

DELIMITER //
CREATE PROCEDURE sp_Delete_Cliente(IN p_cli_id_cliente INT)
BEGIN
    DELETE FROM cliente 
    WHERE cli_id_cliente = p_cli_id_cliente;
END //
DELIMITER ;

-- REPLACE 

SELECT REPLACE(cli_correo, '@', '[arroba]') AS resultado 
FROM cliente 
LIMIT 1;

-- RIGHT Ordena a los clientes tomando en cuenta solo los últimos 4 caracteres (dígitos) de su teléfono
SELECT  cli_id_cliente, cli_nombre, cli_telefono 
FROM cliente 
ORDER BY RIGHT(cli_telefono, 4);

-- Ejemplo con la función LOWER
SELECT cli_id_cliente,
       cli_nombre,
       cli_apellido,
       cli_correo,
       LOWER(cli_correo) AS correo_en_minusculas
FROM cliente;

-- Ejemplo con la función LEFT
SELECT cli_id_cliente,
       cli_nombre,
       LEFT(cli_nombre, 3) AS iniciales_nombre
FROM cliente;

-- Ejemplo con la función LCASE
SELECT 
    cli_id_cliente,
    cli_nombre,
    cli_correo,
    LCASE(cli_correo) AS correo_minusculas
FROM
    cliente;


-- Procedimiento Alamcenado Campaña

-- SELECT

DELIMITER //
CREATE PROCEDURE sp_Select_Campania() 
BEGIN
select cam_id_campania, cam_nombre, cam_presupuesto, cam_fecha_inicio, cam_fecha_final, canal_can_id_canal 
from  campania;
END //
DELIMITER ;

-- INSERT

DELIMITER //
CREATE PROCEDURE sp_Insert_Campania(IN p_cam_nombre VARCHAR(120),IN p_cam_presupuesto DECIMAL,IN p_cam_fecha_inicio DATE,IN p_cam_fecha_final DATE,IN p_canal_can_id_canal INT)
BEGIN
    INSERT INTO campania (cam_nombre, cam_presupuesto, cam_fecha_inicio, cam_fecha_final, canal_can_id_canal)
    VALUES (p_cam_nombre, p_cam_presupuesto, p_cam_fecha_inicio, p_cam_fecha_final, p_canal_can_id_canal);
END //
DELIMITER ;

-- UPADATE 
DELIMITER //
CREATE PROCEDURE sp_Update_Campania(IN p_cam_id_campania INT,IN p_cam_nombre VARCHAR(120),IN p_cam_presupuesto DECIMAL,IN p_cam_fecha_inicio DATE,IN p_cam_fecha_final DATE,IN p_canal_can_id_canal INT
)
BEGIN
    UPDATE campania 
    SET cam_nombre = p_cam_nombre, cam_presupuesto = p_cam_presupuesto, cam_fecha_inicio = p_cam_fecha_inicio, cam_fecha_final = p_cam_fecha_final, canal_can_id_canal = p_canal_can_id_canal
    WHERE cam_id_campania = p_cam_id_campania;
END //
DELIMITER ;

-- DELETE 
DELIMITER //
CREATE PROCEDURE sp_Delete_Campania(IN p_cam_id_campania INT)
BEGIN
    DELETE FROM campania 
    WHERE cam_id_campania = p_cam_id_campania;
END //
DELIMITER ;


-- UPEER combierte una cadena de texto minuscula a myuscula 

SELECT UPPER(cam_nombre) as resultado
FROM campania
LIMIT 1;

-- Ordena las campañas estandarizando el nombre a mayúsculas
SELECT cam_id_campania, cam_nombre 
FROM campania 
ORDER BY UPPER(cam_nombre);

-- Ejemplo con la función FORMAT
SELECT cam_id_campania,
       cam_nombre,
       cam_presupuesto,
       FORMAT(cam_presupuesto, 2) AS presupuesto_formateado
FROM campania;

-- Ejemplo con la función FIELD
SELECT cam_id_campania,
       cam_nombre,
       FIELD(cam_nombre, 'Black Friday', 'Navidad', 'Verano') AS posicion_prioridad
FROM campania;

-- Procedimiento Alamcenado Interaccion
-- SELECT
DELIMITER //
CREATE PROCEDURE sp_Select_interaccion() 
BEGIN
select int_id_interaccion, int_tipo, int_fecha, campania_cam_id_campania, cliente_cli_id_cliente
from  interaccion;
END //
DELIMITER ;

-- INSERT
DELIMITER //
CREATE PROCEDURE sp_Insert_Interaccion(IN p_int_tipo ENUM('clic', 'visita', 'comentario', 'descarga'),IN p_int_fecha DATE,IN p_campania_cam_id_campania INT,IN p_cliente_cli_id_cliente INT)
BEGIN
    INSERT INTO interaccion (int_tipo, int_fecha, campania_cam_id_campania, cliente_cli_id_cliente)
    VALUES (p_int_tipo, p_int_fecha, p_campania_cam_id_campania, p_cliente_cli_id_cliente);
END //
DELIMITER ;

-- UPDATE 
DELIMITER //
CREATE PROCEDURE sp_Update_Interaccion(IN p_int_id_interaccion INT,IN p_int_tipo ENUM('clic', 'visita', 'comentario', 'descarga'),IN p_int_fecha DATE,IN p_campania_cam_id_campania INT,IN p_cliente_cli_id_cliente INT)
BEGIN
    UPDATE interaccion 
    SET int_tipo = p_int_tipo, int_fecha = p_int_fecha, campania_cam_id_campania = p_campania_cam_id_campania, cliente_cli_id_cliente = p_cliente_cli_id_cliente
    WHERE int_id_interaccion = p_int_id_interaccion;
END //
DELIMITER ;

-- DELETE 
DELIMITER //
CREATE PROCEDURE sp_Delete_Interaccion(IN p_int_id_interaccion INT)
BEGIN
    DELETE FROM interaccion 
    WHERE int_id_interaccion = p_int_id_interaccion;
END //
DELIMITER ;

-- REVERSE Invierte el orden de los caracteres de una cadena de texto el último pasa a ser el primero.

SELECT REVERSE(int_tipo) AS resultado 
FROM interaccion 
LIMIT 1;

-- SPACE: Genera y devuelve una cadena de texto compuesta por un número determinado de espacios en blanco.

SELECT int_id_interaccion, int_tipo 
FROM interaccion 
ORDER BY CONCAT('Tipo: ', SPACE(4), int_tipo);

-- SUBSTRING: Extrae una porción (subcadena) de un texto indicando la posición inicial y cuántos caracteres se desean extraer.
-- Aplicado a la tabla 'interaccion' (Ordena las interacciones según las primeras 3 letras de su tipo)
SELECT int_id_interaccion, int_tipo 
FROM interaccion 
ORDER BY SUBSTRING(int_tipo, 1, 3);

-- Procedimiento Alamcenados Conversiones 

-- SELECT

DELIMITER //
CREATE PROCEDURE sp_Select_conversion() 
BEGIN
select con_id_conversion, con_tipo, con_valor, con_fecha, cliente_cli_id_cliente
from  conversion;
END //
DELIMITER ;

-- INSERT

DELIMITER //
CREATE PROCEDURE sp_Insert_Conversion(IN p_con_tipo ENUM('compra', 'registro', 'suscripcion'),IN p_con_valor DECIMAL,IN p_con_fecha DATE,IN p_cliente_cli_id_cliente INT)
BEGIN
    INSERT INTO conversion (con_tipo, con_valor, con_fecha, cliente_cli_id_cliente)
    VALUES (p_con_tipo, p_con_valor, p_con_fecha, p_cliente_cli_id_cliente);
END //
DELIMITER ;

-- UPDATE 
DELIMITER //
CREATE PROCEDURE sp_Update_Conversion(IN p_con_id_conversion INT,IN p_con_tipo ENUM('compra', 'registro', 'suscripcion'),IN p_con_valor DECIMAL,IN p_con_fecha DATE,IN p_cliente_cli_id_cliente INT)
BEGIN
    UPDATE conversion 
    SET con_tipo = p_con_tipo, con_valor = p_con_valor, con_fecha = p_con_fecha, cliente_cli_id_cliente = p_cliente_cli_id_cliente
    WHERE con_id_conversion = p_con_id_conversion;
END //
DELIMITER ;

-- DELETE 
DELIMITER //
CREATE PROCEDURE sp_Delete_Conversion(IN p_con_id_conversion INT)
BEGIN
    DELETE FROM conversion 
    WHERE con_id_conversion = p_con_id_conversion;
END //
DELIMITER ;
-- SUBSTR: Extrae una porción (subcadena) de un texto indicando la posición inicial 
-- ordena los canales según las primeras 3 letras de su nombre

SELECT con_id_conversion, con_tipo 
FROM conversion 
ORDER BY SUBSTR(con_tipo, 1, 3);