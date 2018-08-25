<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Caso</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_casoView.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_menu.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    <div class="div-form">
        <h1>Caso ${caso.idCaso}</h1>
        <form action="/caso/salvar" method="POST" id="form-caso">
            <h1 id="titulo"></h1>
            <table class="caso">
                <tr>
                    <td><label>Assunto</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="assunto" class="form-control input-group input-group-sm mb-3"
                                   value="${caso.assunto}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Mensagem</label></td>
                    <td><textarea rows="3" cols="50" name="mensagem"
                                  class="form-control input-group input-group-sm mb-3" disabled>${caso.mensagem}</textarea>
                    </td>
                </tr>
                <tr>
                    <td><label>CPF do cliente </label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="cliente.dadosPessoais.cnpj"
                                   class="form-control input-group input-group-sm mb-3" required
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
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="empresa.cnpj" class="form-control input-group input-group-sm mb-3"
                                   required value="${caso.empresa.cnpj}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Resolução</label></td>
                    <td><textarea rows="3" cols="50" id="resolucao"
                                  class="form-control input-group input-group-sm mb-3"
                                  name="resolucao" disabled>${caso.resolucao}</textarea>
                    </td>
                </tr>
                <tr>
                    <td><label>Usuario</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="email" value="${usuario.dadosPessoais.email}" name="usuario.dadosPessoais.email"
                               disabled>
                        </div>
                </tr>
            </table>
        </form>
        <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>
        </form>
        <div class="div-form">
            <button onclick="editarCaso(${caso.idCaso})">Editar</button>
    </body>
    <script>

        function editarCaso(idCaso) {
            console.log(idCaso)
            window.location = '/caso/cadastro/editar/' + idCaso
        }
    </script>
</html>
