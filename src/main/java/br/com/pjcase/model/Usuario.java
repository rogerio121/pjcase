package br.com.pjcase.model;

public class Usuario extends Pessoa{
	
	String senha;
	Empresa empresaCliente;


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
	
}
