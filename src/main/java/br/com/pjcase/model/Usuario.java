package br.com.pjcase.model;

public class Usuario {
	
	String senha;
	Empresa empresaCliente;
	DadosPessoais dadosPessoais;
	Boolean admin;


	public Empresa getEmpresaCliente() {
		return empresaCliente;
	}

	public void setEmpresaCliente(Empresa empresaCliente) {
		this.empresaCliente = empresaCliente;
	}


	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}


	public DadosPessoais getDadosPessoais() {
		return dadosPessoais;
	}

	public void setDadosPessoais(DadosPessoais dadosPessoais) {
		this.dadosPessoais = dadosPessoais;
	}


	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "Usuario{" +
				"senha='" + senha + '\'' +
				", empresaCliente=" + empresaCliente +
				", dadosPessoais=" + dadosPessoais +
				", admin=" + admin +
				'}';
	}
}
