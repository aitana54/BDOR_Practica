CREATE OR REPLACE TYPE Alumno_t AS OBJECT (
    id NUMBER,
    nombre VARCHAR2(100),
    delegado REF Alumno_t,
    telefono VARCHAR2(20),
    nota_media NUMBER
);
/

CREATE TABLE alumno OF Alumno_t;

DECLARE
    a1 Alumno_t;
    a2 Alumno_t;
    a3 Alumno_t;
BEGIN
    --INSERT 3 alumnos
    INSERT INTO alumno VALUES (Alumno_t(1, 'Aitana', NULL, '600111111', 8.5));
    INSERT INTO alumno VALUES (Alumno_t(2,'Ana', NULL, '600111112', 7.0));
    INSERT INTO alumno VALUES (Alumno_t(3,'Marcos', NULL, '600111113', 9.5));

    --Borrar el teléfono del segundo alumno
    UPDATE alumno 
    SET telefono = NULL 
    WHERE id = 2;

    -- Modificar el teléfono del tercer alumno.
    UPDATE alumno
    SET telefono = '600111115'
    WHERE id = 3;

    -- Modificar el delegado del 3r alumno. Ahora su delegado es el segundo alumno. 
    UPDATE alumno a
    SET delegado = (SELECT REF(b) 
                    FROM alumno b 
                    WHERE b.id = 2);
    WHERE a.id = 3;
END;