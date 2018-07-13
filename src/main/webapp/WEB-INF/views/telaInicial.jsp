<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Tela inicial</title>
    </head>
    <body onload="funcoesDeAdminNoMenu()">
        <h3>Bem vindo ${usuarioLogado.dadosPessoais.nome}</h3>

        <c:import url="menu.jsp"></c:import>

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
                        <td><a onclick="pegarCaso(${caso.idCaso},'${usuarioLogado.dadosPessoais.email}')"  id="${caso.idCaso}" class="btn btn-info">Pegar Caso</a></td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>

        <script>

            function pegarCaso(id, emailUsuario){
                var url = window.location.href;
                console.log(id);
                console.log(emailUsuario);

                fetch('caso/cadastro/' + id,
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'text/plain'
                        },
                        method: "PUT",
                        body: emailUsuario
                    })
                    .then(function (res) {
                        console.log(res)
                        if(res.status == 200)
                            location.reload()
                        else
                            alert('Erro ao pegar o caso, consulte um administrador')
                    })
            }
        </script>
    </body>
</html>
