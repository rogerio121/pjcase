<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Casos abertos sem proprietários</title>
    </head>
    <body>
    <form class="form-horizontal" method="post" action="" >

        <fieldset>
            <legend>Produto <span class="nomeProduto">${caso.idCaso}</span></legend>
            <input type="hidden" name="id" value="${caso.idCaso}">
        </fieldset>
    </form>
    </body>
</html>
