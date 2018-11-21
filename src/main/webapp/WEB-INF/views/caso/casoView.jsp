<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_casoView.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Caso</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
    <div class="div-form">
        <h1>Caso ${caso.idCaso}</h1>
        <form action="/caso/salvar" method="POST" id="form-caso">
            <c:if test="${erroAoCriarCaso}"> <h1 class="alert-danger" style="width: 70%;"> Ocorreu um erro ao criar caso! </h1></c:if>
            <c:if test="${erroEmail == true}"> <h1 class="alert-danger" style="width: 70%;"> Ocorreu um erro ao envia o e-mail ao cliente! </h1></c:if>
            <h1 id="titulo"></h1>
            <table class="caso">
                <tr>
                    <td><label>Assunto</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="assunto" class="form-control" value="${caso.assunto}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Mensagem</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <textarea rows="3" cols="50" name="mensagem" class="form-control" disabled>${caso.mensagem}</textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CPF do cliente </label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3 cpf-cnpj">
                            <input type="text" name="cliente.dadosPessoais.cnpj" class="form-control" required id="cpf"
                                   value="${caso.cliente.dadosPessoais.cpf}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Status</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <select name="status" id="status" disabled>
                                <option selected value="Aberto">Aberto</option>
                                <option value="Em atendimento">Em atendimento</option>
                                <option value="Fechado">Fechado</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CNPJ da empresa</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3 cpf-cnpj">
                            <input type="text" name="empresa.cnpj" class="form-control" id="cnpj" required value="${caso.empresa.cnpj}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Resolução</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <textarea rows="3" cols="50" id="resolucao" class="form-control" name="resolucao" disabled>${caso.resolucao}</textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Usuario</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" type="email" value="${caso.usuario.dadosPessoais.email}" name="usuario.dadosPessoais.email"
                               disabled>
                        </div>
                </tr>
            </table>
        <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>
        </form>
        <div class="div-form">
            <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
            <button class="btn btn-primary" onclick="editarCaso(${caso.idCaso})">Editar</button>
    </body>
    <script>

        pegarStatus()

        function pegarStatus() {
            var status = '${caso.status}'
            if (status)
                document.getElementById('status').value = status
        }

        function editarCaso(idCaso) {
            console.log(idCaso)
            window.location = '/caso/cadastro/editar/' + idCaso
        }

        function  cancelar() {
            window.history.back()
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
        $("#cpf").mask("000.000.000-00");
    </script>
</html>
