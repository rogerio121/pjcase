<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="/telainicial" method="post" id="form-login">
            <label>Email</label> <input type="email" name="email" required><br>
            <label>Senha</label> <input type="password" name="senha" required><br>

            <button onclick="x()">Logar</button>s
        </form>


        <script>
            function x() {
                let email = document.getElementsByName('email')[0].value
                let senha = document.getElementsByName('senha')[0].value
                let telaLogin = window.location

                if (!email || !senha)
                    alert("Favor preencher os campos E-mail e Senha")

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

        </script>

    </body>
</html>
