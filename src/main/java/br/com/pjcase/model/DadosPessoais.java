package br.com.pjcase.model;

import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class DadosPessoais {
	
	
	String nome;
	String email;
	String cpf;


	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	
}
