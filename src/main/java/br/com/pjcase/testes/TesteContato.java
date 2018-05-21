package br.com.pjcase.testes;

import br.com.pjcase.dao.DaoContato;
import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Contato;
import br.com.pjcase.model.Empresa;

public class TesteContato {
    public static void main(String[] args) {
        Empresa empresa = new Empresa();

        empresa.setNome("Empresa teste");
        empresa.setCnpj("21.726.522/0001-45");
        empresa.setLogradouro("Rua teste n: 123");
        empresa.setBairro("BairroTeste");
        empresa.setCidade("CidadeTeste");
        empresa.setEstado("EstadoTeste");



        insertContato(empresa);
        //updateEmpresa();
        //deleteEmpresa();
    }

    public static void insertContato(Empresa empresa) {
        Contato contato = new Contato();

        contato.setNome("ClienteTeste");
        contato.setCpf("906.879.450-70");
        contato.setEmail("clienteemail@teste.com");
        contato.setRg("12.001.929-2");
        contato.setEmpresa(empresa);


        DaoContato daoContato = new DaoContato(Contato.class);

        daoContato.insert(contato);

    }

    /*public static void updateCliente() {
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

    public static void deleteCliente(){

        Empresa empresa = new Empresa();

        empresa.setCnpj("21.726.522/0001-45");

        DaoEmpresa daoEmpresa = new DaoEmpresa(Empresa.class);

        daoEmpresa.delete(empresa.getCnpj());

    }*/
}