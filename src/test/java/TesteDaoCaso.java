import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.model.*;

import java.util.Date;
import java.util.List;


public class TesteDaoCaso {
    public static void main(String[] args) {
         //insertCliente();
        //updateCliente();
        //deleteCliente();
        //buscaCliente();
        buscaCasosSemDono();
        ConexaoBanco.FecharConexao();
    }

    public static void insertCliente() {
        Caso caso = new Caso();

        caso.setDataDeAbertura("2018-12-03");
        caso.setDataDeFechamento("2018-12-03");
        caso.setMenssagem("Menssgem");
        caso.setStatus("Fechado");
        caso.setIdEmpresaRelacionada("3131");
        caso.setIdClienteRelacionado("123123");
        caso.setIdUsuarioRelacionado("admin@admin.com");

        DaoCaso daoCaso = new DaoCaso();
        daoCaso.insert(caso);
    }

    public static void updateCliente() {
        Caso caso = new Caso();

        caso.setIdCaso(1);
        caso.setDataDeAbertura("2018-12-03");
        caso.setDataDeFechamento("2018-12-03");
        caso.setMenssagem("Menssgem Editada");
        caso.setStatus("Aberto");
        caso.setIdEmpresaRelacionada("3131");
        caso.setIdUsuarioRelacionado("admin@admin.com");

        DaoCaso daoCaso = new DaoCaso();
        daoCaso.update(caso);
    }

    public static void deleteCliente(){
        DaoCaso daoCaso = new DaoCaso();
        daoCaso.delete("1");
    }

    public static void buscaCliente(){
        DaoCaso daoCaso = new DaoCaso();
        Caso caso = daoCaso.getById("1");
        System.out.println(caso.getStatus());
    }

    public static void buscaCasosSemDono(){
        DaoCaso daoCaso = new DaoCaso();
        List<Caso> casos = daoCaso.listarCasosSemProprietarios();

        System.out.println(casos.size());

    }
}
