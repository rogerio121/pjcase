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
            <input type="search" id="filtro" class="form-control input-group input-group-sm mb-3" placeholder="Filtrar usuário por nome" onkeyup="geraTabelaUsuarios()"/>
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

    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>

        numeroDePaginasDaTabela(${usuariosJson})
        geraTabelaUsuarios()

        function geraTabelaUsuarios() {
            var usuariosJson = ${usuariosJson}
            var usuariossJsonFiltrados = new Array()
            var filtro = document.getElementById('filtro').value.toUpperCase()
            document.getElementById('corpo-tabela').innerHTML = ""

            for(let i = 0; i < usuariosJson.length; i++ ) {
                var empresa = ''

                if (usuariosJson[i].idEmpresaRelacionada)
                    empresa = usuariosJson[i].idEmpresaRelacionada
                if (usuariosJson[i].dadosPessoais.nome.toUpperCase().indexOf(filtro) == 0) {
                    usuariossJsonFiltrados.push(usuariosJson[i])
                    document.getElementById('corpo-tabela').innerHTML += '<tr class="pointer tb-linha" onclick="chamaTelaViewUsuariio(' + usuariosJson[i].id + ')">\n' +
                        '                                <td><span>' + usuariosJson[i].dadosPessoais.nome + '</span></td>\n' +
                        '                                <td>' + usuariosJson[i].dadosPessoais.email + '</td>\n' +
                        '                                <td class="cnpj">' + empresa + '</td>\n' +
                        '                                <td class="sem-evento">\n' +
                        '                                    <button class="btn btn-primary" onclick="chamaTelaEditarUsuariio(' + usuariosJson[i].id + ')"> <i class="fas fa-pencil-alt"></i> Editar</button>\n' +
                        '                                    <button class="btn btn-danger" onclick="chamaExcluirUsuario(' + usuariosJson[i].id + ')"> <i class="fas fa-trash-alt"></i> Excluir</button>\n' +
                        '                                </td>\n' +
                        '                            </tr>'
                }
            }
            numeroDePaginasDaTabela(usuariossJsonFiltrados)
            paginacao()
        }


        function numeroDePaginasDaTabela(usuariosJson) {
            var pagina = 0
            var itensPorPagina = 4

            document.getElementById('numero-das-paginas').innerHTML = ''

            for(var i = 1; i <= usuariosJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }

            if (pagina < 2)
                document.getElementById('numero-das-paginas').innerHTML = ""
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
                        location.reload()
                    } else {
                        alert('Erro ao excluir o usuário: ' + id)
                    }
                })
            }
        }

        function paginacao() {
            itensPorPagina = 4

            showPage = function (pagina) {
                $(".tb-linha").hide()
                $(".tb-linha").each(function (linhas) {
                    if (linhas >= itensPorPagina * (pagina - 1) && linhas < itensPorPagina * pagina)
                        $(this).show()

                })
            }

            //O numero 1 é a página de inicio
            showPage(1);

            //PEga o Numero da página corrente e passa para o método showPage
            $("#numero-das-paginas li a").click(function () {
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
