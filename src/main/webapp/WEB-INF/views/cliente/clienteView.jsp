<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Cliente</title>
    </head>
    <body>
        <form>
            <label>Nome: </label> ${cliente.dadosPessoais.nome} <br>
            <label>E-mail: </label> ${cliente.dadosPessoais.email} <br>
        </form>
    </body>
</html>
