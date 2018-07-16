<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Caso</title>
    </head>
    <body>
        <form action="/caso/salvar" method="POST">
            <label>Assunto</label> <input type="text" name="assunto" value="${caso.assunto}"> <br>
            <label>Mensagem</label> <input type="text" name="mensagem" value="${caso.mensagem}"> <br>
            <label>CPF do cliente </label> <input type="text" name="idClienteRelacionado" required value="${caso.idClienteRelacionado}"> <br>
            <label>Status</label>
            <select name="status" id="status">
                <option value="Aberto" >Aberto</option>
                <option value="Em atendimento" >Em atendimento</option>
                <option value="Fechado">Fechado</option>
            </select>
            <br>
            <label>CNPJ da empresa</label><input type="text" name="idEmpresaRelacionada" required value="${caso.idEmpresaRelacionada}"> <br>
            <input type="email" value="${usuarioLogado.dadosPessoais.email}" name="idUsuarioRelacionado" hidden> <br>
            <input type="text" value="${caso.idCaso}" name="idCaso" hidden> <br>

            <button type="submit">Salvar</button>
        </form>
    </body>
    <script>
        pegarStatus()

        function pegarStatus() {
            var status = '${caso.status}'
            document.getElementById('status').value = status
        }
    </script>
</html>
