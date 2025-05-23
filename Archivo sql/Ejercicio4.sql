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
END;