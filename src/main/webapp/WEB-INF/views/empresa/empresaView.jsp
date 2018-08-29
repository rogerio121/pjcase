<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_empresaView.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css-bootstrap/bootstrap-grid.css">
        <link rel="stylesheet" type="text/css" href="../../resources/css/style_menu.css">
        <title>Empresa</title>
    </head>
    <header>
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <h1>Empresa Cadastrada</h1>
        <div class="container">
            <!--Coluna da esquerda-->
            <div class="row">
                <div class="col-sm">
                    <form>
                        <table>
                            <tr>
                                <td><label>Nome: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" type="text" value="${empresa.nome}" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td><label>CNPJ: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" type="text" value="${empresa.cnpj}" id="cnpj" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Logradouro: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" type="text" value="${empresa.logradouro}" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Bairrro: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" type="text" value="${empresa.bairro}" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Cidade: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" type="text" value="${empresa.cidade}" disabled>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Estado: </label></td>
                                <td>
                                    <input class="form-control input-group input-group-sm mb-3" qtype="text" value="${empresa.estado}" disabled>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <button type="button" class="btn btn-danger" onclick="cancelar()">Cancelar</button>
                    <button class="btn btn-primary" onclick="chamaTelaEditarEmpresa(${empresa.cnpj})">Editar</button>
                </div>

                <!--Coluna da direita-->
                <div class="col-sm form-group">
                    <textarea class="form-control" rows="20" cols="50" name="form-criar-caso" id="form-criar-caso" ></textarea>
                    <button class="btn btn-info form-control" onclick="criarFormDeCriacaoDeCasos(${empresa.cnpj})">Gerar Form</button>
                </div>
            </div>
        </div>
    </body>
    <script>
        function chamaTelaEditarEmpresa(id) {
            window.location = '/empresa/cadastro/editar/' + id
        }

        function mudarCorDeTextboxCasoMudeOResultado() {
            var textArea = document.getElementById('form-criar-caso')
                textArea.style = 'border: 5px solid #C82333;'
        }

        function  cancelar() {
            window.history.back()
        }

        function criarFormDeCriacaoDeCasos(id){
            var form = '<!DOCTYPE html>\n' +
                '<html>\n' +
                '<head>\n' +
                '\t<title></title>\n' +
                '</head>\n' +
                '<body>\n' +
                '    <form action="" method="POST" id="form-caso">\n' +
                '        <label>Assunto</label> <input type="text" name="assunto"> <br>\n' +
                '        <label>Mensagem</label> <textarea rows="5" cols="50" name="mensagem" ></textarea> <br>\n' +
                '        <label>CPF do cliente </label> <input type="text" name="cliente.dadosPessoais.cnpj" required > <br>\n' +
                '        <label>Status</label>\n' +
                '        <select name="status" id="status">\n' +
                '            <option value="Aberto" >Aberto</option>\n' +
                '            <option value="Em atendimento" >Em atendimento</option>\n' +
                '            <option value="Fechado">Fechado</option>\n' +
                '        </select>\n' +
                '        <br>\n' +
                '        <label>CNPJ da empresa</label><input type="text" name="empresa.cnpj" value="'+id+'" required> <br>\n' +
                '        <label>Resolução</label>\n' +
                '        <textarea rows="5" cols="50" id="resolucao" name="resolucao"></textarea>\n' +
                '\n' +
                '        <input type="text" name="idCaso" hidden> <br>\n' +
                '\n' +
                '        <button>Enviar Caso</button>\n' +
                '    </form>\n' +
                '\n' +
                '\n' +
                '</body>\n' +
                '</html>'
            document.getElementById('form-criar-caso').innerHTML = form

            var textArea = document.getElementById('form-criar-caso')
            if (textArea)
                textArea.style = 'border: 5px solid #218838;'
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00");
    </script>
</html>