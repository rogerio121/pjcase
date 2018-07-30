<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Caso</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form action="/caso/salvar" method="POST" id="form-caso">
            <label>Assunto</label> <input type="text" name="assunto" value="${caso.assunto}"> <br>
            <label>Mensagem</label> <textarea rows="5" cols="50" name="mensagem" >${caso.mensagem}</textarea> <br>
            <label>CPF do cliente </label> <input type="text" name="cliente.dadosPessoais.cnpj" required value="${caso.cliente.dadosPessoais.cpf}"> <br>
            <label>Status</label>
            <select name="status" id="status">
                <option value="Aberto" >Aberto</option>
                <option value="Em atendimento" >Em atendimento</option>
                <option value="Fechado">Fechado</option>
            </select>
            <br>
            <label>CNPJ da empresa</label><input type="text" name="empresa.cnpj" required value="${caso.empresa.cnpj}"> <br>
            <label>Resolução</label>
            <textarea rows="5" cols="50" name="resolucao">${caso.resolucao}</textarea>


            <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>

            <button type="submit">Salvar</button>
        </form>
        <div hidden> ${usuarioLogado} <div>
    </body>
    <script>
        pegarStatus()

        function pegarStatus() {
            var status = '${caso.status}'
            document.getElementById('status').value = status
        }
    </script>
</html>
