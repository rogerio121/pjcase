package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

@Entity
public class Contato extends Pessoa{
	
	@ManyToOne
	Empresa empresa;
}
