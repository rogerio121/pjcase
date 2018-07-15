<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Caso</title>
    </head>
    <body>
        <form>
            <label>Assunto: </label> ${caso.assunto} <br>
            <label>Menssagem: </label> ${caso.menssagem} <br>
            <label>CPF do cliente: </label> ${caso.idClienteRelacionado} <br>
            <label>Status: </label> ${caso.status} <br>
            <label>CNPJ da Empresa: </label> ${caso.idEmpresaRelacionada} <br>
            <label>Usuario: </label> ${caso.idUsuarioRelacionado} <br>
        </form>
    </body>
</html>
