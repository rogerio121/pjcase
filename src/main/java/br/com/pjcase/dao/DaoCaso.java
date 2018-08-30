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
    public void insert(Caso caso) {
        try {
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


        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Caso: " + erro);
        }
    }

    public void update(Caso caso) {
        try {
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
        } catch (SQLException erro) {
            System.out.println("Erro ao atualizar Caso: " + erro);
        }
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

    public void upsert(Caso caso) {
        Caso casoCadastrado = null;
        casoCadastrado = getById(String.valueOf(caso.getIdCaso()));

        DateFormat formatoDaData = new SimpleDateFormat("yyyy-MM-dd");
        Date data = new Date();

        if (casoCadastrado == null) {
            caso.setDataDeAbertura(formatoDaData.format(data));
            insert(caso);
        } else {
            caso.setDataDeAbertura(casoCadastrado.getDataDeAbertura());

            if (!casoCadastrado.getStatus().equals("Fechado") && caso.getStatus().equals("Fechado"))
                caso.setDataDeFechamento(formatoDaData.format(data));
            else
                caso.setDataDeFechamento(null);
            update(caso);
        }
    }
    /*------------FIM-CRUD----------------*/

    public List<Caso> listarCasosSemProprietarios() {
        try {
            String sql = "SELECT *" +
                    "FROM caso " +
                    "WHERE usu_id IS NULL " +
                    "ORDER BY cas_id desc";

            PreparedStatement pstm = conexao.prepareStatement(sql);
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

    public List<Caso> listarCasosPorProprietarios(int idUsuario) {
        try {
            String sql = "SELECT * " +
                    "FROM caso " +
                    "inner join usuario on caso.usu_id = usuario.usu_id " +
                    "join empresa " +
                    "join cliente " +
                    "WHERE caso.usu_id = ? " +
                    "ORDER BY cas_id desc";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            ResultSet rs = pstm.executeQuery();

            System.out.println(pstm);
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

                casos.add(caso);
            }

            pstm.close();
            return casos;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Casos por Id do usuario: " + erro);
            return null;
        }
    }

    public List<Caso> listarTodosOsCasos() {
        try {
            String sql = "SELECT * " +
                    "FROM caso " +
                    "inner join usuario on caso.usu_id = usuario.usu_id " +
                    "join empresa " +
                    "join cliente " +
                    "ORDER BY cas_id desc";

            PreparedStatement pstm = conexao.prepareStatement(sql);
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

    public Integer buscarNumeroDeCasosPorStatusPorIdDoUsuario(int idUsuario, String status){
        int result = 0;

        String sql = "SELECT COUNT(*) AS total " +
                    "FROM caso " +
                    "WHERE cas_status = ? AND usu_id = ?";

        try {
            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, status);
            pstm.setInt(2, idUsuario);

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
