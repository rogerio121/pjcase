<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../../../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../../../resources/css-bootstrap/bootstrap-grid.css">
        <title>Clientes</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
    <div class="container">
        <div class="row">
            <div class="col-sm">

                <h1>Clientes cadastrados</h1>
                <input type="search" id="filtro" class="form-control input-group input-group-sm mb-3" placeholder="Filtrar clientes por nome" onkeyup="geraTabelaClientes()"/>
                <table class="tabela table table-hover">
                    <tr>
                        <th>Nome</th>
                        <th>Email</th>
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
    </body>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>

        numeroDePaginasDaTabela(${clientesJson})
        geraTabelaClientes()
        paginacao()
        funcoesDeAdminNoMenu()


        function geraTabelaClientes(){
            var clientesJson = ${clientesJson}
            var clientesJsonFiltrados = new Array();
            var filtro = document.getElementById('filtro').value.toUpperCase()
            document.getElementById('corpo-tabela').innerHTML = ""


            for(let i = 0; i < clientesJson.length; i++ ){
                if(clientesJson[i].dadosPessoais.nome.toUpperCase().indexOf(filtro) == 0){
                    clientesJsonFiltrados.push(clientesJson[i])
                    document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                        '                                <td><span class="pointer" onclick="chamaTelaViewCliente('+clientesJson[i].dadosPessoais.cpf+')">'+clientesJson[i].dadosPessoais.nome+'</span></td>\n' +
                        '                                <td>'+clientesJson[i].dadosPessoais.email+'</td>\n' +
                        '                                <td>\n' +
                        '                                    <button class="btn btn-primary" onclick="chamaTelaEditarCliente('+clientesJson[i].dadosPessoais.cpf+')"> <i class="fas fa-pencil-alt"></i> Editar</button>\n' +
                        '                                    <button class="btn btn-danger adm" onclick="chamaExcluirCliente('+clientesJson[i].dadosPessoais.cpf+')"> <i class="fas fa-trash-alt"></i> Excluir</button>\n' +
                        '                                </td>\n' +
                        '                            </tr>'
                }
            }
            numeroDePaginasDaTabela(clientesJsonFiltrados)
            paginacao()
        }

        function numeroDePaginasDaTabela(clientesJson) {
            var pagina = 0
            var itensPorPagina = 4

            document.getElementById('numero-das-paginas').innerHTML = ""
            for(var i = 1; i <=clientesJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }

            if (pagina < 2)
                document.getElementById('numero-das-paginas').innerHTML = ""
        }
        
        function chamaTelaViewCliente(id) {
            window.location = '/cliente/cadastro/' + id
        }

        function chamaTelaEditarCliente(id) {
            window.location = '/cliente/cadastro/editar/' + id
        }

        function chamaExcluirCliente(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir o cliente ?')

            if (realmenteQuerExcluir) {
                fetch('/cliente/cadastro/' + id,
                    {
                        headers: {
                            'Accept': 'application/json',
                            'Content-Type': 'String'
                        },
                        method: "DELETE",
                    }).then(function (res) {
                    if (res.status == 200) {
                        var pagina = window.location.href;
                        window.location = pagina;
                    } else {
                        alert('Erro ao excluir o cliente: ' + id + '\n Verifique se ele está vinculado a alguma Empresa')
                    }
                })
            }
        }

        function paginacao() {
            itensPorPagina = 4

            showPage = function (pagina) {
                $(".tb-linha").hide()
                $(".tb-linha").each(function (linhas) {
                    if (linhas >= itensPorPagina * (pagina - 1) && linhas < itensPorPagina * pagina)
                        $(this).show()
                })
            }

            //O numero 1 é a página de inicio
            showPage(1);

            //PEga o Numero da página corrente e passa para o método showPage
            $("#numero-das-paginas li a").click(function () {
                $("#numero-das-paginas li a").removeClass("current");
                $(this).addClass("current");
                showPage(parseInt($(this).text()))
            });
        }

        function funcoesDeAdminNoMenu() {
            var admin = ${usuarioLogado.admin}

            if(!admin) {
                numeroDeItens = document.getElementsByClassName('adm').length

                for (i = 0; i < numeroDeItens; i++) {
                    document.getElementsByClassName('adm')[i].style.display = "none"
                }
            }
        }
    </script>
</html>
