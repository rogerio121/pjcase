<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
    <title>Usuario</title>
</head>
    <body>
        <form action="/usuario/salvar" method="post">
            <label>Nome</label> ${usuario.dadosPessoais.nome} <br>
            <label>E-mail</label> ${usuario.dadosPessoais.email} <br>
        </form>
    </body>
</html>