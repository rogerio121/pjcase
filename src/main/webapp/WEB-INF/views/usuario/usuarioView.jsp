<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
    <title>Usuario</title>
</head>
    <body>
        <form id="usuario-salvo">
            <label>Nome</label> <input type="text" disabled value="${usuario.dadosPessoais.nome}" ><br>
            <label>E-mail</label> <input type="text" disabled value="${usuario.dadosPessoais.email}" ><br>
            <label>Administrador</label> <input id="admin" name="admin" type="checkbox"><br>
        </form>
        <button onclick="chamarTelaEditarUsuario(${usuario.identificacao})">Editar</button>
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