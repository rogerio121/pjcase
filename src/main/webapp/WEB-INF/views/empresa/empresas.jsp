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
            <input type="search" id="filtro" class="form-control input-group input-group-sm mb-3" placeholder="Filtrar empresa por nome" onkeyup="geraTabelaEmpresas()"/>
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

    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>

        numeroDePaginasDaTabela(${empresasJson})
        geraTabelaEmpresas()

        function geraTabelaEmpresas() {
            var empresasJson = ${empresasJson}
            var empresasJsonFiltradas = new Array()
            var filtro = document.getElementById('filtro').value.toUpperCase()
            document.getElementById('corpo-tabela').innerHTML = ""


            for(let i = 0; i < empresasJson.length; i++ ) {
                if (empresasJson[i].nome.toUpperCase().indexOf(filtro) == 0) {
                    empresasJsonFiltradas.push(empresasJson[i])
                    document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                        '                                <td><span class="pointer" onclick="chamaTelaViewEmpresas(' + empresasJson[i].cnpj + ')">' + empresasJson[i].nome + '</span></td>\n' +
                        '                                <td class="cnpj">' + empresasJson[i].cnpj + '</td>\n' +
                        '                                <td>\n' +
                        '                                    <button onclick="chamaTelaEditarEmpresa(' + empresasJson[i].cnpj + ')">Editar</button>\n' +
                        '                                    <button onclick="chamaExcluirEmpresa(' + empresasJson[i].cnpj + ')">Excluir</button>\n' +
                        '                                </td>\n' +
                        '                            </tr>'
                }
            }
            numeroDePaginasDaTabela(empresasJsonFiltradas)
            paginacao()
        }


        function numeroDePaginasDaTabela(empresasJson) {
            var pagina = 0
            var itensPorPagina = 6

            document.getElementById('numero-das-paginas').innerHTML = ""
            for(var i = 1; i <= empresasJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }

            if (pagina < 2)
                document.getElementById('numero-das-paginas').innerHTML = ""
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
                        console.log(res.status)
                    if (res.status == 200) {
                        var pagina = window.location.href;
                        window.location = pagina;
                    } else {
                        alert('Erro ao excluir a empresa: ' + id +'\n Verifique se ele está vinculado a uma Empresa')
                    }
                })
            }
        }

        function paginacao(){
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
    <script>
        $(".cnpj").mask("00.000.000/0000-00");
    </script>
</html>
