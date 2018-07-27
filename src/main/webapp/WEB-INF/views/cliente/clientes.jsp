<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Clientes</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <table>
            <tr>
                <td>Nome</td>
                <td>Email</td>
            </tr>
            <c:if test="${not empty clientes}">
                <c:forEach items="${clientes}" var="cliente">
                    <tr>
                        <td onclick="chamaTelaViewCliente(${cliente.dadosPessoais.cpf})">${cliente.dadosPessoais.nome}</td>
                        <td>${cliente.dadosPessoais.email}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </body>
    <script>
        function chamaTelaViewCliente(idConta) {
            window.location = '/cliente/cadastro/' + idConta
        }
    </script>
</html>
