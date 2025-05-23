/*Tipo RED_SOCIAL_T*/

CREATE OR REPLACE TYPE red_social_t AS OBJECT(
  nombre VARCHAR2(100),
  fundador VARCHAR2(100),
  pais_creacion VARCHAR2(100),
  cantidad_usuarios_millones NUMBER,
  ano_fundacion NUMBER,
  cotizacion_bolsa_millones NUMBER,

  CONSTRUCTOR FUNCTION red_social_t(nombre VARCHAR2, usuarios NUMBER, ano NUMBER, cotizacion NUMBER) RETURN SELF AS RESULT,
  MEMBER FUNCTION karma RETURN NUMBER,
  MEMBER FUNCTION info_fundador RETURN VARCHAR2,
  MAP MEMBER FUNCTION ordenar RETURN NUMBER
);

/

CREATE OR REPLACE TYPE BODY red_social_t AS
    CONSTRUCTOR FUNCTION red_social_t(nombre VARCHAR2, usuarios NUMBER, ano NUMBER, cotizacion NUMBER) RETURN SELF AS RESULT IS
    BEGIN
        SELF.nombre := nombre;
        SELF.fundador := NULL;
        SELF.pais := NULL;
        SELF.cantidad_usuarios_millones := usuarios;
        SELF.ano_fundacion := ano;
        SELF.cotizacion := cotizacion;
        RETURN;
    END;

    MEMBER FUNCTION karma RETURN NUMBER IS
    BEGIN
        RETURN (EXTRACT(YEAR FROM SYSDATE) - ano_fundacion) * (cantidad_usuarios_millones + cotizacion);
    END;

    MEMBER FUNCTION info_fundador RETURN VARCHAR2 IS
    BEGIN
        RETURN NVL(fundador, 'Dato Desconocido'); --En caso de que no el valor sea NULL
    END;

    MAP MEMBER FUNCTION ordenar RETURN NUMBER IS
    BEGIN
        RETURN cantidad_usuarios_millones;
    END;
END;
/

--Prueba
DECLARE
  red red_social_t := red_social_t('Instagram', 1100, 2007, 1900);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Karma: ' || red.karma);
  DBMS_OUTPUT.PUT_LINE('Fundador: ' || red.info_fundador);
END;
/