--DROP TABLE IF EXISTS "stg"."stg_partido" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_jugador" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_equipo" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_entrenador" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_estadio" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_meteo" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_suceso" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_jornada" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_alineacion" CASCADE;
--DROP TABLE IF EXISTS "stg"."aux_jugador" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_puntuacion2017" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_puntuacion2016" CASCADE;
--DROP TABLE IF EXISTS "stg"."stg_puntuacion" CASCADE;

CREATE TABLE stg.stg_jornada
(
  id_partido int8
, jornada int2
, fecha date
, hora TEXT
, equipo_local TEXT
, equipo_visitante TEXT
, resultado_local int2
, resultado_visitante int2
,ano_futbolistico int2
)
CREATE TABLE stg.stg_alineacion
(
  id_partido int8
, nombre text
, dorsal int2
, goles int2
, titular varchar(2)
, tarjeta_roja int2
, tarjeta_amarilla int2
, minutos_jugados int2
, equipo text
,ano_futbolistico int2
)
CREATE TABLE stg.aux_jugador
(
  equipo text
, ano_futbolistico int2
, dorsal int2
, nombre text
, fecha_nacimiento date
, nacionalidad text
, altura text
, pie text
, fichado_desde date
, contrato_hasta date
, valor_mercado text
, posicion text
);

CREATE TABLE stg.aux_jugador2
    ( nombre text
    , dorsal int2
    , equipo text
    , ano_futbolistico int2
    , fecha_nacimiento date
    , nacionalidad text
    , altura text
    , pie text
    , fichado_desde date
    , contrato_hasta date
    , valor_mercado text
    , posicion text
    );

CREATE TABLE stg.stg_puntuacion2017
(
  partido 			int,
  nombre                 VARCHAR(30) NOT NULL,
  puntuacion              INT NOT NULL
);

CREATE TABLE stg.stg_puntuacion2016
(
  partido 			int,
  nombre                 VARCHAR(30) NOT NULL,
  puntuacion              INT NOT NULL
);


CREATE TABLE stg.stg_puntuacion
(
  partido 			int,
  nombre                 VARCHAR(30) NOT NULL,
  puntuacion              INT NOT NULL
);

