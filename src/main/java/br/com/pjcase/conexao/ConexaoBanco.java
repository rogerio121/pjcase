package br.com.pjcase.conexao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexaoBanco {

    public static String statusBanco = "Não conectado ...";

    //--------------- SetUp banco ---------------//
    public static String driverName = "com.mysql.cj.Driver";
    public static String serverName = "localhost";
    public static String mydatabase = "banco_everson";
    public static String timezone = "?useTimezone=true&serverTimezone=UTC";
    public static String url = "jdbc:mysql://" + serverName + "/" + mydatabase + timezone;
    public static String username = "root";
    public static String password = "";

    // Método que pega conec
    public static java.sql.Connection getConexao() {
        Connection connection = null;

        try {
            try {
                Class.forName("com.mysql.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.out.println("Erro na Classe ConexaoBanco Class.forName: " + e);
            }
            connection = DriverManager.getConnection(url, username, password);

            //Testa sua conexão//

            if (connection != null)
                statusBanco = ("STATUS--->Conectado com sucesso!");
            else
                statusBanco = ("STATUS--->Não foi possivel realizar conexão");

            return connection;
        } catch (SQLException erro) {
            System.out.println("ão foi possivel realizar conexão: " + erro);

            return null;
        }
    }


    // Método que retorna o status da sua conexão//
    public static String statusConection() {
        return statusBanco;
    }

    // Método que fecha sua conexão//
    public static boolean FecharConexao() {
        try {
            ConexaoBanco.getConexao().close();
            return true;

        } catch (SQLException erro) {
            System.out.println("Erro ao fechar a conexão: " + erro);
            return false;
        }
    }

    // Método que reinicia sua conexão//
    public static java.sql.Connection ReiniciarConexao() {
        FecharConexao();
        return ConexaoBanco.getConexao();
    }

}