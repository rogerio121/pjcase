<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
    <title>Usuario</title>
</head>
    <body>
        <form id="usuario-salvo">
        </form>
    </body>

    <script>
        var admin = ${usuario.admin}
        console.log(admin)
        document.getElementById('usuario-salvo').innerHTML = '' +
            ' <label>Nome</label> <input type='+'text'+' disabled value='+"${usuario.dadosPessoais.nome}"+' ><br>' +
            '<label>E-mail</label> <input type='+'text'+' disabled value='+"${usuario.dadosPessoais.email}"+' ><br>'
        if(admin)
            document.getElementById('usuario-salvo').innerHTML += '' +
                '<label>Administrador</label> <input name="admin" type="checkbox" checked><br>'
        else
            document.getElementById('usuario-salvo').innerHTML += '' +
                '<label>Administrador</label> <input name="admin" type="checkbox"><br>'

    </script>
</html>