<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../resources/css/style_telainicial.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap-grid.css">
        <title>Tela inicial</title>
    </head>
    <header>
        <jsp:include page="menu.jsp"></jsp:include>
    </header>
    <body>

    <div class="container">
        <div class="row">
            <div class="col-sm">

                <h1>Casos sem proprietário</h1>
                <table class="tabela table table-hover">
                    <tr>
                        <th>Id</th>
                        <th>Assunto</th>
                        <th>Data de Abertura</th>
                    </tr>
                    <c:if test="${not empty casosSemProprietaio}">
                        <c:forEach items="${casosSemProprietaio }" var="caso">
                            <tr>
                                <td class="pointer" onclick="chamaTelaViewCaso(${caso.idCaso})">${caso.idCaso }</td>
                                <td>${caso.assunto }</td>
                                <td>${caso.dataDeAbertura }</td>
                                <td><button  onclick="pegarCaso(${caso.idCaso})" id="${caso.idCaso}"  class="btn btn-primary">Pegar
                                    Caso</button></td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
            <div class="col-sm">
                <div>
                    <h5>Meus casos ainda abertos</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosAbertos}</h1>
                </div>

                <div>
                    <h5>Meus casos em atendimento</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosEmAtendimento}</h1>
                </div>

                <div>
                    <h5>Meus casos em atendimento</h5>
                    <img src="../resources/imagens/circulo-azul.png" class="circulo">
                    <h1 class="numero">${meusCasosEmAtendimento}</h1>
                </div>
            </div>
        </div>
    </div>

    <script>

            function pegarCaso(id){
                var url = window.location.href
                var usuario = "${usuarioLogado.id}"
                console.log(id)
                console.log(usuario)

                fetch('caso/cadastro/' + id,
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'text/plain'
                        },
                        method: "PUT",
                        body: usuario
                    })
                    .then(function (res) {
                        console.log(res)
                        if(res.status == 200)
                            location.reload()
                        else
                            alert('Erro ao pegar o caso, consulte um administrador')
                    })
            }

            function chamaTelaViewCaso(id) {
                window.location = '/caso/cadastro/' + id
            }
        </script>
    </body>
</html>
