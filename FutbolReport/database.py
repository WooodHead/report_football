from flask_sqlalchemy import SQLAlchemy
import os
from querys import *

db = SQLAlchemy()


def dame_la_lista_de_jugadores_del_ano(anoInt,equipo):
	fec_min = seleccionar_fecha_minima(anoInt)
	fec_max = seleccionar_fecha_maxima(anoInt)
	query_jug = db.session.execute(query_seleccionar_jugadores , {"fec_min": fec_min,"fec_max": fec_max, "nuevo_equipo":equipo})
	return [row for row in query_jug]


def dame_los_estadios():
	query_estadio = db.session.execute(query_seleccionar_estadios)
	estadios =  [row for row in query_estadio]
	return estadios

def seleccionar_equipos(ano):
	data = db.session.execute(query_seleccionar_equipos_jugadores, {"ano": ano})
	equipos = [row for row in data]
	return  equipos

def seleccionar_fecha_minima(ano):
	fec_min = db.session.execute(query_fecha_minima , {"ano": ano}).fetchone()[0]
	return  fec_min

def seleccionar_fecha_maxima(ano):
	fec_max = db.session.execute(query_fecha_maxima , {"ano": ano}).fetchone()[0]
	return  fec_max

def puntuaciones_hora(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765
	data = db.session.execute(query_puntuaciones_hora_partido, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones = [list(row) for row in data]	
	return  puntuaciones

def puntuaciones_rivales(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_puntuaciones_rivales, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones = [list(row) for row in data]
	return puntuaciones


def puntuaciones_estacion_ano(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_estacion_ano, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones = [list(row) for row in data]
	return puntuaciones
	

def info_global(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_info_global, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	informacion_global = [list(row) for row in data]
	return  informacion_global

def puntuaciones_temperatura(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_temperatura, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones_temperatura = [list(row) for row in data]
	return  puntuaciones_temperatura

def puntuaciones_lluvias(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_lluvias, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones_lluvias = [list(row) for row in data]
	return  puntuaciones_lluvias

def puntuaciones_humedad(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_humedad, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones_humedad = [list(row) for row in data]
	return  puntuaciones_humedad

def puntuaciones_velocidad_viento(nombre,fecha,ano):
	if ano  == '2016':
		id_ini = 179510
		id_fin = 179889
	elif ano  == '2017':
		id_ini = 214386
		id_fin = 214765
	else: 		
		id_ini = 179510
		id_fin = 214765	
	data = db.session.execute(query_viento, {"nombre": nombre,"fecha": fecha, "id_ini":id_ini, "id_fin":id_fin})
	puntuaciones_viento = [list(row) for row in data]
	return  puntuaciones_viento


def dame_jugadores(ano):
	query_jugador_completo = db.session.execute(seleccionar_jugador_completo(ano))
	return  [ list(jug) for jug in query_jugador_completo]

def dame_equipos(ano):
	query_equipo_completo = db.session.execute(seleccionar_equipo_completo(ano))
	return  [ list(jug) for jug in query_equipo_completo]

def dame_entrenadores(ano):
	query_entrenador_completo = db.session.execute(seleccionar_entrenador_completo(ano))
	return  [ list(jug) for jug in query_entrenador_completo]