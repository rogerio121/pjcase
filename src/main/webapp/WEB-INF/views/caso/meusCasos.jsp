<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Casos do(a) ${usuarioLogado.dadosPessoais.nome}</title>
    </head>
    <body>
        <table>
            <tr>
                <td>Id</td>
                <td>Assunto</td>
                <td>Status</td>
                <td>Data de Abertura</td>
                <td>Data de Fechamento</td>
            </tr>
            <c:if test="${not empty casosDoUsuarioLogado}">
                <c:forEach items="${casosDoUsuarioLogado}" var="caso">
                    <tr>
                        <td>${caso.idCaso}</td>
                        <td>${caso.assunto}</td>
                        <td>${caso.status}</td>
                        <td>${caso.dataDeAbertura}</td>
                        <td>${caso.dataDeFechamento}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </body>
</html>
