<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8" />
<head>
    <title>Empresa</title>
</head>
    <body>
        <form>
            <label>Nome: </label> ${empresa.nome} <br>
            <label>CNPJ: </label> ${empresa.cnpj} <br>
            <label>Logradouro: </label> ${empresa.logradouro} <br>
            <label>Bairrro: </label> ${empresa.bairro} <br>
            <label>Cidade: </label> ${empresa.cidade} <br>
            <label>Estado: </label> ${empresa.estado} <br>
        </form>
    </body>
</html>