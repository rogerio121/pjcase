<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Usuario</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    Ocultar senha na edição
        <form action="/usuario/salvar" method="post">
            <label>Id </label> <input type="text" hidden name="id" value="${usuario.id}">
            <label>Nome</label> <input type="text" name="nome" value="${usuario.dadosPessoais.nome}"> <br>
            <label>E-mail</label> <input type="email" name="email" value="${usuario.dadosPessoais.email}"> <br>
            <label>senha</label> <input type="password" name="senha" value=""> <br>
            <label>Administrador</label> <input id="admin" type="checkbox" name="admin" value="${usuario.admin}"> <br>

            <button type="submit">Salvar</button>
        </form>
    </body>
    <script>
        if(${usuario.admin})
            document.getElementById('admin').checked = true

    </script>
</html>