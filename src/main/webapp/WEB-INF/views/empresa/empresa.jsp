<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8"/>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_empresa.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
        <title>Empresa</title>
    </head>
    <header>
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
    <div class="div-form">
        <h1 id="titulo"></h1>
        <form action="/empresa/salvar" method="post">
            <table>
                <tr>
                    <td><label>Nome</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="nome"
                               value="${empresa.nome}">
                    </td>
                </tr>
                <tr>
                    <td><label>CNPJ</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="cnpj" id="cnpj"
                               value="${empresa.cnpj}">
                    </td>
                </tr>
                <tr>
                    <td><label>Logradouro</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="logradouro"
                               value="${empresa.logradouro}">
                    </td>
                </tr>
                <tr>
                    <td><label>Bairrro</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="bairro"
                               value="${empresa.bairro}">
                    </td>
                </tr>
                <tr>
                    <td><label>Cidade</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="cidade"
                               value="${empresa.cidade}">
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
                    <td><label>CEP</label></td>
                    <td>
                        <input class="form-control input-group input-group-sm mb-3" type="text" name="cep"
                               value="${empresa.cep}">
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
            document.getElementById('titulo').innerText = 'Edição de Empresa'
        else
            document.getElementById('titulo').innerText = 'Cadastro de Empresa'

        function  cancelar() {
            window.history.back()
        }

        function pegarEstado() {
            var estado = '${empresa.estado}'
            document.getElementById('estado').value = estado
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
    </script>
</html>