<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8"/>
    <head>
        <title>Usuário</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_usuario.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    Ocultar senha na edição
    <div class="div-form">
        <h1 id="titulo"></h1>
        <form id="form-usuario" action="/usuario/salvar" method="post">
            <table>
                <tr>
                    <td><label>Nome</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="nome"
                               value="${usuario.dadosPessoais.nome}">
                    </td>
                </tr>
                <tr>
                    <td><label>E-mail</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="email" name="email"
                               value="${usuario.dadosPessoais.email}">
                    </td>
                </tr>
                <tr>
                    <td><label>senha</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" id="senha" type="password" name="senha"
                               value="">
                    </td>
                </tr>
                <tr>
                    <td><label>Confirme a senha</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" id="conf-senha" type="password">
                    </td>
                </tr>
                <tr>
                    <td><label style="margin-top: 15px;">Administrador</label></td>
                    <td>
                        <label class="checkbox">
                            <input id="admin" type="checkbox" name="admin">
                            <span class="checkmark"></span>
                        </label>
                    </td>
                </tr>
                <input type="text" hidden name="id" value="${usuario.id}">
            </table>
        </form>
        <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
        <button onclick="salvar()" class="btn btn-success">Salvar</button>
    </div>
    </body>
    <script>

        if (window.location.href.includes('editar'))
            document.getElementById('titulo').innerText = 'Edição de Usuário'
        else
            document.getElementById('titulo').innerText = 'Cadastro de Usuário'

        function salvar() {
            let form = document.getElementById('form-usuario')
            let senha = document.getElementById('senha').value
            let confFenha = document.getElementById('conf-senha').value

            console.log(senha)
            console.log(confFenha)
            console.log(senha != confFenha)

            if (senha != confFenha)
                alert("Senha não confere")
            else
                form.submit()
        }

        function cancelar() {
            window.history.back()
        }

        if (window.location.href.includes('8080/usuario/cadastro/editar/'))
            if (admin)
                document.getElementById('admin').checked = true


    </script>
</html>