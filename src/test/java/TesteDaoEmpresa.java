import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.dao.DaoEmpresa;
import br.com.pjcase.model.Empresa;

public class TesteDaoEmpresa {

    public static void main(String[] args) {
        //insertEmpresa();
        updateEmpresa();
        //deleteEmpresa();
        //buscaEmpresa();
    }

    public static void insertEmpresa() {
        Empresa empresa = new Empresa();

        empresa.setNome("Empresa teste");
        empresa.setCnpj("ddd");
        empresa.setLogradouro("Rua teste n: 123");
        empresa.setBairro("BairroTeste");
        empresa.setCidade("CidadeTeste");
        empresa.setEstado("RR");

        DaoEmpresa daoEmpresa = new DaoEmpresa();
        daoEmpresa.insert(empresa);
    }

    public static void updateEmpresa() {
        Empresa empresa = new Empresa();

        empresa.setNome("Empresa editada");
        empresa.setCnpj("3131");
        empresa.setLogradouro("Rua editada");
        empresa.setBairro("BairroEditado");
        empresa.setCidade("CidadeEditado");
        empresa.setEstado("SP");

        DaoEmpresa daoEmpresa = new DaoEmpresa();

        daoEmpresa.update(empresa);
    }

    public static void deleteEmpresa(){
        DaoEmpresa daoEmpresa = new DaoEmpresa();

        daoEmpresa.delete("ddd");
    }

    public static void buscaEmpresa(){
        DaoEmpresa daoEmpresa = new DaoEmpresa();
        Empresa empresa = daoEmpresa.getById("3131");
        System.out.println(empresa.getNome());
    }
}
