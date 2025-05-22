/*Tipo RED_SOCIAL_T*/

CREATE OR REPLACE TYPE red_social_t AS OBJECT(
  nombre VARCHAR2(100),
  fundador VARCHAR2(100),
  pais_creacion VARCHAR2(100),
  cantidad_usuarios_millones NUMBER,
  ano_fundacion NUMBER,
  cotizacion_bolsa_millones NUMBER,
);