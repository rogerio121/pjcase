<!--div id="menu" >
    <a href="/caso/cadastro">Cadastrar Caso</a>
    <a href="/caso/meuscasos">Meus Casos</a>
    <a href="/cliente/cadastro">Cadastrar Cliente</a>
    <a href="/cliente/clientes">Clientes</a>
</div-->
<link rel="stylesheet" type="text/css" href="resources/style_menu.css">
<input type="checkbox" id="bt_menu">
<label for="bt_menu">&#9776;</label>

<nav class="menu">
    <ul>
        <li><a href="">Home</a></li>
        <li><a href="">Casos</a>
            <ul>
                <li><a href="">Novo Caso</a></li>
                <li><a href="">Meus Casos</a></li>
            </ul>
        </li>
        <li><a href="">Clientes</a>
            <ul>
                <li><a href="">Novo Cliente</a></li>
                <li><a href="">Clientes "Empresa"</a></li>
                <li><a href="">Todos os Clientes</a></li>
            </ul>
        </li>
        <li><a href="">Empresas</a>
            <ul>
                <li><a href="">Nova Empresa</a></li>
                <li><a href="">Todas as Empresas</a></li>
            </ul>
        </li>
        <li><a href="">Usuarios</a>
            <ul>
                <li><a href="">Nova Usuario</a></li>
                <li><a href="">Todos os Usuarios</a></li>
            </ul>
        </li>
    </ul>
</nav>
<!--script>
    funcoesDeAdminNoMenu()

    function funcoesDeAdminNoMenu() {
        var admin = ${usuarioLogado.admin}

        if(admin)
            document.getElementById('menu').innerHTML += '<a href="/empresa/cadastro">Cadastrar Empresa</a><a href="/empresa/empresas">Empresas</a> <a href="/logout">Sair</a>'
        else
            document.getElementById('menu').innerHTML += '<a href="/logout">Sair</a>'
    }
</script -->

