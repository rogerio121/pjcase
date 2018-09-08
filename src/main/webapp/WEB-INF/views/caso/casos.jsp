<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_geral.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap.css">
        <link rel="stylesheet" type="text/css" href="../resources/css-bootstrap/bootstrap-grid.css">
        <title>Casos do(a) ${usuarioLogado.dadosPessoais.nome}</title>
    </head>
    <header>
        <jsp:include page="../menu.jsp"></jsp:include>
    </header>
    <body>
    <div class="container">
        <div class="row">
            <div class="col-sm">
                <h1 id="titulo"></h1>
                <div class="input-group input-group-sm mb-3">
                    <div class="input-group-prepend">
                        <label class="input-group-text" for="inputGroupSelect01">Só ver casos que o status
                            seja: </label>
                    </div>
                    <select name="status" id="status" onclick="filtrarCasos()" id="inputGroupSelect01">
                        <option value="">Todos os Casos</option>
                        <option value="Aberto">Casos em aberto</option>
                        <option value="Em atendimento">Casos em atendimento</option>
                        <option value="Fechado">Casos fechado</option>
                    </select>
                </div>

                <table id="tb-casos" class="tabela table table-hover">
                    <tr>
                        <th>Id</th>
                        <th>Assunto</th>
                        <th>Status</th>
                        <th>Data de Abertura</th>
                        <th>Data de Fechamento</th>
                    </tr>
                    <c:if test="${not empty casos}">
                        <c:forEach items="${casos}" var="caso">
                            <tr>
                                <td><span class="pointer" onclick="chamaTelaViewCaso(${caso.idCaso})">${caso.idCaso}</span></td>
                                <td>${caso.assunto}</td>
                                <td>${caso.status}</td>
                                <td>${caso.dataDeAbertura}</td>
                                <td>${caso.dataDeFechamento}</td>
                                <td>
                                    <button onclick="chamaTelaEditarCaso(${caso.idCaso})">Editar</button>
                                    <button onclick="chamaExcluirCaso(${caso.idCaso})">Excluir</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
            </div>
        </div>
    </body>
    <script>


        if(window.location.href.includes('todososcasos'))
            document.getElementById('titulo').innerText = 'Todos os Casos'
        else if(window.location.href.includes('meuscasos'))
            document.getElementById('titulo').innerText = 'Meus Casos'

        function chamaTelaViewCaso(id) {
            window.location = '/caso/cadastro/' + id
        }

        function chamaTelaEditarCaso(id) {
            window.location = '/caso/cadastro/editar/' + id
        }

        function chamaExcluirCaso(id) {
            var realmenteQuerExcluir
            realmenteQuerExcluir = confirm('Deseja realmente excluir o caso ?')

            if (realmenteQuerExcluir) {
                fetch('/caso/cadastro/' + id,
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
                        alert('Erro ao excluir o caso: ' + id)
                    }
                })
            }
        }


        function filtrarCasos() {
            var filtro, tabela, linhas, coluna

            filtro = document.getElementById('status').value
            tabela = document.getElementById('tb-casos')
            linhas = tabela.getElementsByTagName('tr')

            for(i = 0; i < linhas.length; i++){
                coluna = linhas[i].getElementsByTagName('td')[2]
                if (coluna){
                    if (coluna.innerHTML.indexOf(filtro) > -1)
                        linhas[i].style.display = ''
                    else
                        linhas[i].style.display = 'none'
                }
            }
        }
    </script>

</html>
