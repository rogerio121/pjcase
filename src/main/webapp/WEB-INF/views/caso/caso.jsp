<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_caso.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Caso</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
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
                                   value="${caso.assunto}" required>
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
                        <div class="input-group input-group-sm mb-3 cpf-cnpj">
                            <input type="text" name="cliente.dadosPessoais.cnpj" id="cpf"
                                   class="form-control input-group input-group-sm mb-3" required
                                   value="${caso.cliente.dadosPessoais.cpf}" required>
                            <label class="erro-validar" id="cpfInvalido" style="display: none">CPF inválido !</label>
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
                        <div class="input-group input-group-sm mb-3 cpf-cnpj">
                            <input type="text" name="empresa.cnpj" id="cnpj" class="form-control input-group input-group-sm mb-3"
                                   required value="${caso.empresa.cnpj}"  required>
                            <label class="erro-validar" id="cnpjInvalido" style="display: none">CNPJ inválido !</label>
                        </div>
                    </td>
                <tr>
                    <td><label>Resolução</label></td>
                    <td><textarea rows="3" cols="50" id="resolucao"
                                  class="form-control input-group input-group-sm mb-3"
                                  name="resolucao">${caso.resolucao}</textarea></td>
                </tr>
            </table>
            <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>
        </form>

        <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
        <button onclick="enviarFormulario()" class="btn btn-success">Salvar</button>
        <div hidden> ${usuarioLogado}</div>
    </div>

    </body>


    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/script_geral.js"></script>
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

            let resolucao = document.getElementById ('resolucao').value
            let status = document.getElementById ('status').value
            let cpf = $("#cpf").val()
            let cnpj = $("#cnpj").val()

            if(!resolucao && status == 'Fechado') {
                alert('Resolução é obrigatória em Casos fechados')
            }else{
                console.log(validaCPF(cpf) && validaCNPJ(cnpj));
                if(validaCPF(cpf) && validaCNPJ(cnpj))
                    document.getElementById('form-caso').submit()
                else
                    validaCampoCpfCnpj()
            }
        }

        function validaCampoCpfCnpj(){
            let cpf = $("#cpf").val()
            let cnpj = $("#cnpj").val()


            if (!validaCPF(cpf)) {
                document.getElementById('cpfInvalido').style.display = 'block'
                document.getElementById('cpf').classList.add('erro-campo')
            }

            if (!validaCNPJ(cnpj)) {
                document.getElementById('cnpjInvalido').style.display = 'block'
                document.getElementById('cnpj').classList.add('erro-campo')
            }
        }
    </script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
        $("#cpf").mask("000.000.000-00");
    </script>
</html>
