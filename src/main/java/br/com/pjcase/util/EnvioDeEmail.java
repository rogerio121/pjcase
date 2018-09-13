package br.com.pjcase.util;

import org.apache.commons.mail.DefaultAuthenticator;
import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class EnvioDeEmail {

    public EnvioDeEmail() {
    }

    public void enviarEmail(String emailDeDestino, String assunto, String corpo)throws EmailException {
        System.out.println(emailDeDestino);

        Email email = new SimpleEmail();
        email.setHostName("smtp.googlemail.com");
        //não é necessário, caso não passe ele usa a padrão
        email.setSmtpPort(465);
        email.setDebug(true);
        email.setAuthenticator(new DefaultAuthenticator("rogeriodominus@gmail.com", "Cavaleiros123"));
        //email.setAuthentication("rogeriodominus@gmail.com", "Cavaleiros123");
        email.setSSLOnConnect(true);
        email.setFrom("rogeriodominus@gmail.com");
        email.setSubject(assunto);
        email.setMsg(corpo);
        email.addTo(emailDeDestino);
        email.send();
    }
}
