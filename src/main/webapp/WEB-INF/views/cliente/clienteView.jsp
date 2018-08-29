<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <title>Cliente</title>
    </head>
    <header>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_clienteView.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <div class="div-form">
            <h1>Cliente Cadastrado</h1>
            <form>
            <table>
                <tr>
                    <td><label>Nome</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.nome}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>E-mail</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.email}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CPF: </label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.cpf}" id="cpf" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Logradouro</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.logradouro}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Bairrro</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.bairro}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Cidade</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.cidade}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Estado</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.estado}" disabled>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CEP</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text"
                                   value="${cliente.dadosPessoais.cep}" disabled>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
            <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
            <button  class="btn btn-primary" onclick="editarCliente(${cliente.dadosPessoais.cpf})">Editar</button>
        </div>
    </body>
    <script>
        function editarCliente(idCliente) {
            window.location = '/cliente/cadastro/editar/' + idCliente
        }
        
        function  cancelar() {
            window.history.back()
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cpf").mask("000.000.000-00");
    </script>
</html>
