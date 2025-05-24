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
CREATE OR REPLACE TYPE BODY Producto_T AS
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

CREATE OR REPLACE TYPE Producto_Fresco_T UNDER Producto_T (
    tipo_producto VARCHAR2(50),
    fecha_caducidad DATE,

    OVERRIDING MEMBER FUNCTION info_producto RETURN VARCHAR2,
    MEMBER FUNCTION esta_caducado RETURN VARCHAR2
);
/