<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Usuario</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    Ocultar senha na edição
        <form id="form-usuario" action="/usuario/salvar" method="post">
            <input type="text" hidden name="id" value="${usuario.id}">
            <label>Nome</label> <input type="text" name="nome" value="${usuario.dadosPessoais.nome}"> <br>
            <label>E-mail</label> <input type="email" name="email" value="${usuario.dadosPessoais.email}"> <br>
            <label>senha</label> <input id="senha" type="password" name="senha" value=""> <br>
            <label>Confirme a senha</label> <input id="conf-senha" type="password" > <br>
            <label>Administrador</label> <input id="admin" type="checkbox" name="admin"> <br>
        </form>

        <button onclick="salvar()">Salvar</button>
    </body>
    <script>

        function salvar() {
            let form = document.getElementById('form-usuario')
            let senha = document.getElementById('senha').value
            let confFenha = document.getElementById('conf-senha').value

            console.log(senha)
            console.log(confFenha)
            console.log(senha != confFenha)

            if(senha != confFenha)
                alert("Senha não confere")
            else
                form.submit()
        }


        if(window.location.href.includes('8080/usuario/cadastro/editar/'))
            if(admin)
                document.getElementById('admin').checked = true




    </script>
</html>