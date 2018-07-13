<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Empresas</title>
    </head>
    <body>
    <table>
        <tr>
            <td>Nome</td>
            <td>CNPJ</td>
        </tr>
        <c:if test="${not empty empresasCadastradas}">
            <c:forEach items="${empresasCadastradas}" var="empresa">
                <tr>
                    <td>${empresa.nome}</td>
                    <td>${empresa.cnpj}</td>
                </tr>
            </c:forEach>
        </c:if>
    </table>
    </body>
</html>
