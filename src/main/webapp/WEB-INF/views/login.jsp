<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="/logar" method="GET">
            <label>Email</label> <input type="email" name="email"><br>
            <label>Senha</label> <input type="password" name="senha"><br>

            <button type="submit">Logar</button>
        </form>
    </body>
</html>
