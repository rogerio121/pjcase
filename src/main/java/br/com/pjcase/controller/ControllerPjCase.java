package br.com.pjcase.controller;


import javax.servlet.http.HttpServletRequest;

import br.com.pjcase.conexao.ConexaoBanco;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Empresa;

import static java.lang.System.out;


@Controller
public class ControllerPjCase {

	@RequestMapping("/")
	public String chamarTelaEmpresa() {
		return "empresa";
	}


	/*Caso a empresa já exista será feito um update
	 * caso não exista será feita a inserção
	 * a existencia da empresa será comprovada com uma pesquisa no banco com o CNPJ*/

	@RequestMapping("salvarempresa")
	public String salvarEmpresa(HttpServletRequest request) {
		Empresa empresa = new Empresa();
		empresa.setNome(request.getParameter("nome"));
		empresa.setCnpj(request.getParameter("cnpj"));
		empresa.setLogradouro(request.getParameter("logradouro"));
		empresa.setBairro(request.getParameter("bairro"));
		empresa.setCidade(request.getParameter("cidade"));
		empresa.setEstado(request.getParameter("estado"));

		DaoEmpresa daoEmpresa = new DaoEmpresa();

		daoEmpresa.upsert(empresa);
		out.println("<script>https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.4/sweetalert2.all.js</script>");
		out.println("<script>https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js</script>");
		out.println("<script>");
		out.println("$(document).ready(functio(){");
		out.println("swal('WELCOMW','successfull', 'successs');");
		out.println("});");
		out.println("</script>");

		ConexaoBanco.FecharConexao();
		return "salvarempresa";
	}
}
