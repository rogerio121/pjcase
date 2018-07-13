<div id="menu" >
    <a href="/caso/cadastro">Caso</a>
    <a href="/caso/meuscasos">Meus Casos</a>
    <a href="/cliente/cadastro">Cliente</a>
    <a href="/cliente/clientes">Clientes</a>
    <a href="/empresa/cadastro">Empresa</a>
</div>

<script>
    function funcoesDeAdminNoMenu() {
        var admin = ${usuarioLogado.admin}

        if(admin)
            document.getElementById('menu').innerHTML += '<a href="/empresa/empresas">Empresas</a> <a href="/logout">Sair</a>'
        else
            document.getElementById('menu').innerHTML += '<a href="/logout">Sair</a>'
    }
</script>

