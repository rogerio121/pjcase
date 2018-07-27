<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Usuario</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form id="usuario-salvo">
            <label>Id </label> <input type="text" disabled name="id" value="${usuario.id}">
            <label>Nome</label> <input type="text" disabled value="${usuario.dadosPessoais.nome}" ><br>
            <label>E-mail</label> <input type="text" disabled value="${usuario.dadosPessoais.email}" ><br>
            <label>Administrador</label> <input id="admin" name="admin" type="checkbox"><br>
        </form>
        <button onclick="chamarTelaEditarUsuario(${usuario.id})">Editar</button>
    </body>

    <script>
        if(${usuario.admin})
        document.getElementById('admin').checked = true


        function chamarTelaEditarUsuario(idUsuario) {
            console.log(idUsuario)
            window.location = '/usuario/cadastro/editar/' + idUsuario
        }
    </script>
</html>