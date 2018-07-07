<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Login</title>
    </head>
    <body>
        <form action="/logar" method="post">
            <label>Email</label> <input type="email" name="email" required><br>
            <label>Senha</label> <input type="password" name="senha" required><br>

            <button type="submit" onclick="x()">Logar</button>
        </form>


        <script>
            function x() {
                //  alert("func")
                fetch("/logar2",
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'application/json'
                        },
                        method: "POST",
                        body: JSON.stringify({email: 'rogeio@json.com', senha: '132456'})
                    })
                    .then(function (res) {
                        console.log(res);
                    })
            }
        </script>

    </body>
</html>
