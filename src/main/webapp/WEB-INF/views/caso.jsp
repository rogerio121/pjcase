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
        <label>Status</label> <input type="text" name="status"> <br>
        <label>Empresa</label><input type="text" name="idEmpresaRelacionada" required> <br>
        <label>Usuário</label><input type="email" name="idUsuarioRelacionado"> <br>

        <button type="submit">Salvar</button>
    </form>
    </body>
</html>
