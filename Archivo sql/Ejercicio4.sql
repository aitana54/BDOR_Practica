/*creación tipo*/

CREATE OR REPLACE TYPE Producto_t AS OBJECT(
    idProducto NUMBER,
    nombre VARCHAR2(100),
    precio_base NUMBER(10,2),
    impuesto NUMBER,

    MEMBER FUNCTION info_producto RETURN VARCHAR2,
    MEMBER FUNCTION precio_final RETURN NUMBER,
    ORDER MEMBER FUNCTION orden_producto (p Producto_t) RETURN INTEGER
) NOT FINAL;

/

--creación BODY
CREATE OR REPLACE TYPE BODY Producto_t AS
    MEMBER FUNCTION info_producto RETURN VARCHAR2 IS
     BEGIN
        RETURN 'Producto: ' || nombre || ', Precio base: ' || precio_base || ', Impuesto: ' || impuesto || '%';
    END;

    MEMBER FUNCTION precio_final RETURN NUMBER IS
    BEGIN
        RETURN precio_base * (1 + impuesto/100);
    END;

    ORDER MEMBER FUNCTION orden_producto (p Producto_t) RETURN INTEGER IS
    BEGIN
        IF precio_base < p.precio_base THEN
            RETURN -1;
        ELSIF precio_base > p.precio_base THEN
            RETURN 1;
        ELSE
            RETURN 0;
        ELSE IF;
    END;
END;

/

CREATE OR REPLACE TYPE Producto_Fresco_t UNDER Producto_t (
    tipo_producto VARCHAR2(50),
    fecha_caducidad DATE,

    OVERRIDING MEMBER FUNCTION info_producto RETURN VARCHAR2,
    MEMBER FUNCTION esta_caducado RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY Producto_Fresco_t AS
    OVERRIDING MEMBER FUNCTION info_producto RETURN VARCHAR2 IS
    BEGIN
        RETURN SELF.nombre || ' (' || tipo_producto || '), caduca el ' || TO_CHAR(fecha_caducidad, 'DD-MM-YYYY');
    END;

    MEMBER FUNCTION esta_caducado RETURN VARCHAR2 IS
    BEGIN
        IF fecha_caducidad < SYSDATE THEN
            RETURN 'Caducado';
        ELSE
            RETURN 'Aún válido';
        END IF;
    END;
END;

--Pruebas
DECLARE
    p1 Producto_t := Producto_t(1, 'Espinacas', 3.30, 21);
    pf1 Producto_Fresco_t := Producto_Fresco_t(2, 'Yogur', 1.20, 21, 'Lácteo', TO_DATE('2025-05-01', 'YYYY-MM-DD'));
BEGIN
    DBMS_OUTPUT.PUT_LINE(p1.info_producto);
    DBMS_OUTPUT.PUT_LINE('Final: ' || p1.precio_final);

    DBMS_OUTPUT.PUT_LINE(pf1.info_producto);
    DBMS_OUTPUT.PUT_LINE(pf1.esta_caducado);
END;