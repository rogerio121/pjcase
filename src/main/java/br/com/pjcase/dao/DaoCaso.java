package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.DadosPessoais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
            if (!caso.getIdUsuarioRelacionado().isEmpty()) {
                sql = "INSERT INTO caso (cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, usu_id, cli_cpf)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pstm = conexao.prepareStatement(sql);
                pstm.setString(1, caso.getAssunto());
                pstm.setString(2, caso.getDataDeAbertura());
                pstm.setString(3, caso.getDataDeFechamento());
                pstm.setString(4, caso.getMensagem());
                pstm.setString(5, caso.getStatus());
                pstm.setString(6, caso.getIdEmpresaRelacionada());
                pstm.setString(7, caso.getIdUsuarioRelacionado());
                pstm.setString(8, caso.getIdClienteRelacionado());

                pstm.execute();
                pstm.close();
            }else {
                sql = "INSERT INTO caso (cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, cli_cpf)" +
                        "VALUES (?, ?, ?, ?, ?, ?, ?)";

                PreparedStatement pstm = conexao.prepareStatement(sql);
                pstm.setString(1, caso.getAssunto());
                pstm.setString(2, caso.getDataDeAbertura());
                pstm.setString(3, caso.getDataDeFechamento());
                pstm.setString(4, caso.getMensagem());
                pstm.setString(5, caso.getStatus());
                pstm.setString(6, caso.getIdEmpresaRelacionada());
                pstm.setString(7, caso.getIdClienteRelacionado());

                pstm.execute();
                pstm.close();
            }


        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Caso: " + erro);
        }
    }

    public void update(Caso caso) {
        try {
            String sql = "UPDATE caso SET cas_assusnto = ?, cas_data_de_abertura = ?, cas_data_de_fechamento = ?, cas_menssagem = ?, cas_status = ?, " +
                    "emp_cnpj = ?, usu_id = ?, cli_cpf = ?  " +
                    "WHERE cas_id = ?";


            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, caso.getAssunto());
            pstm.setString(2, caso.getDataDeAbertura());
            pstm.setString(3, caso.getDataDeFechamento());
            pstm.setString(4, caso.getMensagem());
            pstm.setString(5, caso.getStatus());
            pstm.setString(6, caso.getIdEmpresaRelacionada());
            pstm.setString(7, caso.getIdUsuarioRelacionado());
            pstm.setString(8, caso.getIdClienteRelacionado());
            pstm.setInt(9, caso.getIdCaso());

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
                String sql = "SELECT cas_id, cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, usu_id, cli_cpf " +
                    "FROM caso " +
                    "WHERE cas_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCaso);
            ResultSet rs = pstm.executeQuery();

            Caso caso = null;
            if (rs.next()) {
                caso = new Caso();
                DadosPessoais dadosPessoais = new DadosPessoais();

                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setIdUsuarioRelacionado(rs.getString("usu_id"));
                caso.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                caso.setIdClienteRelacionado(rs.getString("cli_cpf"));
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
        System.out.println(casoCadastrado == null);
        System.out.println(casoCadastrado);
        if (casoCadastrado == null)
            insert(caso);
        else
            update(caso);
    }
    /*------------FIM-CRUD----------------*/

    public List<Caso> listarCasosSemProprietarios() {
        try {
            String sql = "SELECT cas_id, cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, cli_cpf " +
                        "FROM caso " +
                        "WHERE usu_id IS NULL";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();

            Caso caso;
            List<Caso> casos = new ArrayList<Caso>();

            while (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                caso = new Caso();
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                caso.setIdClienteRelacionado(rs.getString("cli_cpf"));

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
            String sql = "SELECT cas_id, cas_assusnto, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, cli_cpf, usu_id " +
                    "FROM caso " +
                    "WHERE usu_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            ResultSet rs = pstm.executeQuery();

            Caso caso;
            List<Caso> casos = new ArrayList<Caso>();

            while (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                caso = new Caso();
                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setAssunto(rs.getString("cas_assusnto"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMensagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                caso.setIdClienteRelacionado(rs.getString("cli_cpf"));
                caso.setIdUsuarioRelacionado(rs.getString("usu_id"));

                casos.add(caso);
            }

            pstm.close();
            return casos;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Casos por Id do usuario: " + erro);
            return null;
        }
    }
}
