<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Caso</title>
    </head>
    <body>

        <form action="/caso/salvar"method="post">
            <label>Assunto</label> <input type="text" name="assunto"> <br>
            <label>Menssagem</label> <input type="text" name="menssagem"> <br>
            <label>Email do cliente</label> <input type="email" name="idClienteRelacionado" required> <br>
            <label>Status</label>
            <select name="status">
                <option value="Aberto" >Aberto</option>
                <option value="Em atendimento" >Em atendimento</option>
                <option value="Fechado">Fechado</option>
            </select>
            <br>
            <label>Empresa</label><input type="text" name="idEmpresaRelacionada" required> <br>
            <input type="email" value="${usuarioLogado.dadosPessoais.email}" name="idUsuarioRelacionado" hidden> <br>

            <button type="submit">Salvar</button>
        </form>
    </body>
</html>
