package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Caso;
import br.com.pjcase.model.DadosPessoais;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoCaso {

    Connection conexao;

    public DaoCaso() {
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(Caso caso) {
        try {
            String sql = "INSERT INTO caso (cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, usu_email)" +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, caso.getDataDeAbertura());
            pstm.setString(2, caso.getDataDeFechamento());
            pstm.setString(3, caso.getMenssagem());
            pstm.setString(4, caso.getStatus());
            pstm.setString(5, caso.getIdEmpresaRelacionada());
            pstm.setString(6, caso.getIdUsuarioRelacionado());

            pstm.execute();
        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Caso: " + erro);
        }
    }

    public void update(Caso caso) {
        try {
            String sql = "UPDATE caso SET cas_data_de_abertura = ?, cas_data_de_fechamento = ?, cas_menssagem = ?, cas_status = ?, " +
                    "emp_cnpj = ?, usu_email = ? " +
                    "WHERE cas_id = ?";


            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, caso.getDataDeAbertura());
            pstm.setString(2, caso.getDataDeFechamento());
            pstm.setString(3, caso.getMenssagem());
            pstm.setString(4, caso.getStatus());
            pstm.setString(5, caso.getIdEmpresaRelacionada());
            pstm.setString(6, caso.getIdUsuarioRelacionado());
            pstm.setInt(7, caso.getIdCaso());

            pstm.execute();
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
        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Caso: " + erro);
        }
    }

    public Caso getById(String idCaso) {
        try {
            String sql = "SELECT cas_id, cas_data_de_abertura, cas_data_de_fechamento, cas_menssagem, cas_status, emp_cnpj, usu_email " +
                    "FROM caso " +
                    "WHERE cas_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCaso);
            ResultSet rs = pstm.executeQuery();

            Caso caso = new Caso();
            if (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                caso.setIdCaso(rs.getInt("cas_id"));
                caso.setDataDeAbertura(rs.getString("cas_data_de_abertura"));
                caso.setDataDeFechamento(rs.getString("cas_data_de_fechamento"));
                caso.setMenssagem(rs.getString("cas_menssagem"));
                caso.setStatus(rs.getString("cas_status"));
                caso.setIdUsuarioRelacionado(rs.getString("usu_email"));
                caso.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
            }

            return caso;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Caso por Id: " + erro);
        }

        return null;
    }

    public void upsert(Caso caso) {
        Caso casoCadastrado = getById(String.valueOf(caso.getIdCaso()));
        if (casoCadastrado == null)
            insert(caso);
        else
            update(caso);
    }
}
