<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Usuarios Cadastrados</title>
    </head>
    <header>
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>

        <table id="tb-casos">
            <tr>
                <th>Nome</th>
                <th>Email</th>
                <th>Empresa</th>
            </tr>
            <c:if test="${not empty usuarios}">
                <c:forEach items="${usuarios}" var="usuario">
                    <tr>
                        <td onclick="chamaTelaEditarUsuariio('${usuario.dadosPessoais.email}')">${usuario.dadosPessoais.nome}</td>
                        <td>${usuario.dadosPessoais.email}</td>
                        <td>${usuario.idEmpresaRelacionada}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </body>
    <script>
        function chamaTelaEditarUsuariio(idUsuario) {
            window.location = '/usuario/cadastro/' + idUsuario
        }
    </script>
</html>
