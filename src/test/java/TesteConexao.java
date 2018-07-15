import br.com.pjcase.conexao.ConexaoBanco;
import org.junit.Assert;
import org.junit.Test;

public class TesteConexao {

    @Test
    public void cenexao(){
        ConexaoBanco.getConexao();
        Assert.assertEquals("STATUS--->Conectado com sucesso!", ConexaoBanco.statusBanco);
    }
}
