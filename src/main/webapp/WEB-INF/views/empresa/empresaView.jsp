<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <meta charset="UTF-8" />
    <head>
        <link rel="stylesheet" type="text/css" href="../resources/css/style_menu.css">
        <title>Empresa</title>
    </head>
    <header>
        <c:import url="../menu.jsp"></c:import>
    </header>
    <body>
        <form>
            <label>Nome: </label> <input type="text" value="${empresa.nome}" disabled> <br>
            <label>CNPJ: </label> <input type="text" value="${empresa.cnpj}" disabled> <br>
            <label>Logradouro: </label> <input type="text" value="${empresa.logradouro}" disabled> <br>
            <label>Bairrro: </label> <input type="text" value="${empresa.bairro}" disabled> <br>
            <label>Cidade: </label> <input type="text" value="${empresa.cidade}" disabled> <br>
            <label>Estado: </label> <input type="text" value="${empresa.estado}" disabled> <br>
        </form>

        <button onclick="chamaTelaEditarEmpresa(${empresa.cnpj})">Editar</button>
        <button onclick="criarFormDeCriacaoDeCasos(${empresa.cnpj})">Gerar Form</button>

        <textarea rows="10" cols="80" name="form-criar-caso" id="form-criar-caso"></textarea>

    </body>
    <script>
        function chamaTelaEditarEmpresa(id) {
            window.location = '/empresa/cadastro/editar/' + id
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
</html>