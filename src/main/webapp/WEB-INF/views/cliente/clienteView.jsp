<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Cliente</title>
    </head>
    <body>
        <form>
            <label>Nome: </label> ${cliente.dadosPessoais.nome} <br>
            <label>E-mail: </label> ${cliente.dadosPessoais.email} <br>
            <label>CPF: </label> ${cliente.dadosPessoais.cpf} <br>
            <label>Logradouro: </label> ${cliente.dadosPessoais.logradouro} <br>
            <label>Bairrro: </label> ${cliente.dadosPessoais.bairro} <br>
            <label>Cidade: </label> ${cliente.dadosPessoais.cidade} <br>
            <label>Estado: </label> ${cliente.dadosPessoais.estado} <br>
            <label>CEP: </label> ${cliente.dadosPessoais.cep} <br>
        </form>
    </body>
</html>
