<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8"/>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_cliente.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Cliente</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
    <div class="div-form">
        <h1 id="titulo"></h1>
        <form action="/cliente/salvar" method="post">
            <table >
                <tr>
                    <td><label>Nome</label></td>
                    <td>
                        <div class="input-group in  put-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="nome"
                                   value="${cliente.dadosPessoais.nome}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>E-mail</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="email" name="email"
                                   value="${cliente.dadosPessoais.email}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Telefone</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="telefone" name="telefone" id="telefone"
                                   value="${cliente.dadosPessoais.telefone}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CPF</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="cpf" id="cpf"
                                   value="${cliente.dadosPessoais.cpf}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Logradouro</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="logradouro"
                                   value="${cliente.dadosPessoais.logradouro}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Bairrro</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="bairro"
                                   value="${cliente.dadosPessoais.bairro}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Cidade</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="cidade"
                                   value="${cliente.dadosPessoais.cidade}">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>Estado</label></td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <select id="estado" name="estado">
                                <option selected="" value="">Selecione o Estado</option>
                                <option value="Acre">Acre</option>
                                <option value="Alagoas">Alagoas</option>
                                <option value="Amapá">Amapá</option>
                                <option value="Amazonas">Amazonas</option>
                                <option value="Bahia">Bahia</option>
                                <option value="Ceará">Ceará</option>
                                <option value="Distrito Federal">Distrito Federal</option>
                                <option value="Espírito Santo">Espírito Santo</option>
                                <option value="Goiás">Goiás</option>
                                <option value="Maranhão">Maranhão</option>
                                <option value="Mato Grosso">Mato Grosso</option>
                                <option value="Mato Grosso do Sul">Mato Grosso do Sul</option>
                                <option value="Minas Gerais">Minas Gerais</option>
                                <option value="Pará">Pará</option>
                                <option value="Paraíba">Paraíba</option>
                                <option value="Paraná">Paraná</option>
                                <option value="Pernambuco">Pernambuco</option>
                                <option value="Piauí">Piauí</option>
                                <option value="Rio de Janeiro">Rio de Janeiro</option>
                                <option value="Rio Grande do Sul">Rio Grande do Sul</option>
                                <option value="Rio Grande do Norte">Rio Grande do Norte</option>
                                <option value="Rondônia">Rondônia</option>
                                <option value="Roraima">Roraima</option>
                                <option value="Santa Catarina">Santa Catarina</option>
                                <option value="São Paulo">São Paulo</option>
                                <option value="Sergipe">Sergipe</option>
                                <option value="Tocantins">Tocantins</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td><label>CEP</label</td>
                    <td>
                        <div class="input-group input-group-sm mb-3">
                            <input class="form-control input-group input-group-sm mb-3" type="text" name="cep"
                                   value="${cliente.dadosPessoais.cep}">
                        </div>
                    </td>
                </tr>
            </table>
            <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
            <button type="submit" class="btn btn-success">Salvar</button>
        </form>
    </div>
    </body>
    <script>
        pegarEstado()

        if (window.location.href.includes('editar'))
            document.getElementById('titulo').innerText = 'Edição de Cliente'
        else
            document.getElementById('titulo').innerText = 'Cadastro de Cliente'

        function  cancelar() {
            window.history.back()
        }

        function pegarStatus() {
            var status = '${caso.status}'
            if (status)
                document.getElementById('status').value = status
        }

        function pegarEstado() {
            var estado = '${cliente.dadosPessoais.estado}'
            document.getElementById('estado').value = estado
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cpf").mask("000.000.000-00");
        $("#telefone").mask("(00) 0000-0000");
    </script>
</html>
