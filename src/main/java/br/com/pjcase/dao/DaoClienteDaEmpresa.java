package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DaoClienteDaEmpresa {

    Connection conexao;

    public DaoClienteDaEmpresa(){
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(String idCliente, String idEmpresa) throws SQLException {
        String sql = "INSERT INTO cliente_da_empresa (cli_cpf, emp_cnpj) " +
                "VALUES (?, ?)";

        PreparedStatement pstm = conexao.prepareStatement(sql);
        pstm.setString(1, idCliente);
        pstm.setString(2, idEmpresa);

        pstm.execute();
        pstm.close();
    }

    public void delete(String idCliente) throws SQLException {
        String sql = "DELETE FROM cliente_da_empresa " +
                "WHERE cli_cpf = ?";

        PreparedStatement pstm = conexao.prepareStatement(sql);
        pstm.setString(1, idCliente);

        pstm.execute();
        pstm.close();
    }
}
