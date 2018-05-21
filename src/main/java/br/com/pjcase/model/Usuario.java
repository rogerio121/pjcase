package br.com.pjcase.model;

import javax.persistence.Entity;

@Entity
public class Usuario extends Pessoa{
	
	String senha;

	
	
	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}
	
}
