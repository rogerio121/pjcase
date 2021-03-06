package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DaoCaso {

    Connection conexao;

    public DaoCaso() {
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(Caso caso)throws SQLException {
            String sql;
            if (caso.getUsuario() != null) {
                sql = "INSERT INTO caso (cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_resolucao, cas_status, emp_cnpj, usu_id, cli_cpf)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


                PreparedStatement pstm = conexao.prepareStatement(sql);
                pstm.setString(1, caso.getAssunto());
                pstm.setString(2, caso.getDataDeAbertura());
                pstm.setString(3, caso.getDataDeFechamento());
                pstm.setString(4, caso.getMensagem());
                pstm.setString(5, caso.getResolucao());
                pstm.setString(6, caso.getStatus());
                pstm.setString(7, caso.getEmpresa().getCnpj());
                pstm.setInt(8, caso.getUsuario().getId());
                pstm.setString(9, caso.getCliente().getDadosPessoais().getCpf());

                System.out.println(pstm);
                pstm.execute();
                pstm.close();
            } else {
                sql = "INSERT INTO caso (cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, cli_cpf)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pstm = conexao.prepareStatement(sql);
                pstm.setString(1, caso.getAssunto());
                pstm.setString(2, caso.getDataDeAbertura());
                pstm.setString(3, caso.getDataDeFechamento());
                pstm.setString(4, caso.getMensagem());
                pstm.setString(5, caso.getStatus());
                pstm.setString(6, caso.getEmpresa().getCnpj());
                pstm.setString(7, caso.getCliente().getDadosPessoais().getCpf());

                pstm.execute();
                pstm.close();
            }
    }

    public void update(Caso caso)throws SQLException {
            String sql = "UPDATE caso SET cas_assusnto = ?, cas_data_de_abertura = ?, cas_data_de_fechamento = ?, cas_menssagem = ?, cas_resolucao = ?, cas_status = ?, " +
                    "emp_cnpj = ?, usu_id = ?, cli_cpf = ?  " +
                    "WHERE cas_id = ?";


            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, caso.getAssunto());
            pstm.setString(2, caso.getDataDeAbertura());
            pstm.setString(3, caso.getDataDeFechamento());
            pstm.setString(4, caso.getMensagem());
            pstm.setString(5, caso.getResolucao());
            pstm.setString(6, caso.getStatus());
            pstm.setString(7, caso.getEmpresa().getCnpj());
            pstm.setInt(8, caso.getUsuario().getId());
            pstm.setString(9, caso.getCliente().getDadosPessoais().getCpf());
            pstm.setInt(10, caso.getIdCaso());

            pstm.execute();
            pstm.close();
    }

    public void delete(String idCaso) {
        try {
            String sql = "DELETE FROM caso WHERE cas_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCaso);

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Caso: " + erro);
        }
    }

    public Caso getById(String idCaso) {
        try {
            String sql = "SELECT *" +
                    "FROM caso " +
                    "WHERE cas_id = ? ";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCaso);
            ResultSet rs = pstm.executeQuery();

            Caso caso = null;
            if (rs.next()) {
                caso = new Caso();

                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));

            }
            pstm.close();
            return caso;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Caso por Id: " + erro);
            return null;
        }
    }

    public void upsert(Caso caso)throws SQLException {
        Caso casoCadastrado = null;
        casoCadastrado = getById(String.valueOf(caso.getIdCaso()));

        DateFormat formatoDaData = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date data = new Date();

        if (casoCadastrado == null) {
            caso.setDataDeAbertura(formatoDaData.format(data));
            insert(caso);
        } else {
            caso.setDataDeAbertura(casoCadastrado.getDataDeAbertura());
            update(caso);
        }
    }
    /*------------FIM-CRUD----------------*/

    public List<Caso> listarCasosSemProprietarios(Usuario usuario) {
        try {
            String sql;
            PreparedStatement pstm;
            if(usuario.getAdmin()) {
                sql = "SELECT *" +
                        "FROM caso " +
                        "WHERE usu_id IS NULL " +
                        "ORDER BY cas_id desc";

                pstm = conexao.prepareStatement(sql);
            }else{
                sql = "SELECT *" +
                      "FROM caso " +
                      "WHERE emp_cnpj = ? AND usu_id IS NULL " +
                      "ORDER BY cas_id desc";


                pstm = conexao.prepareStatement(sql);
                pstm.setString(1, usuario.getIdEmpresaRelacionada());
            }

            ResultSet rs = pstm.executeQuery();

            Caso caso;
            List<Caso> casos = new ArrayList<Caso>();

            while (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                caso = new Caso();
                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));


                //Clente
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoaisCliente = new DadosPessoais();

                dadosPessoaisCliente.setCpf(rs.getString("cli_cpf"));

                cliente.setDadosPessoais(dadosPessoaisCliente);

                casos.add(caso);
            }

            pstm.close();
            return casos;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Caso sem proprietário: " + erro);
            return null;
        }
    }

    public List<Caso> listarCasosPorProprietarios(int idUsuario, String status) {
        try {
            String sql = "";
            PreparedStatement pstm;

            if(status.equalsIgnoreCase("todososcasos")){
                sql = "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, usuario.usu_email " +
                        "FROM caso " +
                        "inner join usuario on caso.usu_id = usuario.usu_id join empresa join cliente " +
                        "WHERE caso.usu_id = ? " +
                        "ORDER BY cas_id desc )";

                pstm = conexao.prepareStatement(sql);
                pstm.setInt(1, idUsuario);
                System.out.println(pstm);
            }
            else {
                sql = "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, usuario.usu_email " +
                        "FROM caso " +
                        "inner join usuario on caso.usu_id = usuario.usu_id join empresa join cliente " +
                        "WHERE caso.usu_id = ? AND caso.cas_status = ? " +
                        "ORDER BY cas_id desc )";
                pstm = conexao.prepareStatement(sql);
                pstm.setInt(1, idUsuario);
                pstm.setString(2,status);
            }

            ResultSet rs = pstm.executeQuery();

            Caso caso;
            List<Caso> casos = new ArrayList<Caso>();

            while (rs.next()) {
                caso = new Caso();

                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));

                //Empresa
                Empresa empresa = new Empresa();
                empresa.setCnpj(rs.getString("emp_cnpj"));

                //Usuario
                Usuario usuario = new Usuario();
                DadosPessoais dadosPessoaisUsuario = new DadosPessoais();

                dadosPessoaisUsuario.setEmail(rs.getString("usu_email"));
                usuario.setId(rs.getInt("usu_id"));

                usuario.setDadosPessoais(dadosPessoaisUsuario);

                //Clente
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoaisCliente = new DadosPessoais();

                dadosPessoaisCliente.setCpf(rs.getString("cli_cpf"));

                cliente.setDadosPessoais(dadosPessoaisCliente);
                cliente.setEmpresa(empresa);


                caso.setEmpresa(empresa);
                caso.setCliente(cliente);

                casos.add(caso);
            }

            pstm.close();
            return casos;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Casos por Id do usuario: " + erro);
            return null;
        }
    }

    public List<Caso> listarCasosPoStatus(String status) {
        try {
            String sql = "";
            PreparedStatement pstm;

            if(status.equalsIgnoreCase("todososcasos")){
                sql = "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, usuario.usu_email " +
                        "FROM caso " +
                        "inner join usuario on caso.usu_id = usuario.usu_id join empresa join cliente )" +
                        "UNION All " +
                        "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, null " +
                        "FROM caso " +
                        "WHERE caso.usu_id is null) ORDER BY cas_id desc";
                pstm = conexao.prepareStatement(sql);
            }
            else {
                sql = "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, usuario.usu_email " +
                        "FROM caso " +
                        "inner join usuario on caso.usu_id = usuario.usu_id join empresa join cliente " +
                        "WHERE caso.cas_status = ? " +
                        "ORDER BY cas_id desc )" +
                        "UNION All " +
                        "(SELECT distinct cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_resolucao, cas_menssagem, cas_status, cas_assusnto, caso.emp_cnpj, caso.usu_id, caso.cli_cpf, null " +
                        "FROM caso " +
                        "WHERE caso.usu_id is null AND caso.cas_status = ?) ";
                pstm = conexao.prepareStatement(sql);
                pstm.setString(1,status);
                pstm.setString(2,status);
            }

            ResultSet rs = pstm.executeQuery();

            Caso caso;
            List<Caso> casos = new ArrayList<Caso>();

            while (rs.next()) {
                caso = new Caso();

                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));

                //Empresa
                Empresa empresa = new Empresa();
                empresa.setCnpj(rs.getString("emp_cnpj"));

                //Usuario
                Usuario usuario = new Usuario();
                DadosPessoais dadosPessoaisUsuario = new DadosPessoais();
                dadosPessoaisUsuario.setEmail(rs.getString("usu_email"));
                usuario.setId(rs.getInt("usu_id"));

                usuario.setDadosPessoais(dadosPessoaisUsuario);

                //Clente
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoaisCliente = new DadosPessoais();
                dadosPessoaisCliente.setCpf(rs.getString("cli_cpf"));

                cliente.setDadosPessoais(dadosPessoaisCliente);
                cliente.setEmpresa(empresa);

                caso.setEmpresa(empresa);
                caso.setCliente(cliente);

                casos.add(caso);
            }

            pstm.close();
            return casos;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar todos os Casos : " + erro);
            return null;
        }
    }

    public void pegarCaso(Caso caso) {
        try {
            String sql = "UPDATE caso SET  usu_id = ? " +
                    "WHERE cas_id = ?";


            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, caso.getUsuario().getId());
            pstm.setInt(2, caso.getIdCaso());

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao pegar Caso: " + erro);
        }
    }

    public Caso buscarCasoCompleto(int idCaso) {
        try {
            String sql = "SELECT * " +
                    "FROM caso " +
                    "inner join usuario on caso.usu_id = usuario.usu_id " +
                    "join empresa " +
                    "join cliente " +
                    "WHERE caso.cas_id = ? ";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idCaso);
            ResultSet rs = pstm.executeQuery();

            Caso caso = null;

            if (rs.next()) {
                caso = new Caso();

                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));

                //Empresa
                Empresa empresa = new Empresa();

                empresa.setNome(rs.getString("emp_nome"));
                empresa.setCnpj(rs.getString("emp_cnpj"));

                //Usuario
                Usuario usuario = new Usuario();
                DadosPessoais dadosPessoaisUsuario = new DadosPessoais();

                dadosPessoaisUsuario.setNome(rs.getString("usu_nome"));
                dadosPessoaisUsuario.setEmail(rs.getString("usu_email"));
                usuario.setId(rs.getInt("usu_id"));

                usuario.setDadosPessoais(dadosPessoaisUsuario);

                //Clente
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoaisCliente = new DadosPessoais();

                dadosPessoaisCliente.setNome(rs.getString("cli_nome"));
                dadosPessoaisCliente.setEmail(rs.getString("cli_email"));
                dadosPessoaisCliente.setCpf(rs.getString("cli_cpf"));

                cliente.setDadosPessoais(dadosPessoaisCliente);
                cliente.setEmpresa(empresa);


                caso.setEmpresa(empresa);
                caso.setCliente(cliente);
                caso.setUsuario(usuario);

            }

            pstm.close();
            return caso;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Casos Completo: " + erro);
            return null;
        }
    }

    public Caso buscarCasoCompletoSemUsuario(int idCaso) {
        try {
            String sql = "SELECT * " +
                    "FROM caso " +
                    "WHERE caso.cas_id = ? ";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idCaso);
            ResultSet rs = pstm.executeQuery();

            Caso caso = null;

            if (rs.next()) {
                caso = new Caso();

                //Caso
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setResolucao(rs.getString("cas_resolucao"));

                //Empresa
                Empresa empresa = new Empresa();
                empresa.setCnpj(rs.getString("emp_cnpj"));

                //Usuario
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("usu_id"));

                //Clente
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoaisCliente = new DadosPessoais();
                dadosPessoaisCliente.setCpf(rs.getString("cli_cpf"));
                cliente.setDadosPessoais(dadosPessoaisCliente);

                caso.setEmpresa(empresa);
                caso.setCliente(cliente);
                caso.setUsuario(usuario);
            }

            pstm.close();
            return caso;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Casos Completo: " + erro);
            return null;
        }
    }

    public Integer buscarNumeroDeCasosPorStatusPorIdDoUsuarioPorMes(int idUsuario, String status, int mes){
        int result = 0;

        String sql = "SELECT COUNT(*) AS total " +
                "FROM caso " +
                "WHERE cas_status = ? AND usu_id = ? AND MONTH(cas_data_de_abertura) = ? ";

        try {
            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, status);
            pstm.setInt(2, idUsuario);
            pstm.setInt(3, mes);

            ResultSet rs = pstm.executeQuery();
            if(rs.next())
                result = rs.getInt("total") ;

            pstm.close();

        }catch (SQLException e){
            System.out.println("Erro ao consultar caso por status e Id: " + e);
        }

        return result;
    }
}
