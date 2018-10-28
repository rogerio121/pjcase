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
                        <div class="input-group input-group-sm mb-3 cpf-cnpj">
                            <input type="text" name="cliente.dadosPessoais.cnpj" id="cpf"
                                   class="form-control input-group input-group-sm mb-3" required
                                   value="${caso.cliente.dadosPessoais.cpf}" >
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
                                   required value="${caso.empresa.cnpj}">
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

        function  cancelar() {
            window.history.back()
        }

        function enviarFormulario() {

            let resolucao = document.getElementById ('resolucao').value
            let status = document.getElementById ('status').value
            let cpf = $("#cpf").val()
            let cnpj = $("#cnpj").val()

            if(!resolucao && status == 'Fechado') {
                alert('Resolução é obrigatória em Casos fechados')
            }else{
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

        function validaCPF(strCPF) {
            var soma
            var resto
            soma = 0

            let cpf = strCPF.replace(".", "").replace(".", "")
            cpf = cpf.replace("-", "")

            if (cpf == "00000000000")
                return false

            for (i=1; i<=9; i++)
                soma = soma + parseInt(cpf.substring(i-1, i)) * (11 - i)

            resto = (soma * 10) % 11

            if ((resto == 10) || (resto == 11))
                resto = 0

            if (resto != parseInt(cpf.substring(9, 10)) )
                return false

            soma = 0;
            for (i = 1; i <= 10; i++) soma = soma + parseInt(cpf.substring(i-1, i)) * (12 - i)
            resto = (soma * 10) % 11

            if ((resto == 10) || (resto == 11))
                resto = 0

            if (resto != parseInt(cpf.substring(10, 11) ) )
                return false

            return true
        }

        function validaCNPJ(strCNPJ) {

            let cnpj = strCNPJ.replace(".", "").replace(".", "").replace("/", "").replace("-", "")

            // Elimina CNPJs invalidos conhecidos
            if (cnpj == "00000000000000" ||
                cnpj == "11111111111111" ||
                cnpj == "22222222222222" ||
                cnpj == "33333333333333" ||
                cnpj == "44444444444444" ||
                cnpj == "55555555555555" ||
                cnpj == "66666666666666" ||
                cnpj == "77777777777777" ||
                cnpj == "88888888888888" ||
                cnpj == "99999999999999")
                return false;

            // Valida DVs
            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0,tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                return false;

            tamanho = tamanho + 1;
            numeros = cnpj.substring(0,tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                return false;

            return true;
        }

    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
        $("#cpf").mask("000.000.000-00");
    </script>
</html>