CREATE TABLE "stg"."stg_jugador" (
	"id_jugador" SERIAL,
	"nombre" text NOT NULL,
	"fecha_nacimiento" date,
	"altura" text,
	"pie" text,
	"nacionalidad" text NOT NULL,
	"posicion" text,
	CONSTRAINT "stg_jugador_id_jugador_pk" PRIMARY KEY("id_jugador")
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_jugador" OWNER TO "postgres";

CREATE TABLE "stg"."stg_partido" (	
	"id_partido" int8 NOT NULL,
	"jornada" int2 NOT NULL,
	"id_equipo_local" int4 NOT NULL,
	"id_equipo_rival" int4 NOT NULL,
	"resultado_local" int2 NOT NULL,
	"resultado_rival" int2 NOT NULL,
	"fecha" date,
	"hora" text,
	"temporada" text,
	CONSTRAINT "stg_partido_id_partido_pk" PRIMARY KEY("id_partido"),
	FOREIGN KEY (id_equipo_local) REFERENCES "stg"."stg_equipo" (id_equipo),
	FOREIGN KEY (id_equipo_rival) REFERENCES "stg"."stg_equipo" (id_equipo)
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_partido" OWNER TO "postgres";

CREATE TABLE "stg"."stg_equipo" (
	"id_equipo" SERIAL,
	"nombre" text ,
	"ano_fundacion" int2,
	CONSTRAINT "stg_equipo_id_equipo_pk" PRIMARY KEY("id_equipo")
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_equipo" OWNER TO "postgres";

CREATE TABLE "stg"."stg_lidera" (
	"id_lidera" SERIAL,
	"id_equipo" int4 NOT NULL,
	"id_entrenador" int4 NOT NULL,
	"fecha_inicio_contrato" date NOT NULL,
	"fecha_fin_contrato" date,
	CONSTRAINT "stg_lidera_id_lidera_pk" PRIMARY KEY("id_lidera"),
	FOREIGN KEY (id_equipo) REFERENCES "stg"."stg_equipo" (id_equipo),
	FOREIGN KEY (id_entrenador) REFERENCES "stg"."stg_entrenador" (id_entrenador)
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_lidera" OWNER TO "postgres";

CREATE TABLE "stg"."stg_milita" (
	"id_milita" SERIAL,
	"id_equipo" int4 NOT NULL,
	"id_jugador" int4 NOT NULL,
	"fecha_inicio_contrato" date NOT NULL,
	"fecha_fin_contrato" date,
	"valor_mercado" text,
	CONSTRAINT "stg_milita_id_lidera_pk" PRIMARY KEY("id_milita"),
	FOREIGN KEY (id_equipo) REFERENCES "stg"."stg_equipo" (id_equipo),
	FOREIGN KEY (id_jugador) REFERENCES "stg"."stg_jugador" (id_jugador)
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_milita" OWNER TO "postgres";

CREATE TABLE "stg"."stg_entrenador" (
	"id_entrenador" SERIAL,
	"nombre" text,
	"fecha_nacimiento" date , 
	"ano_debut" int2, 
	"nacionalidad" text,
	"id_equipo" int4 NOT NULL,
	"fecha_inicio_contrato" date,
	"fecha_fin_contrato" date,
	CONSTRAINT "stg_entrenador_id_entrenador_pk" PRIMARY KEY("id_entrenador"),
	FOREIGN KEY (id_equipo) REFERENCES "stg"."stg_equipo" (id_equipo)
	
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_entrenador" OWNER TO "postgres";


CREATE TABLE "stg"."stg_estadio" (
	"id_estadio" SERIAL,
	"estadio" text,
	"ciudad" text,
	"capacidad" int8,	
	"coordenada_x" text,
	"coordenada_y" text	,
	"id_equipo" int4 NOT NULL,
	CONSTRAINT "stg_estadio_id_estadio_pk" PRIMARY KEY("id_estadio"),
	FOREIGN KEY (id_equipo) REFERENCES "stg"."stg_equipo" (id_equipo)
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_estadio" OWNER TO "postgres";

CREATE TABLE "stg"."stg_meteo" (
	"id_meteo" SERIAL,
	"temperatura" text,
	"lluvias" text,
	"humedad" text,
	"velocidad_viento" text,
	"id_partido" int8 NOT NULL,
	CONSTRAINT "stg_meteo_id_meteo_pk" PRIMARY KEY("id_meteo"),
	FOREIGN KEY (id_partido) REFERENCES "stg"."stg_partido" (id_partido)
)
WITH (
	OIDS = False
);

ALTER TABLE "stg"."stg_meteo" OWNER TO "postgres";

CREATE TABLE "stg"."stg_suceso" (
	"id_suceso" SERIAL,	
	"resultado_jugador" text NOT NULL,
	"puntuacion" int2 NOT NULL,
	"titular" varchar(2),
	"tarjeta_amarilla" int2 NOT NULL,
	"tarjeta_roja" int2 NOT NULL,
	"goles" int2 NOT NULL,
	"minutos_jugados" int2 NOT NULL,
	"id_jugador" int8 NOT NULL,
	"id_partido" int8 NOT NULL,
	CONSTRAINT "stg_suceso_id_suceso_pk" PRIMARY KEY("id_suceso"),
	FOREIGN KEY (id_jugador) REFERENCES "stg"."stg_jugador" (id_jugador),
	FOREIGN KEY (id_partido) REFERENCES "stg"."stg_partido" (id_partido)
)
WITH (
	OIDS = False
);	
ALTER TABLE "stg"."stg_suceso" OWNER TO "postgres";

--DROP TABLE IF EXISTS "stg"."stg_puntuacion" CASCADE;
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Mauricio Pellegrino','1971-10-05',2012, 'Argentino');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Ernesto Valverde','1964-02-09',2002, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Diego Simeone','1970-02-28',2006, 'Argentino');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Luis Enrique','1970-05-08',2008, 'Español');	
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Gustavo Poyet','1967-11-15',2007, 'Uruguayo');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Víctor Sánchez del Amo','1976-02-23',2010, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Alexis Trujillo','1965-07-30',2017, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Eduardo Berizzo','1969-11-13',2011, 'Argentino');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Gaizka Garitano','1975-07-09',2010, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Pepe Mel','1963-07-28',1999, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('José Luis Mendilibar','1961-03-14',1994, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Quique Sánchez Flores','1965-02-05',2004, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Paco Jémez','1970-04-18',2007, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Tony Adams','1966-10-10',2010, 'Inglés');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Lluís Planagumá','1980-10-25',2011, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Lucas Alcaraz','1966-06-21',1995, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Quique Setién','1958-09-27',2001, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Asier Garitano','1969-12-06',2008, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Juande Ramos','1954-09-25',1990, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Marcelo Romero','1976-06-04',2012, 'Uruguayo');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Enrique Martín','1956-03-08',1993, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Joaquín Caparrós','1955-10-15',1981, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Petar Vasiljevic','1970-11-03',2016, 'Serbio');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Eusebio Sacristán','1964-04-13',2009, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Zinedine Zidane','1972-06-23',2009, 'Francés');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Jorge Sampaoli','1960-03-13',1994, 'Argentino');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Abelardo Fernández','1970-03-19',2008, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Rubi','1970-01-01',2001, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Pako Ayestarán','1963-02-05',2013, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Voro','1963-10-09',2001, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Cesare Prandeli','1957-08-19',1990, 'Italiano');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Fran Escribá','1965-05-03',2012, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Luis Zubeldía','1981-01-13',2008, 'Argentino');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Javier Cabello','1974-07-20',2000, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Giovanni De Biasi','1956-07-16',1990, 'Italiano');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('José Ángel Ziganda','1966-10-01',2003, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Juan Carlos Unzué','1967-03-22',2010, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Cristobal Parralo','1967-08-21',2009, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Clarence Seedorf','1976-04-01',2014, 'Holandés');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('David Gallego','1972-01-26',2017, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('José Bordalás','1964-03-05',1993, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Pablo Machín','1975-05-07',2006, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Manuel Márquez','1968-09-07',2002, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Marcelino García Toral','1965-08-14',1997, 'Español');	
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Francisco Ortiz','1969-08-12',2017, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Juan Ramón López Muñiz','1968-11-02',2006, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Paco López','1967-09-19',2004, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('José Miguel González','1963-03-23',2005, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('José González','1966-10-14',1984, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Imanol Alguacil','1971-07-04',2010, 'Español');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Vincenzo Montella','1974-06-18',2011, 'Italiano');
INSERT INTO "stg"."stg_entrenador"  ( nombre, fecha_nacimiento, ano_debut, nacionalidad)
    VALUES ('Javier Calleja','1978-05-12',2014, 'Español');	