package br.com.pjcase.model;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;

@Entity
public class Cliente extends Pessoa{

    @ManyToOne
    Empresa empresa;

    public Empresa getEmpresa() {
        return empresa;
    }

    public void setEmpresa(Empresa empresa) {
        this.empresa = empresa;
    }
}
