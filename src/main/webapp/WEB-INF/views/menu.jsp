<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8" />

<link rel="stylesheet" type="text/css" href="../../../resources/css/style_menu.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
<input type="checkbox" id="bt_menu">
<label for="bt_menu">&#9776;</label>

<nav class="menu">
    <ul style="z-index: 1">
        <li><a href="/telaInicial"><i class="fas fa-home"></i> Home</a></li>
        <li><a href="javascript:void(0)"><i class="fas fa-exclamation"></i> Casos</a>
            <ul>
                <li><a href="/caso/cadastro">Novo Caso</a></li>
                <li><a href="/caso/meuscasos/todososcasos">Meus Casos</a></li>
                <li id="todos-os-casos"><a href="/caso/todososcasos">Todos Casos</a></li>
            </ul>
        </li>
        <li><a href="javascript:void(0)"><i class="fas fa-users"></i> Clientes</a>
            <ul>
                <li><a href="/cliente/cadastro"> Novo Cliente</a></li>
                <li><a href="/cliente/clientes"> Clientes</a></li>
            </ul>
        </li>
        <li id="empresas"><a href="javascript:void(0)"><i class="fas fa-building"></i> Empresas</a>
            <ul>
                <li><a href="/empresa/cadastro"> Nova Empresa</a></li>
                <li><a href="/empresa/empresas"> Todas as Empresas</a></li>
            </ul>
        </li>
        <li id="usuarios"><a href="javascript:void(0)"><i class="fas fa-user"></i>Usuários</a>
            <ul>
                <li><a href="/usuario/cadastro"> Novo Usuário</a></li>
                <li><a href="/usuario/usuarios"> Todos os Usuários</a></li>
            </ul>
        </li>
        <li id="graficos"><a href="/graficos"><i class="fas fa-chart-line"></i> Gráficos</a></li>
    </ul>
    <ul id="menu-canto">
        <li>
            <a href="javascript:void(0)"><i class="fas fa-user-circle"></i> <span id="nomeUser"> </span></a>
            <ul>
                <li><a href="/logout">Sair</a></li>
            </ul>
        </li>
    </ul>
</nav>
<script>
    funcoesDeAdminNoMenu()
    pegaPrimeiroNomeUsuariLogado()


    function funcoesDeAdminNoMenu() {
        var admin = ${usuarioLogado.admin}

        if(!admin) {
            document.getElementById('todos-os-casos').style.display = "none"
            document.getElementById('empresas').style.display = "none"
            document.getElementById('usuarios').style.display = "none"
            document.getElementById('graficos').style.display = "none"
        }
    }


    function pegaPrimeiroNomeUsuariLogado() {
        nomeCompleto = '${usuarioLogado.dadosPessoais.nome}'
        var nomeAbreviado
        nomeCompleto = nomeCompleto.split(" ")
        document.getElementById('nomeUser').innerHTML = nomeCompleto[0]
    }
</script>

