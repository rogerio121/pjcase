package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Empresa;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoEmpresa{

	Connection conexao;

	public DaoEmpresa() {
		conexao = ConexaoBanco.getConexao();
	}

	/*----------------CRUD----------------*/
	public void insert(Empresa empresa){
		try {
			String sql = "INSERT INTO empresa (emp_cnpj, emp_nome, emp_logradouro, emp_bairro, emp_cidade, emp_estado, emp_cep)" +
					"VALUES (?, ?, ?, ?, ?, ?, ?)";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, empresa.getCnpj());
			pstm.setString(2, empresa.getNome());
			pstm.setString(3, empresa.getLogradouro());
			pstm.setString(4, empresa.getBairro());
			pstm.setString(5, empresa.getCidade());
			pstm.setString(6, empresa.getEstado());
			pstm.setString(7, empresa.getCep());

			pstm.execute();
		}catch (SQLException erro){
			System.out.println("Erro ao inserir Empresa: " + erro);
		}
	}

	public void update(Empresa empresa){
		try {
			//Empresa empresaCadastrada = getById(empresa.getCnpj());

			String sql = "UPDATE empresa SET emp_cnpj = ?, emp_nome = ?, emp_logradouro = ?, emp_bairro = ?, emp_cidade = ?, emp_estado = ?, emp_cep = ? "+
					"WHERE emp_cnpj = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, empresa.getCnpj());
			pstm.setString(2, empresa.getNome());
			pstm.setString(3, empresa.getLogradouro());
			pstm.setString(4, empresa.getBairro());
			pstm.setString(5, empresa.getCidade());
			pstm.setString(6, empresa.getEstado());
			pstm.setString(7, empresa.getCep());
			pstm.setString(8, empresa.getCnpj());

			pstm.execute();
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
		}catch (SQLException erro){
			System.out.println("Erro ao deletar Empresa: " + erro);
		}
	}

	public Empresa getById(String idEmpresa){
		try {
			String sql = "SELECT * " +
						 "FROM empresa " +
						 "WHERE emp_cnpj = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, idEmpresa);
			ResultSet rs = pstm.executeQuery();

			Empresa empresa = new Empresa();
			if (rs.next()){
				empresa.setCnpj(rs.getString("emp_cnpj"));
				empresa.setNome(rs.getString("emp_nome"));
				empresa.setLogradouro(rs.getString("emp_logradouro"));
				empresa.setBairro(rs.getString("emp_bairro"));
				empresa.setCidade(rs.getString("emp_cidade"));
				empresa.setEstado(rs.getString("emp_estado"));
				empresa.setCep(rs.getString("emp_cep"));
			}

			return empresa;
		}catch (SQLException erro){
			System.out.println("Erro ao buscar Empresa por Id: " + erro);
		}

		return null;
	}

	public void upsert(Empresa empresa){
		Empresa empresaCadastrada = getById(empresa.getCnpj());

		if (empresaCadastrada.getCnpj() == null)
			insert(empresa);
		else
			update(empresa);
	}
	/*------------FIM-CRUD----------------*/

	public List<Empresa> buscaEmpresasCadastradas(){
		try {
			String sql = "SELECT *" +
					"FROM empresa ";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			ResultSet rs = pstm.executeQuery();

			List<Empresa> empresasCadastradas = new ArrayList<Empresa>();

			while (rs.next()){
				Empresa empresa = new Empresa();

				empresa.setCnpj(rs.getString("emp_cnpj"));
				empresa.setNome(rs.getString("emp_nome"));
				empresa.setLogradouro(rs.getString("emp_logradouro"));
				empresa.setBairro(rs.getString("emp_bairro"));
				empresa.setCidade(rs.getString("emp_cidade"));
				empresa.setEstado(rs.getString("emp_estado"));
				empresa.setCep(rs.getString("emp_cep"));

				empresasCadastradas.add(empresa);
			}

			return empresasCadastradas;
		}catch (SQLException erro){
			System.out.println("Erro ao buscar Empresa por Id: " + erro);
		}

		return null;
	}
}
