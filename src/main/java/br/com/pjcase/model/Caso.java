package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;


@Entity

public class Caso {
	
	@Id
	@GeneratedValue
	int idCaso;
	String dataDeAbertura;
	String dataDeFechamento;
	String menssagem;
	@OneToOne
	Usuario usuario;
	String status;
	@ManyToOne
	Contato cliente;
}
