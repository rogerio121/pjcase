<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Empresas</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <table>
            <tr>
                <td>Nome</td>
                <td>CNPJ</td>
            </tr>
            <c:if test="${not empty empresasCadastradas}">
                <c:forEach items="${empresasCadastradas}" var="empresa">
                    <tr>
                        <td onclick="chamaTelaViewEmpresas(${empresa.cnpj})">${empresa.nome}</td>
                        <td>${empresa.cnpj}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </body>
    <script>
        function chamaTelaViewEmpresas(idEmpresa) {
            window.location = '/empresa/cadastro/' + idEmpresa
        }
    </script>
</html>
