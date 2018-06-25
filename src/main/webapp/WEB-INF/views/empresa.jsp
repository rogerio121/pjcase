<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Empresa</title>
</head>
<body>
	<form action="salvarempresa" method="post">
		<label>Nome</label> <input type="text" name="nome"> <br>
		<label>CNPJ</label> <input type="text" name="cnpj"> <br>
		<label>Logradouro</label> <input type="text" name="logradouro"> <br>
		<label>Bairrro</label> <input type="text" name="bairro"> <br>
		<label>Cidade</label> <input type="text" name="cidade"> <br>
		<label>Estado</label> <input type="text" name="estado"> <br>

		<button type="submit">Salvar</button>
	</form>
</body>
</html>