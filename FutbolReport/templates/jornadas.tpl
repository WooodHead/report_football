{% extends 'base.tpl' %}
{% block body%}    
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
          <div class="row">
            <div class="col-lg-12">
              <h3 class="page-header"><i class="fa fa-table"></i> JORNADAS</h3>
            </div>
          </div>
          <!-- page start-->
          <ul class="nav pull-center top-menu">                    
            <li id="label_jornada" class="dropdown">
              <label for="label_jornada" form style="width:100px">Seleccione jornada</label>       
            </li>
            <li class="dropdown">
              <select class="form-control" id="select_jornada">
                {% for jornada in num_jornadas %} 
                <option id='valor_jornada'> {{ jornada.0}} </option>                                
                {% endfor%}
              </select>
            </li>
          </ul>
          <div class="row">
            <div class="col-lg-12">
              <section class="panel">
                <header id="tabla_jornadas" class="panel-heading">
                  1ª División Temporada {{ temporada_seleccionada }}/{{ temp }} 
                </header>
                <div class="table-responsive">
                  <table class="table">
                    <thead>
                      <tr>
                        <th>#</th>
                        <th>Equipo_local</th>
                        <th>Resultado_local</th>
                        <th>Equipo_visitante</th>
                        <th>Resultado_visitante</th>
                        <th>Fecha</th>
                        <th>Hora</th>
                      </tr>
                    </thead>
                    <tbody>                    
                      {% for jornada in jornadas %}                    
                      <tr>                        
                        <td> {{ jornada.0}} </td>
                        <td> {{ jornada.1}} </td>
                        <td> {{ jornada.2}} </td>
                        <td> {{ jornada.3}} </td>
                        <td> {{ jornada.4}} </td>
                        <td> {{ jornada.5}} </td>
                        <td> {{ jornada.6}} </td>
                      </tr>
                      {% endfor%}
                    </tbody>
                  </table>
                </div>
  
              </section>
            </div>  
          <!-- page end-->
        </section>
      </section>
      <!--main content end-->
{% endblock%}