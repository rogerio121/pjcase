package br.com.pjcase.model;

import java.sql.Date;

public class Caso {

    int idCaso;
    String dataDeAbertura;
    String dataDeFechamento;
    String menssagem;
    String status;
    String idEmpresaRelacionada;
    String idUsuarioRelacionado;
    String idClienteRelacionado;

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

    public String getMenssagem() {
        return menssagem;
    }

    public void setMenssagem(String menssagem) {
        this.menssagem = menssagem;
    }


    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
