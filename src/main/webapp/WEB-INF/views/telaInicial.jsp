<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <title>Tela inicial</title>

    </head>
    <body>
        <h3>Bem vindo ${usuarioLogado.dadosPessoais.nome}</h3>

        <div>
            <a href="/caso/cadastro">Caso</a>
            <a href="/empresa/cadastro">Empresa</a>
            <a href="/cliente/cadastro">Cliente</a>
            <a href="">Sair</a>

        </div>

        <table>
            <tr>
                <td>Id</td>
                <td>Assunto</td>
                <td>Data de Abertura</td>
            </tr>
            <c:if test="${not empty casosSemProprietaio}">
                <c:forEach items="${casosSemProprietaio }" var="caso">
                    <tr>
                        <td>${caso.idCaso }</td>
                        <td>${caso.assunto }</td>
                        <td>${caso.dataDeAbertura }</td>
                        <!-- td><a href="produto/'$'{produto.id }" class="btn btn-info">Alterar</a></td -->
                        <!-- td><a onclick="excluir('$'{produto.id})" class="btn btn-danger">Excluir</a></td-->
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </body>
</html>
