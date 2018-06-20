package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.OneToOne;

@Entity
public class Usuario extends Pessoa{
	
	String senha;
	@OneToOne
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
