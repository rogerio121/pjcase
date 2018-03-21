package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Empresa {
	
	String nome;
	@Id
	String cnpj;
	String logradouro;
	String cidade;
	String bairro;
	String estado;
}
