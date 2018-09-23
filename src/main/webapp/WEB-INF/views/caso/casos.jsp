<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Casos do(a) ${usuarioLogado.dadosPessoais.nome}</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
    <div class="container">
        <div class="row">
            <div class="col-sm">
                <h1 id="titulo"></h1>
                <input type="search" id="filtro" class="form-control input-group input-group-sm mb-3" placeholder="Filtrar casos por assunto" onkeyup="geraTabelaCasos()"/>
                <div class="input-group input-group-sm mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="inputGroupSelect01">Só ver casos que o status
                            seja: </label>
                    </div>
                    <select name="status" id="status" onclick="filtrarCasos()" id="inputGroupSelect01">
                        <option value="todososcasos">Todos os Casos</option>
                        <option value="Aberto">Casos em aberto</option>
                        <option value="Em atendimento">Casos em atendimento</option>
                        <option value="Fechado">Casos fechado</option>
                    </select>
                </div>

                <table id="tb-casos" class="tabela table table-hover">
                    <tr>
                        <th>Id</th>
                        <th>Assunto</th>
                        <th>Status</th>
                        <th>Data de Abertura</th>
                        <th>Data de Fechamento</th>
                    </tr>
                    <tbody id="corpo-tabela">
                    </tbody>
                </table>
                <nav aria-label="...">
                    <ul id="numero-das-paginas" class="pagination">
                    </ul>
                </nav>
            </div>
        </div>
    </body>

    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>

        titulo()
        setFiltroStatus()
        numeroDePaginasDaTabela(${casosJson})
        geraTabelaCasos()
        
        var filtroAplicado = '${filtroAplicado}'

        function setFiltroStatus() {
            let filtroAplicado = '${filtroAplicado}'
            console.log('${filtroAplicado}')
            if (filtroAplicado)
                document.getElementById('status').value = filtroAplicado
        }

        function titulo() {
            console.log(window.location.href)
            console.log(window.location.href.includes('meuscasos'))
            if(window.location.href.includes('meuscasos'))
                document.getElementById('titulo').innerText = 'Meus Casos'
            else
                document.getElementById('titulo').innerText = 'Todos os Casos'
        }

        function geraTabelaCasos(){
            var casosJson = ${casosJson}
            var casosJsonFiltrados = new Array();
            var filtro = document.getElementById('filtro').value.toUpperCase()
            document.getElementById('corpo-tabela').innerHTML = ""

            for(let i = 0; i < casosJson.length; i++ ){
                console.log(casosJson[i].assunto + casosJson[i].assunto.toUpperCase().indexOf(filtro))
                if(casosJson[i].assunto.toUpperCase().indexOf(filtro) == 0) {
                    casosJsonFiltrados.push(casosJson[i])
                    var dataAbertura = ''
                    var dataFechamento = ''

                    if (casosJson[i].dataDeAbertura)
                        dataAbertura = casosJson[i].dataDeAbertura

                    if (casosJson[i].dataDeFechamento)
                        dataFechamento = casosJson[i].dataDeFechamento

                    document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                        '                                <td><span class="pointer" onclick="chamaTelaViewCaso(' + casosJson[i].idCaso + ')">' + casosJson[i].idCaso + '</span></td>\n' +
                        '                                <td>' + casosJson[i].assunto + '</td>\n' +
                        '                                <td>' + casosJson[i].status + '</td>\n' +
                        '                                <td>' + dataAbertura + '</td>\n' +
                        '                                <td>' + dataFechamento + '</td>\n' +
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

        function chamaTelaViewCaso(id) {
            window.location = '/caso/cadastro/' + id
        }

        function chamaTelaEditarCaso(id) {
            window.location = '/caso/cadastro/editar/' + id
        }

        function chamaExcluirCaso(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir o caso ?')

            if (realmenteQuerExcluir) {
                fetch('/caso/cadastro/' + id,
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'String'
                        },
                        method: "DELETE",
                    }).then(function (res) {
                    if (res.status == 200) {
                        var pagina = window.location.href;
                        window.location = pagina;
                    } else {
                        alert('Erro ao excluir o caso: ' + id)
                    }
                })
            }
        }

        function filtrarCasos() {
            var filtro, tabela, linhas, coluna

            filtro = document.getElementById('status').value

            if(filtro && filtroAplicado && filtroAplicado != filtro){
                console.log(filtroAplicado)
                console.log(filtro)
                if(window.location.href.includes('meuscasos'))
                    window.location.href = '/caso/meuscasos/'+filtro
                else
                window.location.href = '/caso/'+filtro
            }
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
</html>
