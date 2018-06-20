package br.com.pjcase.testes;

import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.Usuario;

import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

/* Os testes foram realizados usando como Usuario e Cliente os registros criados nos testes anteriores*/
public class TesteCaso {
    public static void main(String[] args) {

        //insertCaso();
        //updateCaso();
        deleteCaso();
    }

    public static void insertCaso() {
        Usuario usr = new Usuario();

        usr.setCpf("050.157.350-06");
        usr.setNome("Rogério Teste");
        usr.setEmail("email@teste.com");
        usr.setRg("25.164.386-4");
        usr.setSenha("123456");


       /* Contato contato = new Contato();

        contato.setNome("ClienteTeste");
        contato.setCpf("906.879.450-70");
        contato.setEmail("clienteemail@teste.com");
        contato.setRg("12.001.929-2");
        //contato.setEmpresa(empresa);*/


        Caso caso = new Caso();

        caso.setDataDeAbertura("2018-05-20");
        caso.setDataDeFechamento("2018-05-20");
        caso.setMenssagem("Menssagem de erro ");
        caso.setUsuario(usr);
        //caso.setCliente(contato);
        caso.setStatus("Fechado");


        DaoCaso daoCaso = new DaoCaso(Caso.class);

        daoCaso.insert(caso);

    }

    public static void updateCaso() {
        Cliente cliente = new Cliente();

        cliente.setNome("ClienteTeste");
        cliente.setCpf("906.879.450-70");
        cliente.setEmail("clienteemail@teste.com");
        cliente.setRg("12.001.929-2");
        //contato.setEmpresa(empresa);


        Caso caso = new Caso();

        caso.setDataDeAbertura("2018-05-20");
        caso.setDataDeFechamento("2018-05-20");
        caso.setMenssagem("Menssagem de erro ");
        caso.setIdCaso(1);
        caso.setCliente(cliente);
        caso.setStatus("Fechado");


        DaoCaso daoCaso = new DaoCaso(Caso.class);

        daoCaso.update(caso);

    }
    public static void deleteCaso(){

         Caso caso = new Caso();

          caso.setIdCaso(1);

        DaoCaso daoCaso = new DaoCaso(Caso.class);

        daoCaso.delete(caso.getIdCaso());
    }

}
