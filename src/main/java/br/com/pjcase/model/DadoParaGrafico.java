package br.com.pjcase.model;

public class DadoParaGrafico {
    private int count;
    private String dadoReferenteAoCont;
    private String statusDoCaso;
    private String dataAberturaDoCaso;
    private String dataFechamentoDoCaso;


    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getDadoReferenteAoCont() {
        return dadoReferenteAoCont;
    }

    public void setDadoReferenteAoCont(String dadoReferenteAoCont) {
        this.dadoReferenteAoCont = dadoReferenteAoCont;
    }

    public String getStatusDoCaso() {
        return statusDoCaso;
    }

    public void setStatusDoCaso(String statusDoCaso) {
        this.statusDoCaso = statusDoCaso;
    }

    public String getDataAberturaDoCaso() {
        return dataAberturaDoCaso;
    }

    public void setDataAberturaDoCaso(String dataAberturaDoCaso) {
        this.dataAberturaDoCaso = dataAberturaDoCaso;
    }

    public String setDataFechamentoDoCaso(String cas_data_de_fechamento) {
        return dataFechamentoDoCaso;
    }

    public void getDataFechamentoDoCaso(String dataFechamentoDoCaso) {
        this.dataFechamentoDoCaso = dataFechamentoDoCaso;
    }
}
