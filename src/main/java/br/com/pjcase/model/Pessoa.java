package br.com.pjcase.model;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class Pessoa {
	
	
	String nome;
	String rg;
	@Id
	String cpf;
	String email;
	
}
