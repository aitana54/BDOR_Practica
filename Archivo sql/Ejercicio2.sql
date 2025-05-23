CREATE OR REPLACE TYPE Direccion_T AS OBJECT (
    calle VARCHAR2(100),
    numero NUMBER,
    poblacion VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE Promotor_T AS OBJECT (
    nombre VARCHAR2(100),
    telefono VARCHAR2(20),
    web VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE Concierto_T AS OBJECT (
    id_concierto NUMBER,
    nombre_concierto VARCHAR2(100),
    artista VARCHAR2(100),
    direccion Direccion_T,
    fecha_hora TIMESTAMP,
    promotor Promotor_T,

    MEMBER PROCEDURE mostrar_info,
    MEMBER FUNCTION dias_para_concierto RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY Concierto_T AS 
    MEMBER PROCEDURE mostrar_info IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Concierto: ' || nombre_concierto || ', Artista: ' || artista);
        DBMS_OUTPUT.PUT_LINE('Direccion: ' || direccion.calle || ', ' || direccion.numero || ', ' || direccion.poblacion);
        DBMS_OUTPUT.PUT_LINE('Fecha y hora: ' || TO_CHAR(fecha_hora, 'DD-MM-YYYY HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('Promotor: ' || promotor.nombre || ', Tel: ' || promotor.telefono || ', Web: ' || promotor.web);
    END;

    MEMBER FUNCTION dias_para_concierto RETURN NUMBER IS
    BEGIN
        RETURN TRUNC(fecha_hora - SYSTIMESTAMP);
    END;
END;
/

-- Prueba
DECLARE
    d Direccion_T := Direccion_T('Calle Falsa', 123, 'Madrid');
    p Promotor_T := Promotor_T('LiveNation', '600123123', 'www.livenation.es');
    c Concierto_T := Concierto_T(1, 'Rock Fest', 'Queen', d, TO_TIMESTAMP('2025-07-20 20:00', 'YYYY-MM-DD HH24:MI'), p);
BEGIN
    c.mostrar_info;
    DBMS_OUTPUT.PUT_LINE('Días restantes: ' || c.dias_para_concierto);
END;