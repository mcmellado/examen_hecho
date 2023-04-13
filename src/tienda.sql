CREATE EXTENSION unaccent;

DROP TABLE IF EXISTS articulos CASCADE;

CREATE TABLE articulos (
    id          bigserial     PRIMARY KEY,
    codigo      varchar(13)   NOT NULL UNIQUE,
    descripcion varchar(255)  NOT NULL,
    precio      numeric(7, 2) NOT NULL,
    stock       int           NOT NULL,
    valoracion  int   CHECK (valoracion >= 1 AND valoracion <= 5)   
);

DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
    id       bigserial    PRIMARY KEY,
    usuario  varchar(255) NOT NULL UNIQUE,
    password varchar(255) NOT NULL,
    validado bool         NOT NULL
);

DROP TABLE IF EXISTS facturas CASCADE;

CREATE TABLE facturas (
    id         bigserial  PRIMARY KEY,
    created_at timestamp  NOT NULL DEFAULT localtimestamp(0),
    usuario_id bigint NOT NULL REFERENCES usuarios (id)
);

DROP TABLE IF EXISTS articulos_facturas CASCADE;

CREATE TABLE articulos_facturas (
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    factura_id  bigint NOT NULL REFERENCES facturas (id),
    cantidad    int    NOT NULL,
    PRIMARY KEY (articulo_id, factura_id)
);

DROP TABLE IF EXISTS etiquetas CASCADE;

CREATE TABLE etiquetas (
    id       bigserial    PRIMARY KEY,
    etiqueta  varchar(255)
);

DROP TABLE IF EXISTS valoraciones CASCADE;

CREATE TABLE valoraciones (
    id       bigserial    PRIMARY KEY,
    valoracion  int   CHECK (valoracion >= 1 AND valoracion <= 5),
    usuario_id bigint NOT NULL REFERENCES usuarios (id),
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    FOREIGN KEY (articulo_id) REFERENCES articulos(id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

DROP TABLE IF EXISTS articulos_etiquetas CASCADE;

CREATE TABLE articulos_etiquetas (
    articulo_id bigint NOT NULL REFERENCES articulos (id),
    etiqueta_id bigint NOT NULL REFERENCES etiquetas (id),
    PRIMARY KEY (articulo_id, etiqueta_id)
);


-- Carga inicial de datos de prueba:

INSERT INTO articulos (codigo, descripcion, precio, stock)
    VALUES ('18273892389', 'Yogur piña', 200.50, 4),
           ('83745828273', 'Tigretón', 50.10, 2),
           ('51736128495', 'Disco duro SSD 500 GB', 150.30, 0),
           ('83746828273', 'Tigretón', 50.10, 3),
           ('51786128435', 'Disco duro SSD 500 GB', 150.30, 5),
           ('83745228673', 'Tigretón', 50.10, 8),
           ('51786198495', 'Disco duro SSD 500 GB', 150.30, 1);

INSERT INTO usuarios (usuario, password, validado)
    VALUES ('admin', crypt('admin', gen_salt('bf', 10)), true),
           ('pepe', crypt('pepe', gen_salt('bf', 10)), false);

INSERT INTO etiquetas (etiqueta)
    VALUES ('Informática'),
            ('comestibles'),
            ('yogurt'),
            ('frutas');

INSERT INTO articulos_etiquetas(articulo_id, etiqueta_id)
    VALUES (1, 2),
           (1, 3),
           (2, 2),
           (3, 1),
           (4, 2),
           (5, 1),
           (6, 2),
           (7, 1);