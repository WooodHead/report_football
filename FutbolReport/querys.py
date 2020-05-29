def seleccionar_jugador_completo(ano):
    if ano  == '2016':
        query = """
            select nombre,fecha_nacimiento,posicion from dw.dim_jugador
            where id_jugador in (select id_jugador from dw.fact_jornada where id_partido <= '179889')             
            group by nombre,fecha_nacimiento,posicion
            order by 1;  
            """
        return query
    elif ano  == '2017':
        query = """
            select nombre,fecha_nacimiento,posicion from dw.dim_jugador
            where id_jugador in (select id_jugador from dw.fact_jornada) 
            group by nombre,fecha_nacimiento,posicion
            order by 1;  
            """
        return query
    else: 
        query = """
            select nombre,fecha_nacimiento,posicion from dw.dim_jugador
            where id_jugador in (select id_jugador from dw.fact_jornada where id_partido <= '179889') 
            -- <= '179889' ->temp 2016
            -- > '179889' ->temp 2017
            -- total sin el where
            group by nombre,fecha_nacimiento,posicion
            order by 1;  
            """
        return query	


query_seleccionar_equipos_jugadores= """
select equi.nombre,ROW_NUMBER() OVER(    ORDER BY equi.nombre) from stg.stg_partido par
inner join stg.stg_equipo equi
on equi.id_equipo=par.id_equipo_local
where temporada = :ano
group by equi.nombre
""" 

query_seleccionar_equipos=""" 
	select ROW_NUMBER() OVER(    ORDER BY equi.nombre),equi.nombre,equi.ano_fundacion,est.ciudad
	from stg.stg_partido par
	inner join stg.stg_equipo equi
	on equi.id_equipo=par.id_equipo_local
	inner join stg.stg_estadio est
	on equi.id_equipo= est.id_equipo
	where temporada = :ano
	group by equi.nombre,equi.ano_fundacion,est.ciudad
	""" 

query_seleccionar_puntuaciones = """ 
	select jug.nombre,jug.nacionalidad,jug.posicion,sum(puntuacion),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY sum(puntuacion) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY"""

query_seleccionar_goleadores = """ 
	select jug.nombre,jug.nacionalidad,jug.posicion,sum(goles),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY sum(goles) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY"""

query_seleccionar_tarjeta_amarilla = """ 
	select jug.nombre,jug.nacionalidad,jug.posicion,sum(tarjeta_amarilla),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY sum(tarjeta_amarilla) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY""" 

query_seleccionar_tarjeta_roja=""" 
	select jug.nombre,jug.nacionalidad,jug.posicion,sum(tarjeta_roja),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY sum(tarjeta_roja) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY""" 


query_seleccionar_minutos_jugados = """ 
	select jug.nombre,jug.nacionalidad,jug.posicion,sum(minutos_jugados),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY sum(minutos_jugados) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY"""

query_seleccionar_titularidades = """ 
	select jug.nombre,jug.nacionalidad,jug.posicion,count(minutos_jugados),jug.id_jugador
	,ROW_NUMBER() OVER(    ORDER BY count(minutos_jugados) desc) 
	from stg.stg_suceso suc
	inner join stg.stg_jugador jug on suc.id_jugador=jug.id_jugador
	inner join stg.stg_partido par on par.id_partido=suc.id_partido
	where par.temporada = :ano
    and suc.titular = 'SI'
	group by jug.nombre,jug.nacionalidad,jug.posicion,jug.id_jugador  FETCH FIRST 10 ROWS ONLY""" 

query_fecha_minima = """select min(fecha) from stg.stg_partido 	where temporada = :ano 	"""
 
query_fecha_maxima = """select max(fecha) from stg.stg_partido 	where temporada = :ano 	"""

query_seleccionar_entrenadores = """ 
	select ROW_NUMBER() OVER(    ORDER BY nombre),query.* from (
	select equ.nombre,ent.nombre as nombre_entre,ent.ano_debut,ent.fecha_nacimiento,ent.nacionalidad
	from stg.stg_lidera lid
	inner join stg.stg_equipo equ
	on equ.id_equipo=lid.id_equipo
	inner join stg.stg_entrenador ent
	on ent.id_entrenador=lid.id_entrenador
	where fecha_inicio_contrato between (:fec_min) and (:fec_max)
	UNION
	select equ.nombre,ent.nombre,ent.ano_debut,ent.fecha_nacimiento,ent.nacionalidad
	from stg.stg_lidera lid
	inner join stg.stg_equipo equ
	on equ.id_equipo=lid.id_equipo
	inner join stg.stg_entrenador ent
	on ent.id_entrenador=lid.id_entrenador
	where fecha_inicio_contrato < (:fec_min) 
	and fecha_fin_contrato is null) as query;
	"""

query_seleccionar_jornadas =    """ 
	select ROW_NUMBER() OVER(    ORDER BY par.fecha,par.hora),equ_loc.nombre,par.resultado_local,equ_vis.nombre,par.resultado_rival,par.fecha,par.hora
    from stg.stg_partido par
    inner join stg.stg_equipo equ_loc
    on par.id_equipo_local = equ_loc.id_equipo
    inner join stg.stg_equipo equ_vis
    on par.id_equipo_rival = equ_vis.id_equipo
    where temporada=  :ano  
	and jornada = :jornada;
	"""

query_seleccionar_num_jornadas =  """
	select 
	ROW_NUMBER() OVER(    ORDER BY jornada)
	from  stg.stg_partido
	where temporada= :ano  
    group by jornada order by jornada
	"""  

query_seleccionar_jugadores = """ 
	select ROW_NUMBER() OVER(    ORDER BY nombre),query.* from    
	(select jug.nombre,jug.fecha_nacimiento,jug.nacionalidad,jug.pie,jug.posicion,valor_mercado 
	,fecha_inicio_contrato,fecha_fin_contrato
	from stg.stg_milita mil
    inner join stg.stg_equipo equ on mil.id_equipo=equ.id_equipo
    inner join stg.stg_jugador jug on jug.id_jugador = mil.id_jugador
    where equ.nombre = :nuevo_equipo  
    and fecha_inicio_contrato between (:fec_min) and (:fec_max)
	UNION
	select jug.nombre,jug.fecha_nacimiento,jug.nacionalidad,jug.pie,jug.posicion,valor_mercado 
	,fecha_inicio_contrato,fecha_fin_contrato
	from stg.stg_milita mil
    inner join stg.stg_equipo equ on mil.id_equipo=equ.id_equipo
    inner join stg.stg_jugador jug on jug.id_jugador = mil.id_jugador
    where equ.nombre = :nuevo_equipo 
    and fecha_inicio_contrato < (:fec_min) 
    and fecha_fin_contrato is null) as query
	"""

query_seleccionar_estadios =  """ 
	select ROW_NUMBER() OVER(    ORDER BY equ.nombre),equ.nombre,est.estadio,est.ciudad,est.capacidad,est.coordenada_x,est.coordenada_y,
    regexp_replace(est.estadio, ' ', '_', 'g')
    from stg.stg_estadio est
    inner join stg.stg_equipo equ
    on est.id_equipo = equ.id_equipo
	"""