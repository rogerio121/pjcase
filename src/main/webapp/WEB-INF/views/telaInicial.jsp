<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <title>Tela inicial</title>
    </head>
    <body>
        <h3>Bem vindo ${usuarioLogado.dadosPessoais.nome}</h3>

        <c:if test="${not empty x}">
            <c:forEach items="${x}" var="lists">
                ${lists.id}
            </c:forEach>
        </c:if>

        <div>
            <a href="/caso/cadastro">Caso</a>
            <a href="/empresa/cadastro">Empresa</a>
            <a href="/cliente/cadastro">Cliente</a>
            <a href="">Sair</a>

        </div>
    </body>
</html>
