<div id="menu" >
    <a href="/caso/cadastro">Cadastrar Caso</a>
    <a href="/caso/meuscasos">Meus Casos</a>
    <a href="/cliente/cadastro">Cadastrar Cliente</a>
    <a href="/cliente/clientes">Clientes</a>
</div>

<script>
    function funcoesDeAdminNoMenu() {
        var admin = ${usuarioLogado.admin}

        if(admin)
            document.getElementById('menu').innerHTML += '<a href="/empresa/cadastro">Cadastrar Empresa</a><a href="/empresa/empresas">Empresas</a> <a href="/logout">Sair</a>'
        else
            document.getElementById('menu').innerHTML += '<a href="/logout">Sair</a>'
    }
</script>

