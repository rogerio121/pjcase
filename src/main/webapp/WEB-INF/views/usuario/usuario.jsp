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
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" type="text" name="nome" value="${usuario.dadosPessoais.nome}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>E-mail</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" type="email" name="email" id="email" value="${usuario.dadosPessoais.email}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CNPJ Empresa</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" type="text" name="idEmpresaRelacionada"
                                   value="${usuario.idEmpresaRelacionada}" id="cnpj">
                            <label class="erro-validar" id="cnpjInvalido" style="display: none">CNPJ inválido !</label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label id="label-senha">senha</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" id="senha" type="password" name="senha" value="">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label id="label-conferesenha">Confirme a senha</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control" id="conf-senha" type="password">
                        </div>
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
        <button id="submit" class="btn btn-success">Salvar</button>
        <button onclick="alterarASenha()" class="btn btn-success" id="alterar-senha">Alterar senha</button>
    </div>
    </body>

    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/script_geral.js"></script>
    <script>

        titulo()
        aoCarregarAPagina()

        document.getElementById("submit").onclick = function(){
            let scnpj = $("#cnpj").val()
            let senha = document.getElementById('senha').value
            let confFenha = document.getElementById('conf-senha').value

            if(validaCNPJ(scnpj)){
                if (senha != confFenha)
                    alert("Senha não confere")

                document.getElementById("form-usuario").submit();
            }else{
                document.getElementById('cnpjInvalido').style.display = 'block'
                document.getElementById('cnpj').classList.add('erro-campo')
            }
        }

        function titulo() {
            if (window.location.href.includes('editar'))
                document.getElementById('titulo').innerText = 'Edição de Usuário'
            else
                document.getElementById('titulo').innerText = 'Cadastro de Usuário'
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
            if (window.location.href.includes('8080/usuario/cadastro/editar/')){
                let usuarioAdm = '${usuario.admin}'

                if(usuarioAdm == 'true')
                    document.getElementById('admin').checked = true

                var labelsenha = document.getElementById('label-senha').style.display = "none"
                var senha = document.getElementById('senha').style.display = "none"
                var labelConferirsenha = document.getElementById('label-conferesenha').style.display = "none"
                var conferirSenha = document.getElementById('conf-senha').style.display = "none"
                var alterarSenha = document.getElementById('alterar-senha').style.display = "block"
            }else{
                var alterarSenha = document.getElementById('alterar-senha').style.display = "none"
            }
        }
    </script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
    </script>
</html>