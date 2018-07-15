package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.Cliente;
import br.com.pjcase.model.DadosPessoais;
import br.com.pjcase.model.Usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoCliente {

    Connection conexao;

    public DaoCliente(){
        conexao = ConexaoBanco.getConexao();
    }

    /*----------------CRUD----------------*/
    public void insert(Cliente cliente) {
        try {
            String sql = "INSERT INTO cliente (cli_cpf, cli_nome, cli_email, cli_logradouro, cli_bairro, cli_cidade, cli_estado, cli_cep)" +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, cliente.getDadosPessoais().getCpf());
            pstm.setString(2, cliente.getDadosPessoais().getNome());
            pstm.setString(3, cliente.getDadosPessoais().getEmail());
            pstm.setString(4, cliente.getDadosPessoais().getLogradouro());
            pstm.setString(5, cliente.getDadosPessoais().getBairro());
            pstm.setString(6, cliente.getDadosPessoais().getCidade());
            pstm.setString(7, cliente.getDadosPessoais().getEstado());
            pstm.setString(8, cliente.getDadosPessoais().getCep());

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao inserir Cliente: " + erro);
        }
    }

    public void update(Cliente cliente) {
        try {
            //Empresa empresaCadastrada = getById(empresa.getCnpj());

            String sql = "UPDATE cliente SET cli_cpf = ?, cli_nome = ?, cli_email = ?, cli_logradouro = ?, cli_bairro = ?," +
                    " cli_cidade = ?, cli_estado = ?, cli_cep = ? " +
                    "WHERE cli_email = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, cliente.getDadosPessoais().getCpf());
            pstm.setString(2, cliente.getDadosPessoais().getNome());
            pstm.setString(3, cliente.getDadosPessoais().getEmail());
            pstm.setString(4, cliente.getDadosPessoais().getLogradouro());
            pstm.setString(5, cliente.getDadosPessoais().getBairro());
            pstm.setString(6, cliente.getDadosPessoais().getCidade());
            pstm.setString(7, cliente.getDadosPessoais().getEstado());
            pstm.setString(8, cliente.getDadosPessoais().getCep());
            pstm.setString(9, cliente.getDadosPessoais().getEmail());

            pstm.execute();
            pstm.close();
        } catch (SQLException erro) {
            System.out.println("Erro ao atualizar Cliente: " + erro);
        }
    }

    public void delete(String idCliente) {
        try {
            String sql = "DELETE FROM cliente WHERE cli_cpf = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCliente);

            pstm.execute();
        } catch (SQLException erro) {
            System.out.println("Erro ao deletar Cliente: " + erro);
        }
    }

    public Cliente getById(String idCliente) {
        try {
            String sql = "SELECT * " +
                         "FROM cliente " +
                         "WHERE cli_cpf = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idCliente);
            ResultSet rs = pstm.executeQuery();

            Cliente cliente = null;
            if (rs.next()) {
                cliente = new Cliente();
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setCpf(rs.getString("cli_cpf"));
                dadosPessoais.setNome(rs.getString("cli_nome"));
                dadosPessoais.setEmail(rs.getString("cli_email"));
                dadosPessoais.setLogradouro(rs.getString("cli_logradouro"));
                dadosPessoais.setBairro(rs.getString("cli_bairro"));
                dadosPessoais.setCidade(rs.getString("cli_cidade"));
                dadosPessoais.setEstado(rs.getString("cli_estado"));
                dadosPessoais.setCep(rs.getString("cli_cep"));
                cliente.setDadosPessoais(dadosPessoais);
            }

            pstm.close();
            return cliente;
        } catch (SQLException erro) {
            System.out.println("Erro ao buscar Cliente por Id: " + erro);
            return null;
        }
    }

    public void upsert(Cliente cliente) {
        Cliente clienteCadastrado = getById(cliente.getDadosPessoais().getCpf());

        if (clienteCadastrado.getDadosPessoais() == null)
            insert(cliente);
        else
            update(cliente);
    }
    /*------------FIM-CRUD----------------*/

    public List<Cliente> buscaClientesPertecentesEmpresa(String idEmpresa) {
        List<Cliente> clientes = new ArrayList<Cliente>();

        try {
            String sql = "SELECT * " +
                    "FROM cliente c " +
                    "JOIN cliente_de_empresa ce " +
                    "ON c.cli_email = ce.cli_email " +
                    "WHERE ce.emp_cnpj = ?";

            PreparedStatement pstm = conexao.prepareStatement(sql);
            pstm.setString(1, idEmpresa);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                Cliente cliente = new Cliente();
                DadosPessoais dadosPessoais = new DadosPessoais();

                dadosPessoais.setCpf(rs.getString("cli_cpf"));
                dadosPessoais.setNome(rs.getString("cli_nome"));
                dadosPessoais.setEmail(rs.getString("cli_email"));
                dadosPessoais.setLogradouro(rs.getString("cli_logradouro"));
                dadosPessoais.setBairro(rs.getString("cli_bairro"));
                dadosPessoais.setCidade(rs.getString("cli_cidade"));
                dadosPessoais.setEstado(rs.getString("cli_estado"));
                dadosPessoais.setCep(rs.getString("cli_cep"));
                cliente.setDadosPessoais(dadosPessoais);

                clientes.add(cliente);
            }

            return clientes;
        } catch (SQLException erro) {
            System.out.println("Erro ao Clientes vinculados a empresa do usuário: " + erro);
        }

        return null;
    }

}