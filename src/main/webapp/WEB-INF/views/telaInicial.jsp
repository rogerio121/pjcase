<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Tela inicial</title>
    </head>
    <body>
        <h3>Bem vindo ${usuarioLogado.dadosPessoais.nome}</h3>

        <div>
            <a href="/caso/cadastro">Caso</a>
            <a href="/caso/cadastro">Meus Casos</a>
            <a href="/empresa/cadastro">Empresa</a>
            <a href="/cliente/cadastro">Cliente</a>
            <a href="/logout">Sair</a> <br>
            <a href="/caso/meuscasos">Meus Casos</a>
            <a href="/cliente/clientes">Clientes</a>
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
                        <td><a onclick="pegarCaso(${caso.idCaso},'${usuarioLogado.dadosPessoais.email}')"  id="${caso.idCaso}" class="btn btn-info">Pegar Caso</a></td>
                        <td><a href="/caso/cadastro/${caso.idCaso}" class="btn btn-info">Pegar Caso GET</a></td>
                        <!-- td><a onclick="excluir('$'{produto.id})" class="btn btn-danger">Excluir</a></td-->
                    </tr>
                </c:forEach>
            </c:if>
        </table>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
