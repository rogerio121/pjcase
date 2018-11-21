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
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" type="text" value="${empresa.nome}" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>CNPJ: </label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control cnpj" type="text" value="${empresa.cnpj}" id="cnpj" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Logradouro: </label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" type="text" value="${empresa.logradouro}" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Bairro: </label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" type="text" value="${empresa.bairro}" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Cidade: </label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" type="text" value="${empresa.cidade}" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>Estado: </label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" qtype="text" value="${empresa.estado}" disabled>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td><label>CEP</label></td>
                                <td>
                                    <div class="input-group input-group-sm mb-3">
                                        <input class="form-control" type="text" name="cep" id="cep" value="${empresa.cep}"disabled>
                                    </div>
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
                        <div>
                            <div class="input-group input-group-sm mb-3">
                                <div class="input-group-prepend">
                                    <button onclick="adicionarCliente()" class="btn btn-outline-secondary" type="button" id="button-addon1">Adicionar cliente</button>
                                </div>
                                <input name="cpfCliente" id="cpfCliente" placeholder="CPF do cliente" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
                                <input name="idEmpresa" id="idEmpresa" hidden value="${empresa.cnpj}">
                            </div>
                        </div>

                        <table class="clientes tabela table table-hover" id="tb-clientes">
                            <tr>
                                <th>Nome</th>
                                <th>CPF</th>
                                <th></th>
                            </tr>
                            <tbody id="corpo-tabela">
                            </tbody>
                        </table>
                        <nav aria-label="...">
                            <ul id="numero-das-paginas" class="pagination">
                            </ul>
                        </nav>
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

        numeroDePaginasDaTabela()
        geraTabelaClientes()

        function geraTabelaClientes() {
            var clientes = ${clientesDaEmpresaJson}

                for(let i = 0; i < clientes.length; i++ ){
                    document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha"><td>'+clientes[i].dadosPessoais.nome+'</td> ' +
                        '<td>'+clientes[i].dadosPessoais.cpf+'</td> <td> <i class="fas fa-trash-alt" onclick="removerCliente(\'+clientes[i].dadosPessoais.cpf+\')"></i></td></tr>'
                }
        }

        function numeroDePaginasDaTabela() {
            var clientes = ${clientesDaEmpresaJson}
            var pagina = 0
            var itensPorPagina = 4

            for(var i = 1; i <=clientes.length ; i+=itensPorPagina ) {
                pagina++
                if(pagina > 1){
                    pagina++
                    document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
                }
                if (pagina < 2)
                    document.getElementById('numero-das-paginas').innerHTML = ""
            }

        }

        function chamaTelaEditarEmpresa(id) {
            window.location = '/empresa/cadastro/editar/' + id
        }

        function  cancelar() {
            window.history.back()
        }

        function adicionarCliente() {
            var cpfCliente = document.getElementById('cpfCliente').value
            var idEmpresa  = document.getElementById('idEmpresa').value

            console.log(cpfCliente)
            console.log(idEmpresa)

            fetch("../../clienteempresa/vincular",
                {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: "POST",
                    body: JSON.stringify({
                        cpfCliente: cpfCliente,
                        idEmpresa: idEmpresa
                    })
                })
                .then(function (res) {
                    console.log(res)
                    console.log(res.status)
                    if (res.status != 200) {
                        alert("Erro ao inserir cliente!")
                    }else {
                        alert("Cliente vinculado")
                        window.location.reload()
                    }
                })

        }

        function removerCliente(id){

            console.log(id)
            fetch("../../clienteempresa/"+id,
                {
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    },
                    method: "DELETE",
                }).then(function (res) {
                    console.log(res)
                    console.log(res.status)
                    if (res.status != 200) {
                        alert("Erro ao desvincular cliente!")
                    }else {
                        alert("Cliente desvinculado")
                        window.location.reload()
                    }
                })
        }

        function criarFormDeCriacaoDeCasos(id){
            var form = '<!DOCTYPE html>\n' +
                '<html>\n' +
                '<head>\n' +
                '<meta charset="UTF-8" />\n' +
                '\t<title></title>\n' +
                '</head>\n' +
                '<body>\n' +
                '    <form action="http://localhost:8080/caso/salvar-post" method="POST" id="form-caso">\n' +
                '        <label>Assunto</label> <input type="text" name="assunto"> <br>\n' +
                '        <label>Mensagem</label> <textarea rows="5" cols="50" name="mensagem" ></textarea> <br>\n' +
                '        <label>CPF do cliente </label> <input type="text" name="cliente.dadosPessoais.cnpj" required > <br>\n' +
                '        <input type="text" name="empresa.cnpj" value="'+id+'" required hidden> <br>\n' +
                '        <input type="text" name="idCaso" hidden> <br>\n' +
                '        <button>Enviar Caso</button>\n' +
                '    </form>\n' +
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
        $("#cep").mask("00000-000")

        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').trigger('focus')
        })

        itensPorPagina = 4

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
        $("#numero-das-paginasumero-das-paginas li a").click(function() {
            $("#numero-das-paginas li a").removeClass("current");
            $(this).addClass("current");
            showPage(parseInt($(this).text()))
        });

    </script>
</html>
