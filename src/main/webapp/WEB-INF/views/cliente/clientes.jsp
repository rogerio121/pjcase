<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Clientes</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_menu.css">
        <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap-grid.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    <div class="container">
        <div class="row">
            <div class="col-sm">

                <h1>Casos sem proprietário</h1>
                <table class="tabela table table-hover">
                    <tr>
                        <th>Nome</th>
                        <th>Email</th>
                    </tr>
                    <c:if test="${not empty clientes}">
                        <c:forEach items="${clientes}" var="cliente">
                            <tr>
                                <td onclick="chamaTelaViewCliente(${cliente.dadosPessoais.cpf})">${cliente.dadosPessoais.nome}</td>
                                <td>${cliente.dadosPessoais.email}</td>
                                <td>
                                    <button onclick="chamaTelaEditarCliente(${cliente.dadosPessoais.cpf})">Editar
                                    </button>
                                    <button onclick="chamaExcluirCliente(${cliente.dadosPessoais.cpf})">Excluir</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
        </div>
    </div>
    </body>
    <script>
        function chamaTelaViewCliente(id) {
            window.location = '/cliente/cadastro/' + id
        }

        function chamaTelaEditarCliente(id) {
            window.location = '/cliente/cadastro/editar/' + id
        }


        function chamaExcluirCliente(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir o cliente ?')

            if (realmenteQuerExcluir) {
                fetch('/cliente/cadastro/' + id,
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
                        alert('Erro ao excluir o cliente: ' + id)
                    }
                })
            }
        }

    </script>
</html>
