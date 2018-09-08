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
                <c:if test="${not empty usuarios}">
                    <c:forEach items="${usuarios}" var="usuario">
                        <tr>
                            <td onclick="chamaTelaViewUsuariio(${usuario.id})"><span class="pointer">${usuario.dadosPessoais.nome}</span></td>
                            <td>${usuario.dadosPessoais.email}</td>
                            <td>${usuario.idEmpresaRelacionada}</td>
                            <td>
                                <button onclick="chamaTelaEditarUsuariio(${usuario.id})">Editar</button>
                                <button onclick="chamaExcluirUsuario(${usuario.id})">Excluir</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
    </body>
    <script>
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
</html>
