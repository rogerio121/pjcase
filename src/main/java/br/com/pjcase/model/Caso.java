package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;


@Entity

public class Caso {
	
	@Id
	@GeneratedValue
	int idCaso;
	String dataDeAbertura;
	String dataDeFechamento;
	String menssagem;
//	Usuario usuario;
	String status;
//	Cliente cliente;
}
