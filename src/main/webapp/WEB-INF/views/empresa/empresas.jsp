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
                <c:if test="${not empty empresasCadastradas}">
                    <c:forEach items="${empresasCadastradas}" var="empresa">
                        <tr>
                            <td onclick="chamaTelaViewEmpresas(${empresa.cnpj})"><span
                                    class="pointer">${empresa.nome}</span></td>
                            <td>${empresa.cnpj}</td>
                            <td>
                                <button onclick="chamaTelaEditarEmpresa(${empresa.cnpj})">Editar</button>
                                <button onclick="chamaExcluirEmpresa(${empresa.cnpj})">Excluir</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
    </body>
    <script>
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
</html>
