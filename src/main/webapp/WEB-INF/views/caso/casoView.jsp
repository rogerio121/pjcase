<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <title>Caso</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form id="form-caso">
            <label>Assunto</label>
            <input type="text" name="assunto" value="${caso.assunto}" disabled> <br>
            <label>Mensagem</label>
            <textarea rows="5" cols="50" name="mensagem" disabled>${caso.mensagem}</textarea> <br>
            <label>CPF do cliente </label>
            <input type="text" name="cliente.dadosPessoais.cpf" value="${caso.cliente.dadosPessoais.cpf}" disabled> <br>
            <label>Status: </label>
            <input type="text" name="status" value="${caso.status}" disabled> <br>
            <label>CNPJ da empresa</label>
            <input type="text" name="empresa.cnpj" value="${caso.empresa.cnpj}" disabled> <br>
            <label>Resolução</label>
            <textarea rows="5" cols="50" name="resolucao" disabled>${caso.resolucao}</textarea><br>
            <label>Usuario: </label>
            <input type="email" value="${usuario.dadosPessoais.email}" name="usuario.dadosPessoais.email" disabled> <br>
        </form>

        <button onclick="editarCaso(${caso.idCaso})">Editar</button>
    </body>
    <script>

        function editarCaso(idCaso) {
            console.log(idCaso)
            window.location = '/caso/cadastro/editar/'+idCaso
        }
    </script>
</html>
