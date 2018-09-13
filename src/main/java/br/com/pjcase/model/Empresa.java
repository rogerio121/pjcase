package br.com.pjcase.model;

public class Empresa {
	
	String nome;
	String cnpj;
	String logradouro;
	String cidade;
	String bairro;
	String estado;
	String cep;


	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}


	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}


	public String getLogradouro() {
		return logradouro;
	}

	public void setLogradouro(String logradouro) {
		this.logradouro = logradouro;
	}


	public String getCidade() {
		return cidade;
	}

	public void setCidade(String cidade) {
		this.cidade = cidade;
	}


	public String getBairro() {
		return bairro;
	}

	public void setBairro(String bairro) {
		this.bairro = bairro;
	}


	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}


	public String getCep() {
		return cep;
	}

	public void setCep(String cep) {
		this.cep = cep;
	}


	@Override
	public String toString() {
		return "Empresa{" +
				"nome='" + nome + '\'' +
				", cnpj='" + cnpj + '\'' +
				", logradouro='" + logradouro + '\'' +
				", cidade='" + cidade + '\'' +
				", bairro='" + bairro + '\'' +
				", estado='" + estado + '\'' +
				", cep='" + cep + '\'' +
				'}';
	}
}
