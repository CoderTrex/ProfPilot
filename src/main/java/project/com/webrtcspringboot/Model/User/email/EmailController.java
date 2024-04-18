package project.com.webrtcspringboot.Model.User.email;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.Properties;

@Component
@PropertySource("classpath:application.properties")
public class EmailController {
    private static String type = "text/html; charset=utf-8";
    private static String emailAdd = "jsilvercastle@gmail.com";
    private static  String password = "rpgf ezyq gnkg zvlb";


    public static void sendEmailVerifyCode(String email, String code) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailAdd, password);
            }
        };

        Session session = Session.getInstance(properties, auth);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailAdd, "발신자이름"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("이메일 인증 코드");
            message.setContent("인증 코드는 " + code + "입니다.", type);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void sendEmailNewPassword(String username, String email, String newPassword) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable","true");
        properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailAdd, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailAdd,"발신자이름"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("새로운 비밀번호 발급");
            message.setContent("안녕하세요, " + username + "님. 새로운 비밀번호는 " + newPassword + "입니다.", type);
            Transport.send(message);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }


    //    this.userService.requestProfAuth(email);  해당 이메일을 서비스의 공식계정 이메일에 요청하는 이메일을 보내게 한다.
//    public void requestProfAuth(String email) {
//        EmailController.sendEmailProfAuth(email);
//    }
    public static void sendEmailProfAuth(String email, String profName) {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", 587);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(emailAdd, password);
            }
        };
        Session session = Session.getInstance(properties, auth);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailAdd, "발신자이름"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress("profpilotofficial@gmail.com"));
            message.setSubject("교수 인증 요청");
            message.setContent(profName + " (" + email + ") " + "님이 교수 인증을 요청하였습니다.", type);
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}