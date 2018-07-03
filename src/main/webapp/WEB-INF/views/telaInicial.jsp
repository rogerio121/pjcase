<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Tela inicial</title>
    </head>
    <body>
    <h3>Bem vindo ${usuarioLogado.dadosPessoais.nome}</h3>

    <div>
        <a href="/caso/cadastro">Caso</a>
        <a href="/empresa/cadastro">Empresa</a>
        <a href="/cliente/cadastro">Cliente</a>
        <a href="">Sair</a>

    </div>

    </body>
</html>
