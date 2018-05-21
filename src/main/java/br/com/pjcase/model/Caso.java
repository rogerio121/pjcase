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

	public int getIdCaso() {
		return idCaso;
	}

	public void setIdCaso(int idCaso) {
		this.idCaso = idCaso;
	}


	public String getDataDeAbertura() {
		return dataDeAbertura;
	}

	public void setDataDeAbertura(String dataDeAbertura) {
		this.dataDeAbertura = dataDeAbertura;
	}


	public String getDataDeFechamento() {
		return dataDeFechamento;
	}

	public void setDataDeFechamento(String dataDeFechamento) {
		this.dataDeFechamento = dataDeFechamento;
	}


	public String getMenssagem() {
		return menssagem;
	}

	public void setMenssagem(String menssagem) {
		this.menssagem = menssagem;
	}


	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}


	public Contato getCliente() {
		return cliente;
	}

	public void setCliente(Contato cliente) {
		this.cliente = cliente;
	}
}
