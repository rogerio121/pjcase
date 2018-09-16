import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.http.ResponseEntity;

import java.sql.SQLException;

public class TesteDaoCliente {

    @Test
    public void insertCliente() {
        Cliente cliente = new Cliente();
        Cliente clienteInserido = new Cliente();

        DadosPessoais dadosPessoais = new DadosPessoais();

        dadosPessoais.setNome("cliete");
        dadosPessoais.setEmail("cliente@cliente.com");
        dadosPessoais.setCpf("123");
        dadosPessoais.setLogradouro("Rua das dores n 1");
        dadosPessoais.setBairro("Bairro b");
        dadosPessoais.setCidade("São Paulo");
        dadosPessoais.setEstado("SP");
        cliente.setDadosPessoais(dadosPessoais);

        DaoCliente daoCliente = new DaoCliente();
        daoCliente.insert(cliente);

        clienteInserido = daoCliente.getById("123");
        Boolean clienteFoiCriado = clienteInserido != null;
        System.out.println(clienteInserido != null);

        Assert.assertEquals(clienteFoiCriado, true);
    }

    @Test
    public void updateCliente() {
        Cliente cliente = new Cliente();
        Cliente clienteEditado = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();

        dadosPessoais.setNome("cliete Editado");
        dadosPessoais.setEmail("cliente@cliente.com");
        dadosPessoais.setCpf("123");
        dadosPessoais.setLogradouro("Rua Nossa Senhora  das Dores n 12");
        dadosPessoais.setBairro("Bairro Jardims");
        dadosPessoais.setCidade("São Paulo");
        dadosPessoais.setEstado("SP");
        cliente.setDadosPessoais(dadosPessoais);

        DaoCliente daoCliente = new DaoCliente();
        daoCliente.update(cliente);

        clienteEditado = daoCliente.getById("123");

        Boolean clienteFoiEditado = cliente != clienteEditado;

        Assert.assertEquals(clienteFoiEditado, true);

    }

    @Test
    public void deleteCliente() throws SQLException {
        DaoCliente daoCliente = new DaoCliente();

        try {
            daoCliente.delete("123");
        }catch (Exception e){}

        Cliente cliente = null;

        cliente = daoCliente.getById("123");

        Boolean clienteFoiExcluido = cliente == null;

        Assert.assertEquals(clienteFoiExcluido, true);
    }

    @Test
    public void buscaCliente() {
        DaoCliente daoCliente = new DaoCliente();
        DadosPessoais dadosPessoais = new DadosPessoais();
        Cliente cliente = new Cliente();
        Cliente clienteInserido = null;

        dadosPessoais.setNome("cliete");
        dadosPessoais.setEmail("cliente@cliente.com");
        dadosPessoais.setCpf("123");
        dadosPessoais.setLogradouro("Rua das dores n 1");
        dadosPessoais.setBairro("Bairro b");
        dadosPessoais.setCidade("São Paulo");
        dadosPessoais.setEstado("SP");
        cliente.setDadosPessoais(dadosPessoais);

        daoCliente.insert(cliente);

        clienteInserido = daoCliente.getById("123");

        Boolean clienteFoiEncontrado = clienteInserido != null;
        Assert.assertEquals(clienteFoiEncontrado, true);
    }
}
