package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Empresa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DaoEmpresa{

	Connection conexao;

	public DaoEmpresa() {
		conexao = ConexaoBanco.getConexao();
	}

	public void insert(Empresa empresa){
		try {
			String sql = "INSERT INTO empresa (emp_cnpj, emp_nome, emp_logradouro, emp_bairro, emp_cidade, emp_estado)" +
					"VALUES (?, ?, ?, ?, ?, ?)";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, empresa.getCnpj());
			pstm.setString(2, empresa.getNome());
			pstm.setString(3, empresa.getLogradouro());
			pstm.setString(4, empresa.getBairro());
			pstm.setString(5, empresa.getCidade());
			pstm.setString(6, empresa.getEstado());

			pstm.execute();
			conexao.close();
		}catch (SQLException erro){
			System.out.println("Erro ao inserir Empresa: " + erro);
		}
	}

	public void update(Empresa empresa){
		try {
			String sql = "UPDATE empresa SET emp_cnpj = ?, emp_nome = ?, emp_logradouro = ?, emp_bairro = ?, emp_cidade = ?, emp_estado = ?"+
					"WHERE emp_cnpj = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, empresa.getCnpj());
			pstm.setString(2, empresa.getNome());
			pstm.setString(3, empresa.getLogradouro());
			pstm.setString(4, empresa.getBairro());
			pstm.setString(5, empresa.getCidade());
			pstm.setString(6, empresa.getEstado());
			pstm.setString(7, empresa.getCnpj());

			pstm.execute();
			conexao.close();
		}catch (SQLException erro){
			System.out.println("Erro ao atualizar Empresa: " + erro);
		}
	}

	public void delete(String idEmpresa){
		try {
			String sql = "DELETE FROM empresa WHERE emp_cnpj = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, idEmpresa);

			pstm.execute();
			conexao.close();
		}catch (SQLException erro){
			System.out.println("Erro ao atualizar Empresa: " + erro);
		}
	}
}
