<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Cliente</title>
    </head>
    <body>
        <form action="/cliente/salvar" method="post">
            <label>Nome</label> <input type="text" name="nome"> <br>
            <label>E-mail</label> <input type="email" name="email"> <br>

            <button type="submit">Salvar</button>
        </form>
    </body>
</html>
