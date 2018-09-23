package br.com.pjcase.model;

public class DadosPessoais {

	private String nome;
	private String email;
	private String telefone;
	private String cpf;
	private String logradouro;
	private String cidade;
	private String bairro;
	private String estado;
	private String cep;



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

	public String getTelefone() {
		return telefone;
	}

	public void setTelefone(String telefone) {
		this.telefone = telefone;
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
		return "DadosPessoais{" +
				"nome='" + nome + '\'' +
				", email='" + email + '\'' +
				", telefone='" + telefone + '\'' +
				", cpf='" + cpf + '\'' +
				", logradouro='" + logradouro + '\'' +
				", cidade='" + cidade + '\'' +
				", bairro='" + bairro + '\'' +
				", estado='" + estado + '\'' +
				", cep='" + cep + '\'' +
				'}';
	}
}
