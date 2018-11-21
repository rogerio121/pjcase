package br.com.pjcase.util;

import org.apache.commons.mail.*;

import java.net.URL;

public class EnvioDeEmail {

    public EnvioDeEmail() {
    }

    public void enviarEmail(String emailDeDestino, String assunto, String corpo)throws EmailException {

        HtmlEmail email = new HtmlEmail();
        email.setHostName("smtp.googlemail.com");
        email.setFrom("rogeriodominus@gmail.com");
        email.setSubject(assunto);

        // set the html message
        email.setTextMsg("Your email client does not support HTML messages");
        email.setAuthenticator(new DefaultAuthenticator("rogeriodominus@gmail.com", "Cavaleiros123"));
        //email.setAuthentication("rogeriodominus@gmail.com", "Cavaleiros123");
        email.setSSLOnConnect(true);
        email.setFrom(emailDeDestino);
        email.setSubject(assunto);
        email.setMsg(corpo);
        email.setHtmlMsg("<html>The apache logo - <p>"+corpo+"</p></html>");
        email.addTo(emailDeDestino);
        email.send();

    }
}
