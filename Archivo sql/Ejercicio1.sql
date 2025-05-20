/*Creación de tipo concierto*/

CREATE OR REPLACE TYPE casa_concierto_t AS OBJECT(
  id NUMBER,
  nombre_concierto VARCHAR2(100),
  nombre_cantante VARCHAR2(100),
  direccion_calle VARCHAR2(500),
  direccion_numero NUMBER,
  direccion_poblacion VARCHAR2(100),
  fecha_hora DATETIME
);



