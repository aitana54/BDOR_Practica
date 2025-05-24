CREATE OR REPLACE TYPE Alumno_t AS OBJECT (
    id NUMBER,
    nombre VARCHAR2(100),
    delegado REF Alumno_t,
    telefono VARCHAR2(20),
    nota_media NUMBER
);
/