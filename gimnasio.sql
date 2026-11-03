-- Ejercicio B1
CREATE TABLE planes (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    precio_mensual NUMERIC(6,2) NOT NULL CHECK (precio_mensual >= 0)
);

CREATE TABLE socios (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    fecha_alta DATE NOT NULL,
    plan_id INTEGER NOT NULL REFERENCES planes(id)
);

CREATE TABLE tarjetas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    activa BOOLEAN NOT NULL,
    socio_id INTEGER UNIQUE NOT NULL REFERENCES socios(id)
);

CREATE TABLE monitores (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dni VARCHAR(9) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE clases (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    actividad VARCHAR(100) NOT NULL,
    sala VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    plazas INTEGER NOT NULL CHECK (plazas > 0),
    monitor_id INTEGER NOT NULL REFERENCES monitores(id)
);

CREATE TABLE reservas (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    socio_id INTEGER NOT NULL REFERENCES socios(id),
    clase_id INTEGER NOT NULL REFERENCES clases(id),
    fecha_reserva DATE NOT NULL,
    UNIQUE (socio_id, clase_id)
);

CREATE TABLE especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE monitor_especialidades (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    monitor_id INTEGER NOT NULL REFERENCES monitores(id),
    especialidad_id INTEGER NOT NULL REFERENCES especialidades(id),
    UNIQUE (monitor_id, especialidad_id)
);

-- Ejercicio B2
INSERT INTO planes (nombre, precio_mensual)
VALUES
    ('Básico', 29.90),
    ('Completo', 44.90),
    ('Estudiante', 24.90),
    ('Mañanas', 19.90);

INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES
    ('11111111A', 'Ana Pérez', 'ana@gym.com', '2026-01-10', 2),
    ('22222222B', 'Luis García', 'luis@gym.com', '2026-02-03', 1),
    ('33333333C', 'Marta López', 'marta@gym.com', '2026-03-15', 3),
    ('44444444D', 'Hugo Sanz', 'hugo@gym.com', '2026-03-20', 2),
    ('55555555E', 'Lucía Ruiz', 'lucia@gym.com', '2026-05-02', 3),
    ('66666666F', 'Pablo Martín', 'pablo@gym.com', '2026-06-11', 1),
    ('77777777G', 'Sara Gil', 'sara@gym.com', '2026-09-01', 2),
    ('88888888H', 'Diego Vidal', 'diego@gym.com', '2026-10-01', 1);

-- Diego (8) todavía no tiene tarjeta
INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES
    ('TJ-0001', TRUE, 1),
    ('TJ-0002', TRUE, 2),
    ('TJ-0003', TRUE, 3),
    ('TJ-0004', FALSE, 4),
    ('TJ-0005', TRUE, 5),
    ('TJ-0006', TRUE, 6),
    ('TJ-0007', TRUE, 7);

INSERT INTO monitores (dni, nombre, email)
VALUES
    ('90000001J', 'Carla Navarro', 'carla@gym.com'),
    ('90000002K', 'Javier Ortega', 'javier@gym.com'),
    ('90000003L', 'Elena Romero', 'elena@gym.com'),
    ('90000004M', 'Rubén Castro', 'ruben@gym.com');

-- Rubén (4) es nuevo y todavía no da ninguna clase
INSERT INTO clases (actividad, sala, fecha_hora, plazas, monitor_id)
VALUES
    ('Spinning', 'Sala 1', '2026-11-02 09:00', 12, 1),
    ('Yoga', 'Sala 2', '2026-11-02 18:00', 10, 2),
    ('Pilates', 'Sala 2', '2026-11-03 10:00', 8, 3),
    ('Spinning', 'Sala 1', '2026-11-03 19:00', 12, 1),
    ('Zumba', 'Sala 3', '2026-11-04 18:30', 20, 3),
    ('Yoga', 'Sala 2', '2026-11-05 09:30', 10, 2),
    ('Crossfit', 'Sala 3', '2026-11-05 20:00', 3, 1);

-- La clase 6 (Yoga del jueves) no tiene reservas
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES
    (1, 1, '2026-10-28'),
    (1, 3, '2026-10-28'),
    (1, 7, '2026-10-29'),
    (2, 1, '2026-10-29'),
    (2, 2, '2026-10-29'),
    (3, 2, '2026-10-30'),
    (3, 5, '2026-10-30'),
    (4, 1, '2026-10-30'),
    (4, 7, '2026-10-31'),
    (5, 3, '2026-10-31'),
    (5, 5, '2026-10-31'),
    (6, 4, '2026-11-01'),
    (7, 5, '2026-11-01'),
    (7, 7, '2026-11-01');

INSERT INTO especialidades (nombre)
VALUES
    ('Ciclo indoor'),
    ('Yoga'),
    ('Pilates'),
    ('Baile'),
    ('Fuerza');

INSERT INTO monitor_especialidades (monitor_id, especialidad_id)
VALUES
    (1, 1),
    (1, 5),
    (2, 2),
    (2, 3),
    (3, 3),
    (3, 4),
    (4, 5);

-- Ejercicio B3
-- B3.1 Un socio con un plan que no existe
INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'nora@gym.com', '2026-10-27', 99);

