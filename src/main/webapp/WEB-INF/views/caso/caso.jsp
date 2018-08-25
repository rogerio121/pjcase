<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Caso</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_caso.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <div class="div-form">
        <h1 id="titulo"></h1>
        <form action="/caso/salvar" method="POST" id="form-caso">
            <table class="caso">
                <tr>
                    <td><label>Assunto</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="assunto" class="form-control input-group input-group-sm mb-3"
                                   value="${caso.assunto}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Mensagem</label></td>
                    <td><textarea rows="3" cols="50" name="mensagem"
                                  class="form-control input-group input-group-sm mb-3">${caso.mensagem}</textarea>
                    </td>
                </tr>
                <tr>
                    <td><label>CPF do cliente </label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input type="text" name="cliente.dadosPessoais.cnpj"
                                   class="form-control input-group input-group-sm mb-3" required
                                   value="${caso.cliente.dadosPessoais.cpf}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Status</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <select name="status" id="status">
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
                                   required value="${caso.empresa.cnpj}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Resolução</label></td>
                    <td><textarea rows="3" cols="50" id="resolucao"
                                  class="form-control input-group input-group-sm mb-3"
                                  name="resolucao">${caso.resolucao}</textarea></td>
                </tr>
            </table>
            <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>
        </form>

        <button type="button" class="btn btn-danger">Cancelar</button>
        <button onclick="enviarFormulario()" class="btn btn-success">Salvar</button>
        <div hidden> ${usuarioLogado}</div>
    </div>

    </body>

    <script>
        pegarStatus()

        if(window.location.href.includes('editar'))
            document.getElementById('titulo').innerText = 'Edição de Caso'
        else
            document.getElementById('titulo').innerText = 'Cadastro de Caso'

        function pegarStatus() {
            var status = '${caso.status}'
            if (status)
                document.getElementById('status').value = status
        }

        function enviarFormulario() {

            var resolucao = document.getElementById ('resolucao').value
            var status = document.getElementById ('status').value

            if(!resolucao && status == 'Fechado') {
                alert('Resolução é obrigatória em Casos fechados')
            }
        }

    </script>
</html>
