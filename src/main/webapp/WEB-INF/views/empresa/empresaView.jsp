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
                    <button class="btn btn-info" onclick="criarFormDeCriacaoDeCasos(${empresa.cnpj})" data-toggle="modal" data-target=".bd-example-modal-lg">Gerar Form</button>
                    <button class="btn btn-primary" onclick="chamaTelaEditarEmpresa(${empresa.cnpj})">Editar</button>
                </div>

                <!--Coluna da direita-->
                <div class="col-sm form-group">
                    <div class="col-sm">
                        <h5>Clientes da empresa ${empresa.nome}</h5>
                        <table class="clientes tabela table table-hover" id="tb-clientes">
                            <tr>
                                <th>Nome</th>
                                <th>CPF</th>
                            </tr>
                            <tbody id="corpo-tabela">
                            </tbody>
                        </table>
                        <ol id="numero-das-paginas">
                            <li><a class="current" href="#">1</a></li>
                            <li><a href="#">2</a></li>
                            <li><a href="#">3</a></li>
                            <li><a href="#">4</a></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Copie e cole o código abaxio na página web</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <textarea class="form-control" rows="20" cols="50" name="form-criar-caso" id="form-criar-caso" >
                        Erro ao gerar Form!
                    </textarea>
                </div>
            </div>
        </div>
    </body>
    <script>
        geraTabelaClientes()

        function geraTabelaClientes() {
            var clientes = ${clientesDaEmpresaJson}

                for(let i = 0; i < clientes.length; i++ ){
                    console.log(clientes[i])
                    document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha"><td>'+clientes[i].dadosPessoais.nome+'</td> ' +
                        '<td>'+clientes[i].dadosPessoais.cpf+'</td></tr>'
                }
        }
        function chamaTelaEditarEmpresa(id) {
            window.location = '/empresa/cadastro/editar/' + id
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
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>
        $("#cnpj").mask("00.000.000/0000-00")

        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').trigger('focus')
        })

        itensPorPagina = 1

        showPage = function(pagina) {
            $(".tb-linha").hide();
            $(".tb-linha").each(function(linhas) {
                if (linhas >= itensPorPagina * (pagina - 1) && linhas < itensPorPagina * pagina)
                    $(this).show();
            })
        }

        //O numero 1 é a página de inicio
        showPage(1);

        //PEga o Numero da página corrente e passa para o método showPage
        $("#numero-das-paginas li a").click(function() {
            $("#numero-das-paginas li a").removeClass("current");
            $(this).addClass("current");
            showPage(parseInt($(this).text()))
        });

    </script>
</html>