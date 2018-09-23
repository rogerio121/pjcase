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
    <body>

    <div class="container">
        <div class="row">
            <div class="col-sm">
                <h1>Casos sem proprietário</h1>
                <input type="search" id="filtro" class="form-control input-group input-group-sm mb-3" placeholder="Filtrar casos por nome" onkeyup="geraTabelaCasos()"/>
                <table class="tabela table table-hover">
                    <tr>
                        <th>Id</th>
                        <th>Assunto</th>
                        <th>Data de Abertura</th>
                    </tr>
                    <tbody id="corpo-tabela">
                    </tbody>
                </table>
                <nav aria-label="...">
                    <ul id="numero-das-paginas" class="pagination">
                    </ul>
                </nav>
            </div>
            <div class="col-sm">
                <div>
                    <h5>Meus casos ainda abertos</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosAbertos}</h1>
                </div>

                <div>
                    <h5>Meus casos em atendimento</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosEmAtendimento}</h1>
                </div>

                <div>
                    <h5>Meus casos em atendimento</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosEmAtendimento}</h1>
                </div>
            </div>
        </div>
    </div>

    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>

        numeroDePaginasDaTabela(${casosSemProprietaioJson})
        geraTabelaCasos()

            function pegarCaso(id){
                var url = window.location.href
                var usuario = "${usuarioLogado.id}"
                console.log(id)
                console.log(usuario)

                fetch('caso/cadastro/' + id,
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'text/plain'
                        },
                        method: "PUT",
                        body: usuario
                    })
                    .then(function (res) {
                        console.log(res)
                        if(res.status == 200)
                            location.reload()
                        else
                            alert('Erro ao pegar o caso, consulte um administrador')
                    })
            }

            function chamaTelaViewCaso(id) {
                window.location = '/caso/cadastro/' + id
            }

            function geraTabelaCasos(){
                var casosJson = ${casosSemProprietaioJson}
                var casosJsonFiltrados = new Array();
                var filtro = document.getElementById('filtro').value.toUpperCase()
                document.getElementById('corpo-tabela').innerHTML = ""

                for(let i = 0; i < casosJson.length; i++ ){
                    console.log(casosJson[i].assunto + casosJson[i].assunto.toUpperCase().indexOf(filtro))
                    if(casosJson[i].assunto.toUpperCase().indexOf(filtro) == 0) {
                        casosJsonFiltrados.push(casosJson[i])
                        var dataAbertura = ''

                        if (casosJson[i].dataDeAbertura)
                            dataAbertura = casosJson[i].dataDeAbertura

                        document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                            '                                <td><span class="pointer" onclick="chamaTelaViewCaso(' + casosJson[i].idCaso + ')">' + casosJson[i].idCaso + '</span></td>\n' +
                            '                                <td>' + casosJson[i].assunto + '</td>\n' +
                            '                                <td>' + dataAbertura + '</td>\n' +
                            '                                <td>\n' +
                            '                                    <button onclick="chamaTelaEditarCaso(' + casosJson[i].idCaso + ')">Editar</button>\n' +
                            '                                    <button onclick="chamaExcluirCaso(' + casosJson[i].idCaso + ')">Excluir</button>\n' +
                            '                                </td>\n' +
                            '                            </tr>'
                    }
                }

                numeroDePaginasDaTabela(casosJsonFiltrados)
                paginacao()
            }

            function numeroDePaginasDaTabela(casosJson) {
                var pagina = 0
                var itensPorPagina = 6

                document.getElementById('numero-das-paginas').innerHTML = ""
                for(var i = 1; i <=casosJson.length ; i+=itensPorPagina ) {
                    pagina++
                    document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
                }
                if (pagina < 2)
                    document.getElementById('numero-das-paginas').innerHTML = ""
            }

        function paginacao() {
            itensPorPagina = 6

            showPage = function(pagina) {
                $(".tb-linha").hide()
                $(".tb-linha").each(function(linhas) {
                    if (linhas >= itensPorPagina * (pagina - 1) && linhas < itensPorPagina * pagina)
                        $(this).show()

                })
            }

            //O numero 1 é a página de inicio
            showPage(1);

            //PEga o Numero da página corrente e passa para o método showPage
            $("#numero-das-paginas li a").click(function() {
                $("#numero-das-paginas li a").removeClass("current");
                $(this).addClass("current");
                showPage(parseInt($(this).text()))
            });
        }
        </script>
    </body>
</html>
