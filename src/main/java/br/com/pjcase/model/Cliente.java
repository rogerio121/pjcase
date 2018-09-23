package br.com.pjcase.model;



public class Cliente {

    private Empresa empresa;
    private DadosPessoais dadosPessoais;

    public Empresa getEmpresa() {
        return empresa;
    }

    public void setEmpresa(Empresa empresa) {
        this.empresa = empresa;
    }

    public DadosPessoais getDadosPessoais() {
        return dadosPessoais;
    }

    public void setDadosPessoais(DadosPessoais dadosPessoais) {
        this.dadosPessoais = dadosPessoais;
    }


    @Override
    public String toString() {
        return "Cliente{" +
                "empresa=" + empresa +
                ", dadosPessoais=" + dadosPessoais +
                '}';
    }
}
