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
            <button onclick="logar()">Logar</button>
        </form>


        <script>
            function logar(){
                alert('y')
                let form = document.getElementById("form-login")

                form.send()


                $.ajax({
                    url:'telainicial',
                    type: 'POST',
                    contentType: 'applicatio/json',
                    data: usuario,
                    success: function(result){
                        window.location.href = url;
                    }
                })
            }
        </script>

    </body>
</html>
