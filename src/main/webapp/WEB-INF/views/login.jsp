<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Login</title>

        <script>
            function x() {
                //alert("Foi")
               fetch("/logar")
                   .then(function (res) {
                       console.log(res)
                   })
            }
        </script>

    </head>
    <body>
        <form action="/logar" method="GET">
            <label>Email</label> <input type="email" name="email"><br>
            <label>Senha</label> <input type="password" name="senha"><br>

        </form>

        <button onclick="x()">Logar</button>
    </body>
</html>
