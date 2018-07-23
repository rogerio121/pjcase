package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class DaoUsuario {

    Connection conexao;

    public DaoUsuario() {
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(Usuario usuario) {
        try {
            String sql = "INSERT INTO usuario (usu_email, usu_nome, usu_senha, usu_admin)" +
                    "VALUES (?, ?, ?, ?)";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, usuario.getDadosPessoais().getEmail());
            pstm.setString(2, usuario.getDadosPessoais().getNome());
            pstm.setString(3, usuario.getSenha());
            pstm.setBoolean(4, usuario.getAdmin());

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Usuario: " + erro);
        }
    }

    public void update(Usuario usuario) {
        try {
            //Empresa empresaCadastrada = getById(empresa.getCnpj());

            String sql = "UPDATE usuario SET usu_email = ?, usu_nome = ?, usu_senha = ?, usu_admin = ?" +
                    "WHERE usu_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, usuario.getDadosPessoais().getEmail());
            pstm.setString(2, usuario.getDadosPessoais().getNome());
            pstm.setString(3, usuario.getSenha());
            pstm.setBoolean(4, usuario.getAdmin());
            pstm.setInt(5, usuario.getId());

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao atualizar Usuario: " + erro);
        }
    }

    public void delete(int idUsuario) {
        try {
            String sql = "DELETE FROM usuario WHERE usu_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idUsuario);

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Usuario: " + erro);
        }
    }

    public Usuario getById(int idUsuario) {
        try {
            String sql = "SELECT * " +
                    "FROM usuario " +
                    "WHERE usu_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            ResultSet rs = pstm.executeQuery();

            Usuario usuario = new Usuario();
            if (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setNome(rs.getString("usu_nome"));
                dadosPessoais.setEmail(rs.getString("usu_email"));
                usuario.setSenha(rs.getString("usu_senha"));
                usuario.setAdmin(rs.getBoolean("usu_admin"));
                usuario.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                usuario.setId(rs.getInt("usu_id"));
                usuario.setDadosPessoais(dadosPessoais);

            }

            pstm.close();
            return usuario;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Usuario por Id: " + erro);
        }

        return null;
    }

    public void upsert(Usuario usuario) {
        Usuario usuarioCadastrado = getById(usuario.getId());

        if (usuarioCadastrado.getDadosPessoais() == null)
            insert(usuario);
        else
            update(usuario);
    }
    /*------------FIM-CRUD----------------*/

    public Usuario getByEmailESenha(String idUsuario, String senha) {
        try {
            String sql = "SELECT * " +
                    "FROM usuario " +
                    "WHERE usu_email = ? AND usu_senha = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idUsuario);
            pstm.setString(2, senha);
            ResultSet rs = pstm.executeQuery();

            Usuario usuario = null;
            if (rs.next()) {
                usuario = new Usuario();
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setNome(rs.getString("usu_nome"));
                dadosPessoais.setEmail(rs.getString("usu_email"));
                usuario.setSenha(rs.getString("usu_senha"));
                usuario.setAdmin(rs.getBoolean("usu_admin"));
                usuario.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                usuario.setId(rs.getInt("usu_id"));
                usuario.setDadosPessoais(dadosPessoais);
            }

            pstm.close();
            return usuario;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Usuario por usuario e senha: " + erro);
            return null;
        }
    }

    public List<Usuario> buscarTodosUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        try {
            String sql = "SELECT * " +
                    "FROM usuario ";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();

            Usuario usuario;
            while (rs.next()) {
                usuario = new Usuario();
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setNome(rs.getString("usu_nome"));
                dadosPessoais.setEmail(rs.getString("usu_email"));
                usuario.setSenha(rs.getString("usu_senha"));
                usuario.setAdmin(rs.getBoolean("usu_admin"));
                usuario.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                usuario.setId(rs.getInt("usu_id"));
                usuario.setDadosPessoais(dadosPessoais);

                usuarios.add(usuario);
            }

            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar todos os usuario: " + erro);
            return null;
        }
        return usuarios;
    }

    public Usuario buscaPorIdentificador(int idUsuario) {
        try {
            String sql = "SELECT * " +
                    "FROM usuario " +
                    "WHERE usu_id = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setInt(1, idUsuario);
            ResultSet rs = pstm.executeQuery();

            Usuario usuario = new Usuario();
            if (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setNome(rs.getString("usu_nome"));
                dadosPessoais.setEmail(rs.getString("usu_email"));
                usuario.setSenha(rs.getString("usu_senha"));
                usuario.setAdmin(rs.getBoolean("usu_admin"));
                usuario.setIdEmpresaRelacionada(rs.getString("emp_cnpj"));
                usuario.setDadosPessoais(dadosPessoais);
                usuario.setId(rs.getInt("usu_id"));

            }

            pstm.close();
            return usuario;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Usuario por Id: " + erro);
        }

        return null;
    }
}
