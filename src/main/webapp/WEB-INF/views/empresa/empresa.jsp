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
		<form action="/empresa/salvar" method="post">
			<label>Nome</label> <input type="text" name="nome" value="${empresa.nome}"> <br>
			<label>CNPJ</label> <input type="text" name="cnpj" value="${empresa.cnpj}"> <br>
			<label>Logradouro</label> <input type="text" name="logradouro" value="${empresa.logradouro}"> <br>
			<label>Bairrro</label> <input type="text" name="bairro" value="${empresa.bairro}"> <br>
			<label>Cidade</label> <input type="text" name="cidade" value="${empresa.cidade}"> <br>
			<label>Estado</label>
			<select id="estado" name="estado">
				<option selected="" value="">Selecione o Estado</option>
				<option value="Acre">Acre</option>
				<option value="Alagoas">Alagoas</option>
				<option value="Amapá">Amapá</option>
				<option value="Amazonas">Amazonas</option>
				<option value="Bahia">Bahia</option>
				<option value="Ceará">Ceará</option>
				<option value="Distrito Federal">Distrito Federal</option>
				<option value="Espírito Santo">Espírito Santo</option>
				<option value="Goiás">Goiás</option>
				<option value="Maranhão">Maranhão</option>
				<option value="Mato Grosso">Mato Grosso</option>
				<option value="Mato Grosso do Sul">Mato Grosso do Sul</option>
				<option value="Minas Gerais">Minas Gerais</option>
				<option value="Pará">Pará</option>
				<option value="Paraíba">Paraíba</option>
				<option value="Paraná">Paraná</option>
				<option value="Pernambuco">Pernambuco</option>
				<option value="Piauí">Piauí</option>
				<option value="Rio de Janeiro">Rio de Janeiro</option>
				<option value="Rio Grande do Sul">Rio Grande do Sul</option>
				<option value="Rio Grande do Norte">Rio Grande do Norte</option>
				<option value="Rondônia">Rondônia</option>
				<option value="Roraima">Roraima</option>
				<option value="Santa Catarina">Santa Catarina</option>
				<option value="São Paulo">São Paulo</option>
				<option value="Sergipe">Sergipe</option>
				<option value="Tocantins">Tocantins</option>
			</select> <br>
			<label>CEP</label> <input type="text" name="cep" value="${empresa.cep}"> <br>

			<button type="submit">Salvar</button>
		</form>
	</body>
	<script>
        pegarEstado()

        function pegarEstado() {
            var estado = '${empresa.estado}'
            document.getElementById('estado').value = estado
        }
	</script>
</html>