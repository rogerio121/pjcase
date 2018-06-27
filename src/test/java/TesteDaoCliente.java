import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoCliente;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;

public class TesteDaoCliente {
    public static void main(String[] args) {
        insertCliente();
        //updateCliente();
        //deleteCliente();
        //buscaCliente();
        ConexaoBanco.FecharConexao();
    }

    public static void insertCliente() {
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();

        dadosPessoais.setNome("cliete");
        dadosPessoais.setEmail("cliente@cliente.com");
        dadosPessoais.setCpf("123123");
        cliente.setDadosPessoais(dadosPessoais);

        DaoCliente daoCliente = new DaoCliente();
        daoCliente.insert(cliente);
    }

    public static void updateCliente() {
        Cliente cliente = new Cliente();
        DadosPessoais dadosPessoais = new DadosPessoais();

        dadosPessoais.setNome("cliete Editado");
        dadosPessoais.setEmail("cliente@editado.com");
        dadosPessoais.setCpf("123123");
        cliente.setDadosPessoais(dadosPessoais);

        DaoCliente daoCliente = new DaoCliente();
        daoCliente.update(cliente);
    }

    public static void deleteCliente(){
        DaoCliente daoCliente = new DaoCliente();
        daoCliente.delete("123123");
    }

    public static void buscaCliente(){
        DaoCliente daoCliente = new DaoCliente();
        Cliente cliente = daoCliente.getById("123123");
        System.out.println(cliente.getDadosPessoais().getNome());
    }
}
