<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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