package br.com.pjcase.testes;

import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Empresa;

public class TesteEmpresa {

    public static void main(String[] args) {
        insertEmpresa();
        //updateEmpresa();
        //deleteEmpresa();
    }

    public static void insertEmpresa() {
        Empresa empresa = new Empresa();

        empresa.setNome("Empresa teste");
        empresa.setCnpj("21.726.522/0001-45");
        empresa.setLogradouro("Rua teste n: 123");
        empresa.setBairro("BairroTeste");
        empresa.setCidade("CidadeTeste");
        empresa.setEstado("EstadoTeste");

        DaoEmpresa daoEmpresa = new DaoEmpresa(Empresa.class);

        daoEmpresa.insert(empresa);

    }

    public static void updateEmpresa() {
        Empresa empresa = new Empresa();

        empresa.setNome("Empresa editada");
        empresa.setCnpj("21.726.522/0001-45");
        empresa.setLogradouro("Rua editada");
        empresa.setBairro("BairroEditado");
        empresa.setCidade("CidadeEditado");
        empresa.setEstado("EstadoEditado");

        DaoEmpresa daoEmpresa = new DaoEmpresa(Empresa.class);

        daoEmpresa.update(empresa);

    }

    public static void deleteEmpresa(){

        Empresa empresa = new Empresa();

        empresa.setCnpj("21.726.522/0001-45");

        DaoEmpresa daoEmpresa = new DaoEmpresa(Empresa.class);

        daoEmpresa.delete(empresa.getCnpj());

    }
}
