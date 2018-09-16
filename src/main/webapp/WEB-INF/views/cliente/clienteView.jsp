<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_clienteView.css">
        <title>Cliente</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
        <div class="div-form" id="div-form">
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
                    <td><label>Telefone</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="telefone" name="telefone" id="telefone"
                                   value="${cliente.dadosPessoais.telefone}" disabled>
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
        <div id="erro">
            <div class="card">
                <div class="card-header">
                    Erro
                </div>
                <div class="card-body">
                    Aconteceu um erro ao salvar o registro
                </div>
            </div>
            <button type="button" class="btn btn-danger" href="/telaInicial">Voltar ao início</button>
        </div>

    </body>
    <script>
        verificarErros()

        function editarCliente(idCliente) {
            window.location = '/cliente/cadastro/editar/' + idCliente
        }
        
        function  cancelar() {
            window.history.back()
        }

        function verificarErros() {
            var response = '${response}'
            if(response){
                document.getElementById('div-form').style.display = "none";
                document.getElementById('erro').style.display = "block";
            }
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cpf").mask("000.000.000-00");
        $("#telefone").mask("(00) 0000-0000");
    </script>
</html>
