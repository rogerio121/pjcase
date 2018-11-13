package br.com.pjcase.util;

public class Data {
    public static String formatarFataFormatoBanco(String data){
        String dataFormatada = "";
        if(data.contains("/")) {
            String[] dataSplit = data.split("/");
            dataFormatada = dataSplit[2]+"-"+dataSplit[1]+"-"+dataSplit[0];
        }
        return dataFormatada;
    }
}
