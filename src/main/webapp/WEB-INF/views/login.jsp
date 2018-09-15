<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../resources/css/style_login.css">
        <title>Login</title>
    </head>
    <body>
        <div id="login">
            <h1>Login</h1>
            <form action="/logar" method="post" id="form-login">
                <div>
                    <input class="form-control input-group" type="email" name="email" required>
                    <label>Email</label>
                </div>
                <div>
                    <input class="form-control input-group" type="password" name="senha" required>
                    <label>Senha</label>
                </div>
                <button class="btn btn-primary" onclick="x()">Logar</button>
            </form>
        </div>

        <script>
            function x() {
                let email = document.getElementsByName('email')[0].value
                let senha = document.getElementsByName('senha')[0].value
                let telaLogin = window.location

                if (!email || !senha)
                    alert("Favor preencher os campos E-mail e Senha")

                else{
                    fetch("/validarusuario",
                        {
                            headers: {
                                'Accept': 'application/json',
                                'Content-Type': 'application/json'
                            },
                            method: "POST",
                            body: JSON.stringify({
                                senha: senha,
                                dadosPessoais: {
                                    email: email
                                }
                            })
                        })
                        .then(function (res) {
                            console.log(res.status)
                            if (res.status == 204) {
                                alert("Login inválido!")
                                window.location = telaLogin;
                            }
                        })
                }
            }

        </script>

    </body>
</html>
