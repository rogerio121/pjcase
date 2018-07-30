package br.com.pjcase.model;

import java.sql.Date;

public class Caso {

    int idCaso;
    String assunto;
    String dataDeAbertura;
    String dataDeFechamento;
    String mensagem;
    String status;
    Empresa empresa;
    Usuario usuario;
    Cliente cliente;
    String resolucao;


    public String getAssunto() {
        return assunto;
    }

    public void setAssunto(String assunto) {
        this.assunto = assunto;
    }

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


    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String menssagem) {
        this.mensagem = menssagem;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    public String getResolucao() {
        return resolucao;
    }

    public void setResolucao(String resolucao) {
        this.resolucao = resolucao;
    }


    public Empresa getEmpresa() {
        return empresa;
    }

    public void setEmpresa(Empresa empresa) {
        this.empresa = empresa;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }


    @Override
    public String toString() {
        return "Caso{" +
                "idCaso=" + idCaso +
                ", assunto='" + assunto + '\'' +
                ", dataDeAbertura='" + dataDeAbertura + '\'' +
                ", dataDeFechamento='" + dataDeFechamento + '\'' +
                ", mensagem='" + mensagem + '\'' +
                ", status='" + status + '\'' +
                ", empresa=" + empresa +
                ", usuario=" + usuario +
                ", cliente=" + cliente +
                ", resolucao='" + resolucao + '\'' +
                '}';
    }
}
