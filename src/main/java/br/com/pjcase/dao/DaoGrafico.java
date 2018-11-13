package br.com.pjcase.dao;

import br.com.pjcase.conexao.ConexaoBanco;
import br.com.pjcase.model.DadoParaGrafico;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoGrafico {

    Connection conexao;

    public DaoGrafico() {
        conexao = ConexaoBanco.getConexao();
    }

    public List<DadoParaGrafico> buscarCasosParaGraficoCasosPorUsuário(){

        String sql = "SELECT count(*), usu_nome, cas_status,cas_data_de_abertura,cas_data_de_fechamento FROM caso " +
                     "INNER JOIN usuario ON caso.usu_id = usuario.usu_id " +
                     "GROUP BY usu_nome " +
                     "ORDER BY cas_data_de_abertura  " +
                     "LIMIT 1000 ";

        List <DadoParaGrafico> dadosParaGrafico = new ArrayList<>();

        try {
            PreparedStatement pstm = conexao.prepareStatement(sql);

            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                DadoParaGrafico dadoParaGrafico = new DadoParaGrafico();

                dadoParaGrafico.setCount(rs.getInt("count(*)"));
                dadoParaGrafico.setDadoReferenteAoCont(rs.getString("usu_nome"));
                dadoParaGrafico.setStatusDoCaso(rs.getString("cas_status"));
                dadoParaGrafico.setDataAberturaDoCaso(rs.getString("cas_data_de_abertura"));
                dadoParaGrafico.setDataFechamentoDoCaso(rs.getString("cas_data_de_fechamento"));

                dadosParaGrafico.add(dadoParaGrafico);
            }

            pstm.close();

        }catch (SQLException e){
            System.out.println("Erro ao consultar caso para gráfico: " + e);
        }

        return dadosParaGrafico;
    }

    public List<DadoParaGrafico> buscarCasosParaGraficoCasosPorUsuário(String status, String dataInicio, String dataFim){

        String sql = "SELECT count(*), usu_nome, cas_status,cas_data_de_abertura,cas_data_de_fechamento FROM caso " +
                     "INNER JOIN usuario ON caso.usu_id = usuario.usu_id ";
        List <DadoParaGrafico> dadosParaGrafico = new ArrayList<>();
        PreparedStatement pstm;
        try {
            if(status.equals("*")){
                sql +=  "WHERE cas_data_de_abertura >= ? " +
                        "GROUP BY usu_nome, cas_status " +
                        "ORDER BY cas_data_de_abertura  " +
                        "LIMIT 1000 ";

                pstm = conexao.prepareStatement(sql);
                pstm.setString(1, dataInicio);
            }else {
                if(status.equals("Fechado")) {
                    sql += "WHERE cas_status = ? AND cas_data_de_abertura >= ? AND cas_data_de_fechamento <= ? " +
                            "GROUP BY usu_nome, cas_status " +
                            "ORDER BY cas_data_de_abertura  " +
                            "LIMIT 1000 ";

                    pstm = conexao.prepareStatement(sql);
                    pstm.setString(1, status);
                    pstm.setString(2, dataInicio);
                    pstm.setString(3, dataFim);
                }else {
                    sql += "WHERE cas_status = ? AND cas_data_de_abertura >= ?" +
                            "GROUP BY usu_nome, cas_status " +
                            "ORDER BY cas_data_de_abertura  " +
                            "LIMIT 1000 ";

                    pstm = conexao.prepareStatement(sql);
                    pstm.setString(1, status);
                    pstm.setString(2, dataInicio);
                }
            }

            System.out.println(pstm);
            ResultSet rs = pstm.executeQuery();
            while(rs.next()){
                DadoParaGrafico dadoParaGrafico = new DadoParaGrafico();

                dadoParaGrafico.setCount(rs.getInt("count(*)"));
                dadoParaGrafico.setDadoReferenteAoCont(rs.getString("usu_nome"));
                dadoParaGrafico.setStatusDoCaso(rs.getString("cas_status"));
                dadoParaGrafico.setDataAberturaDoCaso(rs.getString("cas_data_de_abertura"));
                dadoParaGrafico.setDataFechamentoDoCaso(rs.getString("cas_data_de_fechamento"));

                dadosParaGrafico.add(dadoParaGrafico);
            }

            pstm.close();

        }catch (SQLException e){
            System.out.println("Erro ao consultar caso para gráfico filtrado: " + e);
        }

        return dadosParaGrafico;
    }
}
