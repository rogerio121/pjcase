<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8"/>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_usuario.css">
        <title>Usuário</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
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
                        <input class="form-control input-group input-group-sm mb-3" type="email" name="email" id="email"
                               value="${usuario.dadosPessoais.email}">
                    </td>
                </tr>
                <tr>
                    <td><label>Empresa</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="idEmpresaRelacionada"
                               value="${usuario.idEmpresaRelacionada}">
                    </td>
                </tr>
                <tr>
                    <td><label id="label-senha">senha</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" id="senha" type="password" name="senha"
                               value="">
                    </td>
                </tr>
                <tr>
                    <td><label id="label-conferesenha">Confirme a senha</label></td>
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
        <button onclick="alterarASenha()" class="btn btn-success">Alterar senha</button>
    </div>
    </body>
    <script>

        titulo()
        aoCarregarAPagina()

        function titulo() {
            if (window.location.href.includes('editar'))
                document.getElementById('titulo').innerText = 'Edição de Usuário'
            else
                document.getElementById('titulo').innerText = 'Cadastro de Usuário'
        }

        function salvar() {
            let form = document.getElementById('form-usuario')
            let senha = document.getElementById('senha').value
            let confFenha = document.getElementById('conf-senha').value

            console.log(senha != confFenha)

            if (senha != confFenha)
                alert("Senha não confere")
            else
                form.submit()
        }

        function cancelar() {
            window.history.back()
        }

        function alterarASenha() {
            var email = document.getElementById('email').value
            console.log(email)

            fetch("/usuario/alterarsenha",
                {
                    headers: {
                        'Accept': 'text/plain',
                        'Content-Type': 'text/plain'
                    },
                    method: "POST",
                    body: email
                })
                .then(function (res) {
                    console.log(res.status)
                    if (res.status == '200')
                        alert("Foi enviado um email com um link para a alteração da senha")
                    else
                        alert("Erro ao enviar o email de alteração de senha")
                })
        }

        function aoCarregarAPagina() {
            if (window.location.href.includes('8080/usuario/cadastro/editar/'))
                if (${usuario.admin})
                    document.getElementById('admin').checked = true

            var labelsenha = document.getElementById('label-senha').style.display = "none"
            var senha = document.getElementById('senha').style.display = "none"
            var labelConferirsenha = document.getElementById('label-conferesenha').style.display = "none"
            var conferirSenha = document.getElementById('conf-senha').style.display = "none"

            console.log(senha)
            console.log(conferirSenha)
        }
    </script>
</html>