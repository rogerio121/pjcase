<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>View Usuário</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_usuarioView.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <div class="div-table">
            <h1>Usuário ${usuario.id}</h1>
            <form id="usuario-salvo">
                <table>
                    <tr>
                        <td><label>Nome</label></td>
                        <td>
                            <input  class="form-control input-group input-group-sm mb-3" type="text" disabled value="${usuario.dadosPessoais.nome}" >
                        </td>
                    </tr>
                    <tr>
                        <td><label>E-mail</label></td>
                        <td>
                            <input  class="form-control input-group input-group-sm mb-3" type="text" disabled value="${usuario.dadosPessoais.email}" >
                        </td>
                    </tr>
                    <tr>
                        <td><label>Empresa</label></td>
                        <td>
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="idEmpresaRelacionada"
                                   value="${usuario.idEmpresaRelacionada}" disabled>
                        </td>
                    </tr>
                    <tr>
                        <td><label>Administrador</label></td>
                        <td>
                            <label class="checkbox">
                                <input id="admin" type="checkbox" name="admin">
                                <span class="checkmark"></span>
                            </label>
                        </td>
                    </tr>
                </table>
            </form>
            <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
            <button onclick="chamarTelaEditarUsuario(${usuario.id})" class="btn btn-primary">Editar</button>
        </div>
    </body>

    <script>
        if(${usuario.admin})
        document.getElementById('admin').checked = true


        function chamarTelaEditarUsuario(idUsuario) {
            console.log(idUsuario)
            window.location = '/usuario/cadastro/editar/' + idUsuario
        }

        function  cancelar() {
            window.history.back()
        }
    </script>
</html>