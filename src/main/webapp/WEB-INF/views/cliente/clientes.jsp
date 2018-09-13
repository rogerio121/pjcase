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
    <script>

        numeroDePaginasDaTabela()
        geraTabelaCasos()

        function geraTabelaCasos() {
            var clientesJson = ${clientesJson}

            for(let i = 0; i < clientesJson.length; i++ ){
                document.getElementById('corpo-tabela').innerHTML += '<tr class="tb-linha">\n' +
                    '                                <td><span class="pointer" onclick="chamaTelaViewCliente('+clientesJson[i].dadosPessoais.cpf+')">'+clientesJson[i].dadosPessoais.nome+'</span></td>\n' +
                    '                                <td>'+clientesJson[i].dadosPessoais.email+'</td>\n' +
                    '                                <td>\n' +
                    '                                    <button onclick="chamaTelaEditarCliente('+clientesJson[i].dadosPessoais.cpf+')">Editar</button>\n' +
                    '                                    <button onclick="chamaExcluirCliente('+clientesJson[i].dadosPessoais.cpf+')">Excluir</button>\n' +
                    '                                </td>\n' +
                    '                            </tr>'
            }
        }


        function numeroDePaginasDaTabela() {
            var clientesJson = ${clientesJson}
            var pagina = 0
            var itensPorPagina = 6

            for(var i = 1; i <=clientesJson.length ; i+=itensPorPagina ) {
                pagina++
                document.getElementById('numero-das-paginas').innerHTML += '<li class="page-item"><a class="page-link " href="#">' + pagina + '</a></li>'
            }
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
                        alert('Erro ao excluir o cliente: ' + id)
                    }
                })
            }
        }
    </script>
    <script src="../../../resources/JavaScript/jquery-ajax.js"></script>
    <script src="../../../resources/JavaScript/jquery-mask.js"></script>
    <script src="../../../resources/JavaScript/bootstrap.min.js"></script>
    <script>
        itensPorPagina = 6

        showPage = function(pagina) {
            $(".tb-linha").hide()
            $(".tb-linha").each(function(linhas) {
                if (linhas >= itensPorPagina * (pagina - 1) && linhas < itensPorPagina * pagina)
                    $(this).show()

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
