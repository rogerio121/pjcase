package br.com.pjcase.model;

import java.sql.Date;

public class Caso {

    int idCaso;
    String assunto;
    String dataDeAbertura;
    String dataDeFechamento;
    String mensagem;
    String status;
    String idEmpresaRelacionada;
    String idUsuarioRelacionado;
    String idClienteRelacionado;
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


    public String getIdEmpresaRelacionada() {
        return idEmpresaRelacionada;
    }

    public void setIdEmpresaRelacionada(String idEmpresaRelacionada) {
        this.idEmpresaRelacionada = idEmpresaRelacionada;
    }

    public String getIdUsuarioRelacionado() {
        return idUsuarioRelacionado;
    }

    public void setIdUsuarioRelacionado(String idUsuarioRelacionado) {
        this.idUsuarioRelacionado = idUsuarioRelacionado;
    }

    public String getIdClienteRelacionado() {
        return idClienteRelacionado;
    }

    public void setIdClienteRelacionado(String idClienteRelacionado) {
        this.idClienteRelacionado = idClienteRelacionado;
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


    @Override
    public String toString() {
        return "Caso{" +
                "idCaso=" + idCaso +
                ", assunto='" + assunto + '\'' +
                ", dataDeAbertura='" + dataDeAbertura + '\'' +
                ", dataDeFechamento='" + dataDeFechamento + '\'' +
                ", mensagem='" + mensagem + '\'' +
                ", status='" + status + '\'' +
                ", idEmpresaRelacionada='" + idEmpresaRelacionada + '\'' +
                ", idUsuarioRelacionado='" + idUsuarioRelacionado + '\'' +
                ", idClienteRelacionado='" + idClienteRelacionado + '\'' +
                ", resolucao='" + resolucao + '\'' +
                '}';
    }
}
