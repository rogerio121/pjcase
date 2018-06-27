package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUsuario{

	Connection conexao;

	public DaoUsuario() {
		conexao = ConexaoBanco.getConexao();
	}

	/*----------------CRUD----------------*/
	public void insert(Usuario usuario){
		try {
			String sql = "INSERT INTO usuario (usu_email, usu_nome, usu_senha)" +
					"VALUES (?, ?, ?)";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, usuario.getDadosPessoais().getEmail());
			pstm.setString(2, usuario.getDadosPessoais().getNome());
			pstm.setString(3, usuario.getSenha());

			pstm.execute();
		}catch (SQLException erro){
			System.out.println("Erro ao inserir Usuario: " + erro);
		}
	}

	public void update(Usuario usuario){
		try {
			//Empresa empresaCadastrada = getById(empresa.getCnpj());

			String sql = "UPDATE usuario SET usu_email = ?, usu_nome = ?, usu_senha = ?"+
					"WHERE usu_email = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, usuario.getDadosPessoais().getEmail());
			pstm.setString(2, usuario.getDadosPessoais().getNome());
			pstm.setString(3, usuario.getSenha());
			pstm.setString(4, usuario.getDadosPessoais().getEmail());

			pstm.execute();
		}catch (SQLException erro){
			System.out.println("Erro ao atualizar Usuario: " + erro);
		}
	}

	public void delete(String idUsuario){
		try {
			String sql = "DELETE FROM usuario WHERE usu_email = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, idUsuario);

			pstm.execute();
		}catch (SQLException erro){
			System.out.println("Erro ao deletar Usuario: " + erro);
		}
	}

	public Usuario getById(String idUsuario){
		try {
			String sql = "SELECT usu_email, usu_nome, usu_senha " +
						 "FROM usuario " +
						 "WHERE usu_email = ?";

			PreparedStatement pstm = conexao.prepareStatement(sql);
			pstm.setString(1, idUsuario);
			ResultSet rs = pstm.executeQuery();

			Usuario usuario = new Usuario();
			if (rs.next()){
				DadosPessoais dadosPessoais = new DadosPessoais();

				dadosPessoais.setNome(rs.getString("usu_nome"));
				dadosPessoais.setEmail(rs.getString("usu_email"));
				usuario.setSenha(rs.getString("usu_senha"));
				usuario.setDadosPessoais(dadosPessoais);
			}

			return usuario;
		}catch (SQLException erro){
			System.out.println("Erro ao buscar Usuario por Id: " + erro);
		}

		return null;
	}

	public void upsert(Usuario usuario){
		Usuario usuarioCadastrado = getById(usuario.getDadosPessoais().getEmail());

		if (usuarioCadastrado.getDadosPessoais().getEmail() == null)
			insert(usuario);
		else
			update(usuario);
	}
	/*------------FIM-CRUD----------------*/
}
