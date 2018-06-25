import br.com.pjcase.conexao.ConexaoBanco;

public class TesteConexao {

    public static void main(String[] args) {
        ConexaoBanco.getConexao();

        System.out.println(ConexaoBanco.statusBanco);
    }
}
