package br.com.pjcase.model;

public class Usuario {
	
	String senha;
	String idEmpresaRelacionada;
	DadosPessoais dadosPessoais;
	Boolean admin;
	int identificacao;


	public String getIdEmpresaRelacionada() {
		return idEmpresaRelacionada;
	}

	public void setIdEmpresaRelacionada(String idEmpresaRelacionada) {
		this.idEmpresaRelacionada = idEmpresaRelacionada;
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


	public int getIdentificacao() {
		return identificacao;
	}

	public void setIdentificacao(int identificacao) {
		this.identificacao = identificacao;
	}


	@Override
	public String toString() {
		return "Usuario{" +
				"senha='" + senha + '\'' +
				", idEmpresaRelacionada='" + idEmpresaRelacionada + '\'' +
				", dadosPessoais=" + dadosPessoais +
				", admin=" + admin +
				", identificacao=" + identificacao +
				'}';
	}
}
