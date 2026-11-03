<h1>Ejercicio A1</h1>

1. Las columnas que no se pueden repetir son dni y email, ya que son 'unique', (además de id porque es una clave primaria)

2. La clave primaria es id, identifica cada fila. Por otro lado, las claves alternativas son dni y email

3. La columna que apunta a otra tabla es plan_id, ya que es una clave ajena, hará referencia a una tabla seguramente llamada planes

4. Una de las razones es que un DNI es información sensible, por lo que haría falta otro identificador para evitar filtraciones entre otros

<br>

---

<h1>Ejercicio A2</h1>

| Pareja | Un A, ¿cuántos B? | Un B, ¿cuántos A? | Relación |
|---|---|---|---|
| planes – socios | muchos | uno | N:1 |
| socios – tarjetas | uno | uno | 1:1 |
| monitores – clases | muchos | uno | N:1 |
| socios – clases | muchos | muchos | N:M |
| monitores – especialidades | muchos | muchos | N:M |
<br>
---
<h1>Ejercicio A3</h1>

monitores y clases
---

1.
    - Un monitor, ¿cuántas clases? Muchas
    - Una clase, ¿cuántos monitores? Uno
    - 1:N

2. La clave ajena iría en clases, se llamaría monitor_id

3. Si por otro lado, intentáramos poner clase_id en la tabla de monitor no sería correcto porque una celda no puede tener varios valores:

    | id | dni | nombre | email | clase_id |
    |---|---|---|---|---|
    | 3 | 12567218B | Juan Carlos | juancarlos@gmail.com | 2, 5, 7, 9 |

4. monitor_id debería ser NOT NULL porque una clase necesita un monitor, sino no sería una clase

5. La tabla que hay que crear primero es monitores, ya que monitor_id en clases es la clave ajena

<br>

---

<h1>Ejercicio A4</h1>

1. Si quitamos *UNIQUE* de socio_id, el mismo socio (el 1 por ejemplo) podría estar en varias tarjetas

    | id | codigo | activa | socio_id |
    |---|---|---|---|
    | 3 | aB3256 | true | 1 |
    | 5 | contr4sena | false | 1 |

2. Las columnas *UNIQUE* en tarjetas son codigo y socio_id:
    - **socio_id** ya se ha explicado antes, evita que un socio pueda aparecer en varias tarjetas
    - **codigo** evita que varias tarjetas tengan el mismo codigo, teniendo así cada una un código distintivo

3. Otra relación 1:1 sería **persona** y **DNI**, ya que una persona solo puede tener un DNI y un DNI solo puede ser de una persona. La clave ajena debería de estar en DNI, ya que una persona puede no tener DNI

<br>

---
<h1>Ejercicio A5</h1>

*monitores y especialidades*
---

1. 
    - Un monitor, ¿cuántas especialidades? Muchas
    - Una especialidad, ¿cuántos monitores? Muchos
    - N:M

2. **tablas:**
    - monitores
    - especialidades
    - monitor_especialidades

3. 
    **monitores:**
    - id PK
    - dni UNIQUE
    - nombre
    - email UNIQUE

    **especialidades:**
    - id PK
    - nombre UNIQUE

    **monitor_especialidades:**
    - id PK
    - monitor_id FK
    - especialidad_id FK
    - UNIQUE (monitor_id, especialidad_id)

4. Evita que se repita la misma combinación o pareja de datos, un monitor no puede tener 2 veces la misma especialidad ni una especialidad 2 veces el mismo monitor

5. La tabla reservas y monitor_especialidades tienen las claves foráneas de sus dos otras tablas respectivas. La diferencia es que la de reservas contiene un campo adicional que añade información mientras que la tabla monitor_especialidades únicamente pone en común ambas claves foráneas

<br>

---
<h1>Ejercicio A6</h1>

1. País – ciudad:
    - Un país, ¿cuántas ciudades? Muchas
    - Una ciudad, ¿cuántos paises? Uno
    - N:1
    - La clave ajena estaría en ciudades

2. Persona – pasaporte:
    - Una persona, ¿cuántos pasaportes? Muchos (aunque normalmente 1)
    - Un pasaporte, ¿cuántas personas? Uno
    - N:1
    - La clave ajena estaría en pasaportes

3. Alumno – asignatura:
    - Un alumno, ¿cuántas asignaturas? Muchas
    - Una asignatura, ¿cuántos alumnos? Muchos
    - N:M
    - La clave ajena estaría en otra tabla: notas

4. Cliente – pedido:
    - Un cliente, ¿cuántos pedidos? Muchos
    - Un pedido, ¿cuántos clientes? Uno
    - N:1
    - La clave ajena estaría en pedidos

