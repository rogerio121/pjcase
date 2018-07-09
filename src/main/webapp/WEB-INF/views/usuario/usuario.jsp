<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Usuario</title>
    </head>
    <body>
        <form action="/usuario/salvar" method="post">
            <label>Nome</label> <input type="text" name="nome"> <br>
            <label>E-mail</label> <input type="email" name="email"> <br>
            <label>senha</label> <input type="password" name="senha"> <br>

            <button type="submit">Salvar</button>
        </form>
    </body>
</html>