package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoCliente {

    Connection conexao;

    public DaoCliente(){
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(Cliente cliente) {
        try {
            String sql = "INSERT INTO cliente (cli_nome, cli_email)" +
                    "VALUES (?, ?)";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, cliente.getDadosPessoais().getNome());
            pstm.setString(2, cliente.getDadosPessoais().getEmail());

            pstm.execute();
        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Cliente: " + erro);
        }
    }

    public void update(Cliente cliente) {
        try {
            //Empresa empresaCadastrada = getById(empresa.getCnpj());

            String sql = "UPDATE cliente SET cli_nome = ?, cli_email = ?" +
                    "WHERE cli_email = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, cliente.getDadosPessoais().getNome());
            pstm.setString(2, cliente.getDadosPessoais().getEmail());
            pstm.setString(3, cliente.getDadosPessoais().getEmail());

            pstm.execute();
        } catch (SQLException erro) {
            System.out.println("Erro ao atualizar Cliente: " + erro);
        }
    }

    public void delete(String idCliente) {
        try {
            String sql = "DELETE FROM cliente WHERE cli_email = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCliente);

            pstm.execute();
        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Cliente: " + erro);
        }
    }

    public Cliente getById(String idCliente) {
        try {
            String sql = "SELECT cli_nome, cli_email " +
                         "FROM cliente " +
                         "WHERE cli_email = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCliente);
            ResultSet rs = pstm.executeQuery();

            Cliente cliente = new Cliente();
            if (rs.next()) {
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setNome(rs.getString("cli_nome"));
                dadosPessoais.setEmail(rs.getString("cli_email"));
                cliente.setDadosPessoais(dadosPessoais);
            }

            return cliente;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Cliente por Id: " + erro);
        }

        return null;
    }

    public void upsert(Cliente cliente) {
        Cliente clienteCadastrado = getById(cliente.getDadosPessoais().getEmail());

        if (clienteCadastrado.getDadosPessoais() == null)
            insert(cliente);
        else
            update(cliente);
    }
    /*------------FIM-CRUD----------------*/
}