<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
    <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
    <link rel="stylesheet" type="text/css" href="../resources/css/style_telainicial.css">
    <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap-grid.css">
    <title>Tela inicial</title>
</head>
<header>
    <jsp:include page="menu.jsp"></jsp:include>
</header>
<head>
    <title> Gráficos </title>
</head>
<body>

    <style>
        input{
            width: 110px !important;
        }

        table tr td{
            margin-left: 5px;
        }

        #div-filtro{
            width: 80%;
        }

        #tab-filtro{
            width: 100% !important;
        }

        #div-filtro{
            margin:auto;
        }

        #carouselExampleFade{
            width: 80%;
            margin: auto;
        }

        .graficoDeLinhas{
            width: 100% !important;
            height: 70% !important;
        }

        .div-grafico{
            position: relative;
            height: 87vh;
            width: 73vw;
            margin: auto;
        }

        .carousel-control-prev, .carousel-control-next{
            background-color: #222222;
            width: 30px !important;
            height: 410px;
        }

        </style>
        <div id="carouselExampleFade" class="carousel slide carousel-fade" data-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div id="div-filtro">
                        <table id="tab-filtro">
                            <tr>
                                <td><label>Status: </label></td>
                                <td>
                                    <select name="status" id="status">
                                        <option selected value="*">Todos os Status</option>
                                        <option value="Aberto">Aberto</option>
                                        <option value="Em atendimento">Em atendimento</option>
                                        <option value="Fechado">Fechado</option>
                                    </select>
                                </td>
                                <td>
                                    <label>De: </label>
                                </td>
                                <td>
                                    <input type="text" id="inp-de" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"/>
                                </td>
                                <td>
                                    <label>Até: </label>
                                </td>
                                <td>
                                    <input type="text" id="inp-ate" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm"/>
                                </td>
                                <td>
                                    <button onclick="filtrarGrafico()" class="btn btn-success">Filtrar</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="div-grafico carrocel-item1"></div>
                </div>
                <div class="carousel-item">
                    Dois
                </div>
                <div class="carousel-item">
                    Tres
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleFade" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleFade" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </a>
        </div>


    <script src="../../../resources/JavaScript/script_geral.js"></script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
    <script>

        let dadosGraficoQuantidadeDeCasosPorUsuario = ${dadosCasosPorUsuario}
        gerarGraficoCasosPorUsuarioEStatus()

        function gerarGraficoCasosPorUsuarioEStatus(dadosGraficoQuantidadeDeCasosPorUsuarioSemFiltro) {
            document.getElementsByClassName('div-grafico')[0].innerHTML = '<canvas class="graficoDeLinhas"></canvas>'
            let contexto = document.getElementsByClassName('graficoDeLinhas')

            let chartGrafico = new Chart(contexto, {
                type: 'bar',
                data:{
                    labels: getNomeCasosPorUsuario(dadosGraficoQuantidadeDeCasosPorUsuario),
                    datasets:[{
                        label: "Numero de Casos",
                        data: getNumeroDeCasosPorUsuario(dadosGraficoQuantidadeDeCasosPorUsuario),
                        backgroundColor: '#0076F5',
                        hoverBackgroundColor: '#222222',
                    }]
                },
                options:{
                    title:{
                        display: true,
                        fontSize: 20,
                        text:"Casos por usuário"
                    },
                    labels:{
                        fontSize: 15
                    },
                    legend:{
                        display: true,
                        labels: {
                            fontSize: 15
                        }
                    }
                }
            });
        }

        function getNomeCasosPorUsuario(casosPorUsuario) {
            let nomes = new Array()
            for (i in casosPorUsuario){
                let nome = casosPorUsuario[i].dadoReferenteAoCont
                nomes.push(nome)
            }
            return nomes
        }

        function getNumeroDeCasosPorUsuario(casosPorUsuario) {
            let numeroDeCasos = new Array()
            for (i in casosPorUsuario){
                let numero = casosPorUsuario[i].count
                numeroDeCasos.push(numero)
            }
            console.log(numeroDeCasos)
            return numeroDeCasos
        }

        function filtrarGrafico(dados) {
            let dataInicio = $("#inp-de").val()
            let dataFim = $("#inp-ate").val()
            let status = $("#status").val()

            let filtrados = new Array()

            if(status != 'Fechado' && dataFim){
                alert('Somente casos fechados possuem data de fim')
            }else if (status && dataInicio){
                fetch("/buscacasosporusuariofiltrado",
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'text/plain'
                        },
                        method: "POST",
                        body: JSON.stringify({
                            //Os valores estão com "," no inicio e fim para retirar a forma de Json e ficar somente com os dados
                            filtros: ','+status + ',' + dataInicio + ',' + dataFim + ','
                        })
                    })
                    .then(function(response) {
                        response.json()
                            .then(function(result){
                                console.log(result);
                                dadosGraficoQuantidadeDeCasosPorUsuario = result
                                gerarGraficoCasosPorUsuarioEStatus()
                            })
                    })
                }
            }

        $("#inp-ate, #inp-de").mask("00/00/0000");
        $('.carousel').carousel({
            interval: 2000
        })
    </script>
</body>
</html>
