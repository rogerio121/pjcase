<link rel="stylesheet" type="text/css" href="resources/css/style_menu.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<input type="checkbox" id="bt_menu">
<label for="bt_menu">&#9776;</label>

<nav class="menu">
    <ul>
        <li><a href="/telaInicial"><i class="fas fa-home"></i> Home</a></li>
        <li><a href=""><i class="fas fa-exclamation"></i> Casos</a>
            <ul>
                <li><a href="/caso/cadastro">Novo Caso</a></li>
                <li><a href="/caso/meuscasos">Meus Casos</a></li>
                <li id="todos-os-casos"><a href="">Todos Casos</a></li>
            </ul>
        </li>
        <li><a href=""><i class="fas fa-users"></i> Clientes</a>
            <ul>
                <li><a href="/cliente/cadastro"> Novo Cliente</a></li>
                <li><a href="/cliente/clientes">Clientes "Empresa"</a></li>
                <li id="todos-os-clientes"><a href="">Todos os Clientes</a></li>
            </ul>
        </li>
        <li id="empresas"><a href=""><i class="fas fa-building"></i> Empresas</a>
            <ul>
                <li><a href="/empresa/cadastro"> Nova Empresa</a></li>
                <li><a href="/empresa/empresas">Todas as Empresas</a></li>
            </ul>
        </li>
        <li id="usuarios"><a href=""><i class="fas fa-user"></i>Usuarios</a>
            <ul>
                <li><a href="/usuario/cadastro">Novo Usuario</a></li>
                <li><a href="/usuario/usuarios">Todos os Usuarios</a></li>
            </ul>
        </li>
        <li><a href=""><i class="fas fa-user-circle"></i> ${usuarioLogado.dadosPessoais.nome}</a>
            <ul>
                <li><a href="/logout">Sair</a></li>
            </ul>
        </li>
    </ul>
</nav>
<script>
    funcoesDeAdminNoMenu()

    function funcoesDeAdminNoMenu() {
        var admin = ${usuarioLogado.admin}

        console.log(${usuarioLogado.admin})
        if(!admin) {
            document.getElementById('todos-os-casos').style.display = "none"
            document.getElementById('todos-os-clientes').style.display = "none"
            document.getElementById('empresas').style.display = "none"
            document.getElementById('usuarios').style.display = "none"
        }

    }
</script>

