<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Cliente</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form>
            <label>Nome: </label> <input type="text" value="${cliente.dadosPessoais.nome}" disabled> <br>
            <label>E-mail: </label> <input type="text" value="${cliente.dadosPessoais.email}" disabled> <br>
            <label>CPF: </label> <input type="text" value="${cliente.dadosPessoais.cpf}" disabled> <br>
            <label>Logradouro: </label> <input type="text" value="${cliente.dadosPessoais.logradouro}" disabled> <br>
            <label>Bairrro: </label> <input type="text" value="${cliente.dadosPessoais.bairro}" disabled> <br>
            <label>Cidade: </label> <input type="text" value="${cliente.dadosPessoais.cidade}" disabled> <br>
            <label>Estado: </label> <input type="text" value="${cliente.dadosPessoais.estado}" disabled> <br>
            <label>CEP: </label> <input type="text" value="${cliente.dadosPessoais.cep}" disabled> <br>
        </form>

        <button onclick="editarCliente(${cliente.dadosPessoais.cpf})">Editar</button>
    </body>
    <script>
        function editarCliente(idCliente) {
            window.location = '/cliente/cadastro/editar/' + idCliente
        }
    </script>

</html>