-- B3.2 Un socio con el email de Ana
INSERT INTO socios (dni, nombre, email, fecha_alta, plan_id)
VALUES ('99999999Z', 'Nora Prueba', 'ana@gym.com', '2026-10-27', 1);

-- B3.3 Una segunda tarjeta para Ana
INSERT INTO tarjetas (codigo, activa, socio_id)
VALUES ('TJ-0099', TRUE, 1);

-- B3.4 Ana reserva otra vez el Spinning del lunes
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES (1, 1, '2026-10-30');

-- B3.5 Una reserva para una clase que no existe
INSERT INTO reservas (socio_id, clase_id, fecha_reserva)
VALUES (2, 50, '2026-10-30');

-- B3.6 Borrar el plan Básico
DELETE FROM planes WHERE nombre = 'Básico';

-- B3.7 Borrar el plan Mañanas
DELETE FROM planes WHERE nombre = 'Mañanas';

INSERT INTO planes (nombre, precio_mensual) VALUES ('Mañanas', 19.90);


-- Ejercicio B4
--1
SELECT s.nombre, p.nombre as plan, p.precio_mensual
FROM socios as s
INNER JOIN planes AS p 
    ON s.plan_id = p.id
ORDER BY s.nombre ASC;

--2
SELECT c.actividad, c.fecha_hora, c.sala, m.nombre AS monitor
FROM clases AS c
INNER JOIN monitores AS m
    ON c.monitor_id = m.id
ORDER BY c.fecha_hora ASC;

--3
SELECT s.nombre AS socio, t.codigo AS tarjeta
FROM socios AS s
LEFT JOIN tarjetas AS t
    ON s.id = t.socio_id;

--4
SELECT s.nombre AS socio, t.codigo AS tarjeta
FROM socios AS s
LEFT JOIN tarjetas AS t
    ON s.id = t.socio_id
WHERE t.id IS NULL;

--5
SELECT p.nombre AS plan, COUNT(s.id) AS numero_socios
FROM planes AS p
LEFT JOIN socios AS s
    ON p.id = s.plan_id
GROUP BY p.id;

--6
SELECT s.nombre AS socio, c.actividad AS clase, c.fecha_hora AS horario_clase, r.fecha_reserva
FROM reservas AS r
LEFT JOIN socios AS s
    ON r.socio_id = s.id
LEFT JOIN clases AS c
    ON r.clase_id = c.id;

--7
SELECT s.nombre AS socios_clase1
FROM socios AS s
INNER JOIN reservas AS r
    ON s.id = r.socio_id
WHERE r.clase_id = 1;

--8
SELECT c.actividad, c.fecha_hora, c.plazas, COUNT(r.id) AS numero_reservas
FROM clases AS c
LEFT JOIN reservas AS r
    ON c.id = r.clase_id
GROUP BY c.id;

--9
SELECT m.nombre AS monitor, COUNT(c.monitor_id) AS numero_clases
FROM monitores AS m
LEFT JOIN clases AS c
    ON m.id = c.monitor_id
GROUP BY m.id, m.nombre
HAVING COUNT(c.monitor_id) = 0;

--10
SELECT m.nombre AS monitor, e.nombre AS especialidad
FROM monitores AS m
INNER JOIN monitor_especialidades AS me
    ON m.id = me.monitor_id
INNER JOIN especialidades AS e
    ON me.especialidad_id = e.id;


-- Ejercicio B5
--1
SELECT * FROM socios WHERE email = 'luis@gym.com';
UPDATE socios
SET plan_id = (SELECT id FROM planes WHERE nombre = 'Completo')
WHERE email = 'luis@gym.com';

--2
SELECT * FROM socios WHERE email = 'hugo@gym.com';
SELECT * FROM tarjetas WHERE socio_id = (SELECT id FROM socios WHERE email = 'hugo@gym.com');
UPDATE tarjetas
SET activa = TRUE
WHERE socio_id = (SELECT id FROM socios WHERE email = 'hugo@gym.com');

--3
INSERT INTO tarjetas(codigo, activa, socio_id)
VALUES ('TJ-0008', TRUE, (SELECT id FROM socios WHERE email = 'diego@gym.com'));

--4
INSERT INTO reservas(socio_id, clase_id, fecha_reserva)
VALUES ((SELECT id FROM socios WHERE email = 'diego@gym.com'), 6, '2026-11-02');

--5
SELECT * FROM reservas WHERE socio_id = (SELECT id FROM socios WHERE email = 'luis@gym.com') AND clase_id = 2;
DELETE FROM reservas WHERE socio_id = (SELECT id FROM socios WHERE email = 'luis@gym.com') AND clase_id = 2;

--6
--He tenido que borrar primero los registros de las tablas con claves foráneas, ya que dependen de la tabla socios. 
--En este caso, las tablas que referencian a socios son las de tarjetas y reservas.
DELETE FROM tarjetas WHERE socio_id = (SELECT id FROM socios WHERE email = 'pablo@gym.com');
DELETE FROM reservas WHERE socio_id = (SELECT id FROM socios WHERE email = 'pablo@gym.com');
DELETE FROM socios WHERE email = 'pablo@gym.com';