import br.com.pjcase.dao.DaoCaso;
import br.com.pjcase.model.*;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;

public class TesteDaoCaso {

    @Test
    public void insertCliente() throws Exception{
        Caso caso = new Caso();
        Caso casoInseriodo = new Caso();

        caso.setDataDeAbertura("2018-12-03");
        caso.setDataDeFechamento("2018-12-03");
        caso.setMensagem("Menssgem");
        caso.setStatus("Fechado");
        caso.setIdEmpresaRelacionada("3131");
        caso.setIdClienteRelacionado("123123");
        caso.setIdUsuarioRelacionado("admin@admin.com");


        DaoCaso daoCaso = new DaoCaso();
        daoCaso.insert(caso);

        casoInseriodo = daoCaso.getById("admin@admin.com");

        System.out.println(casoInseriodo != null);
        Assert.assertEquals(casoInseriodo != null, true);
    }

    @Test
    public void updateCliente() {
        Caso caso = new Caso();
        Caso casoEditado = new Caso();

        caso.setIdCaso(13);
        caso.setDataDeAbertura("2018-12-03");
        caso.setDataDeFechamento("2018-12-03");
        caso.setMensagem("Menssgem Editada");
        caso.setStatus("Aberto");
        caso.setIdEmpresaRelacionada("3131");
        caso.setIdUsuarioRelacionado("admin@admin.com");

        DaoCaso daoCaso = new DaoCaso();
        daoCaso.update(caso);
        casoEditado = daoCaso.getById("13");

        Boolean statusCasoFoiEditado = casoEditado.getStatus().equals("Aberto");
        Assert.assertEquals(statusCasoFoiEditado, true);
    }

    @Test
    public void deleteCliente() throws Exception{
        DaoCaso daoCaso = new DaoCaso();
        daoCaso.delete("1");

        //Assert.assertEquals(false, erro);
    }


    @Test
    public void buscaCliente() throws Exception{
        DaoCaso daoCaso = new DaoCaso();
        Caso caso = daoCaso.getById("1");
        System.out.println(caso.getStatus());
        //Assert.assertEquals(false, erro);
    }

    @Test
    public void buscaCasosSemDono() throws Exception{
        DaoCaso daoCaso = new DaoCaso();
        List<Caso> casos = daoCaso.listarCasosSemProprietarios();
        System.out.println(casos.size());
        //Assert.assertEquals(false, erro);
    }


}

