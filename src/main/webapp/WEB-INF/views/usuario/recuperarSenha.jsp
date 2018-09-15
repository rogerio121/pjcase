<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_recuperarSenha.css">
        <title>Alteração de senha</title>
    </head>
    <body>
     <div>
        <form action="" method="">
            <div class="input-group input-group-sm mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-sm">Email  </span>
                </div>
                <input class="form-control" placeholder="email@email.com"  type="email" id="email" />
            </div>
            <div class="input-group input-group-sm mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-sm">Nova senha  </span>
                </div>
                <input class="form-control" placeholder="password" type="password" id="senha"/>
            </div>
            <div class="input-group input-group-sm mb-3">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-sm">Confere  </span>
                </div>
                <input class="form-control" placeholder="password"  type="password" id="confer"/>
            </div>
        </form>
        <button onclick="enviarFormulario()">Alterar senha</button>
     </div>
    </body>
    <script>
        function enviarFormulario() {
            var email = document.getElementById('email').value
            var senha = document.getElementById('senha').value
            var confere = document.getElementById('confer').value

            console.log(email)
            console.log(senha)
            console.log(confere)

            if (senha != confere)
                alert("Senhas não conferem")

            else {
                fetch("alterar",
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
                        if (res.status == '200')
                            alert("Foi enviado um email com um link para a alteração da senha")
                        else
                            alert("Erro ao enviar o email de alteração de senha")
                        console.log(res)
                    })
            }
        }
    </script>
</html>