5. Película – actor:
    - Una película, ¿cuántos actores? Muchos
    - Un actor, ¿cuántas películas? Muchas
    - N:M
    - La clave ajena estaría en otra tabla: filmografías

6. Autor – libro:
    - Un autor, ¿cuántos libros? Muchos
    - Un libro, ¿cuántos autores? Uno
    - N:1
    - La clave ajena estaría en libros
    Aunque podría ser que fuera el primer libro de ese autor o que se tratara de una colaboración escrita por dos autores

7. Furniro: usuario – pedido:
    - Un usuario, ¿cuántos pedidos? Muchos
    - Un pedido, ¿cuántos usuarios? Uno
    - N:1
    - La clave ajena estaría en pedidos

8. Furniro: pedido – producto - ¿Qué datos guardarías en la tabla intermedia?
    - Un pedido, ¿cuántos productos? Muchos
    - Un producto, ¿cuántos pedidos? Muchos
    - N:M
    - La clave ajena estaría en otra tabla: compras o pedido_producto. Ahí guardaría el pedido_id y el producto_id

<br>

---
<h1>Ejercicio B3</h1>

Todas las instrucciones menos la última darán error, cada una por una razón distinta:
---

- **B3.1 ->** La FK debe referenciar a un plan existente

        ERROR:  insert or update on table "socios" violates foreign key constraint "socios_plan_id_fkey"
        DETAIL:  Key (plan_id)=(99) is not present in table "planes".

- **B3.2 ->** El email de Ana ya existe y este es un dato UNIQUE, así que no se puede repetir

        ERROR:  duplicate key value violates unique constraint "socios_email_key"
        DETAIL:  Key (email)=(ana@gym.com) already exists.

- **B3.3 ->** Solo puede haber una tarjeta por socio

        ERROR:  duplicate key value violates unique constraint "tarjetas_socio_id_key"
        DETAIL:  Key (socio_id)=(1) already exists.

- **B3.4 ->** Un socio no puede reservar dos veces la misma clase
    
        ERROR:  duplicate key value violates unique constraint "reservas_socio_id_clase_id_key"
        DETAIL:  Key (socio_id, clase_id)=(1, 1) already exists.

- **B3.5 ->** Es necesario que el clase_id ya exista para poder referenciarlo

        ERROR:  insert or update on table "reservas" violates foreign key constraint "reservas_clase_id_fkey"
        DETAIL:  Key (clase_id)=(50) is not present in table "clases".

- **B3.6 ->** No puedes borrar un plan si algún elemento en socios hacen referencia a él

        ERROR:  update or delete on table "planes" violates foreign key constraint "socios_plan_id_fkey" on table "socios"
        DETAIL:  Key (id)=(1) is still referenced from table "socios".

- **B3.7 ->** Se podrá borrar, ya que ningún socio está utilizando el id de el plan 'Mañanas'

- **B3.8 ->** Aunque ambas instrucciones (B3.6 y B3.7) sean planes, no se puede borrar el primero porque existen referencias a su id en mínimo un socio, sin embargo el segundo no es utilizado por nadie, por lo que no hay problema

<br>

---
<h1>Ejercicio B4.11</h1>
No es un error que en la consulta 6 Ana salga tres veces, ya que se debe a que ella ha reservado tres clases distintas y en cada fila vemos los datos de una reserva, no varias

<br>

---
<h1>Ejercicio B6</h1>

- **B6.1 ->** La diferencia entre una clave primaria y una clave UNIQUE es que solo hay una clave primaria por tabla, mientras que al usar UNIQUE sí puedes ponerlo en varias columnas en la misma tabla

- **B6.2 ->** Una clave ajena sí puede repetirse porque es la que relaciona tablas, por lo que puede haber dos tablas (que compartirían clave ajena) haciendo referencia a una tercera

- **B6.3 ->** En una relación 1:N, la clave ajena va en el lado de muchos, es decir N, ya que si fuera al revés, necesitaría introducir varios valores dentro de una única celda

- **B6.4 ->** UNIQUE convierte una relación 1:N en una 1:1, haciendo que no se pueda repetir la clave ajena

- **B6.5 ->** Una relación N:M necesita una tabla intermedia porque sino necesitaría varios valores en una misma fila en cada una de las tablas

- **B6.6 ->** fecha_reserva está en reservas y no en socios ni clases porque ese valor es de esa reserva en concreto, la fecha de una reserva no tiene lugar en los datos de un socio ni en la información de una clase, cada uno de estos contiene información relevante para su tabla