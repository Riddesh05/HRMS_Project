package model;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class GmailSender {
    public static void sendMail(String to,String subject,String messageText) throws MessagingException {
        final String from="riddeshsonawane05@gmail.com";
        final String password="stpr hnjl gggf mvda ";

        Properties props=new Properties();

        // set smtp server properties
        props.put("mail.smtp.auth","true");// this mean mail server requires username and password before sending
        //TLS: command for SMTP(add for secure connection).Transport Layer Security
        props.put("mail.smtp.starttls.enable","true");//STARTTLS upgrade the connection from plain text to
        // an encrypted connection
        props.put("mail.smtp.host","smtp.gmail.com");//"smtp.gmail.com" is gmails ongoing mail server
        props.put("mail.smtp.port","587");// standard port

        //create a new session with an authenticate
        Session session=Session.getInstance(
                props,
                new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return  new PasswordAuthentication(from ,password);
                    }
                }
        );


        Message message=new MimeMessage(session);

        message.setFrom(
                new InternetAddress(from));

        message.setRecipients(
                Message.RecipientType.TO,InternetAddress.parse(to) //convert into Internet addrwss
        );

        message.setSubject(subject);
        message.setText(messageText);
        Transport.send(message);
        System.out.println("Email send Successfully");
    }
}
