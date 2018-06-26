import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.dao.DaoUsuario;
import br.com.pjcase.model.Empresa;
import br.com.pjcase.model.Usuario;

public class TesteDaoUsuario {

    public static void main(String[] args) {
        //insertUsuario();
        //updateUsuario();
        deleteUsuario();
        //buscaUsuario();
        ConexaoBanco.FecharConexao();
    }

    public static void insertUsuario() {
        Usuario usuario = new Usuario();

        usuario.setNome("admin");
        usuario.setEmail("admin@admin.com");
        usuario.setSenha("123");

        DaoUsuario daoUsuario = new DaoUsuario();
        daoUsuario.insert(usuario);
    }

    public static void updateUsuario() {
        Usuario usuario = new Usuario();

        usuario.setNome("adminEditado");
        usuario.setEmail("admin@admin.com");
        usuario.setSenha("123");

        DaoUsuario daoUsuario = new DaoUsuario();
        daoUsuario.update(usuario);
    }

    public static void deleteUsuario(){
        DaoUsuario daoUsuario = new DaoUsuario();
        daoUsuario.delete("admin@admin.com");
    }

    public static void buscaUsuario(){
        DaoUsuario daoUsuario = new DaoUsuario();
        Usuario usuario = daoUsuario.getById("admin@admin.com");
        System.out.println(usuario.getNome());
    }
}
