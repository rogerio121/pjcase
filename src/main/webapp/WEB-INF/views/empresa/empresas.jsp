<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Empresas</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../resources/css/style_empresas.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <div class="div-table">
            <h1>Empresas cadastradas</h1>
            <table class="tabela table table-hover">
                <tr>
                    <th>Nome</th>
                    <th>CNPJ</th>
                </tr>
                <tbody id="corpo-tabela">
                </tbody>
            </table>
            <nav aria-label="...">
                <ul id="numero-das-paginas" class="pagination">
                </ul>
            </nav>
        </div>
    </body>
    <script>

        numeroDePaginasDaTabela()
        geraTabelaCasos()

        function geraTabelaCasos() {
            var empresasJson = ${empresasJson}

            for(let i = 0; i < empresasJson.length; i++ ){
                document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                    '                                <td><span class="pointer" onclick="chamaTelaViewEmpresas('+empresasJson[i].cnpj+')">'+empresasJson[i].nome+'</span></td>\n' +
                    '                                <td>'+empresasJson[i].cnpj+'</td>\n' +
                    '                                <td>\n' +
                    '                                    <button onclick="chamaTelaEditarEmpresa('+empresasJson[i].cnpj+')">Editar</button>\n' +
                    '                                    <button onclick="chamaExcluirEmpresa('+empresasJson[i].cnpj+')">Excluir</button>\n' +
                    '                                </td>\n' +
                    '                            </tr>'
            }
        }


        function numeroDePaginasDaTabela() {
            var empresasJson = ${empresasJson}
            var pagina = 0
            var itensPorPagina = 6

            console.log(empresasJson.length)
            for(var i = 1; i <= empresasJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }
        }

        function chamaTelaViewEmpresas(idEmpresa) {
            window.location = '/empresa/cadastro/' + idEmpresa
        }

        function chamaTelaEditarEmpresa(id) {
            window.location = '/empresa/cadastro/editar/' + id
        }


        function chamaExcluirEmpresa(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir a empresa ?')

            if (realmenteQuerExcluir) {
                fetch('/empresa/cadastro/' + id,
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
                        alert('Erro ao excluir a empresa: ' + id)
                    }
                })
            }
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>
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
    </script>
</html>
