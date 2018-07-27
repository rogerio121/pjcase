<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/style_menu.css">
        <title>Empresa</title>
    </head>
    <header>
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form>
            <label>Nome: </label> <input type="text" value="${empresa.nome}" disabled> <br>
            <label>CNPJ: </label> <input type="text" value="${empresa.cnpj}" disabled> <br>
            <label>Logradouro: </label> <input type="text" value="${empresa.logradouro}" disabled> <br>
            <label>Bairrro: </label> <input type="text" value="${empresa.bairro}" disabled> <br>
            <label>Cidade: </label> <input type="text" value="${empresa.cidade}" disabled> <br>
            <label>Estado: </label> <input type="text" value="${empresa.estado}" disabled> <br>
        </form>

        <button onclick="chamaTelaEditarEmpresa(${empresa.cnpj})">Editar</button>
    </body>
    <script>
        function chamaTelaEditarEmpresa(idEmpresa) {
            window.location = '/empresa/cadastro/editar/' + idEmpresa
        }
    </script>
</html>