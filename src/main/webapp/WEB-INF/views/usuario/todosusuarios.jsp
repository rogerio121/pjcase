<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_todosusuarios.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Usuários Cadastrados</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
        <div class="div-table">
            <h1>Usuários cadastrados</h1>
            <table id="tb-casos" class="tabela table table-hover">
                <tr>
                    <th>Nome</th>
                    <th>Email</th>
                    <th>Empresa</th>
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
            var usuariosJson = ${usuariosJson}

            for(let i = 0; i < usuariosJson.length; i++ ){
                var empresa = ''

                if(usuariosJson[i].idEmpresaRelacionada)
                    empresa = usuariosJson[i].idEmpresaRelacionada

                document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                    '                                <td><span class="pointer" onclick="chamaTelaViewUsuariio('+usuariosJson[i].id+')">'+usuariosJson[i].dadosPessoais.nome+'</span></td>\n' +
                    '                                <td>'+usuariosJson[i].dadosPessoais.email+'</td>\n' +
                    '                                <td>'+empresa+'</td>\n' +
                    '                                <td>\n' +
                    '                                    <button onclick="chamaTelaEditarUsuariio('+usuariosJson[i].id+')">Editar</button>\n' +
                    '                                    <button onclick="chamaExcluirUsuario('+usuariosJson[i].id+')">Excluir</button>\n' +
                    '                                </td>\n' +
                    '                            </tr>'
            }
        }


        function numeroDePaginasDaTabela() {
            var usuariosJson = ${usuariosJson}
            var pagina = 0
            var itensPorPagina = 6

            for(var i = 1; i <= usuariosJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }
        }

        function chamaTelaViewUsuariio(id) {
            window.location = '/usuario/cadastro/' + id
        }

        function chamaTelaEditarUsuariio(id) {
            window.location = '/usuario/cadastro/editar/' + id
        }


        function chamaExcluirUsuario(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir o usuário ?')

            if (realmenteQuerExcluir) {
                fetch('/usuario/cadastro/' + id,
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
                        alert('Erro ao excluir o usuário: ' + id)
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
