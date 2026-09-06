package com.mthu.utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtil {
    private static Session buildSession() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", Constant.MAIL_HOST);
        props.put("mail.smtp.port", String.valueOf(Constant.MAIL_PORT));
        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Constant.MAIL_USERNAME, Constant.MAIL_PASSWORD);
            }
        });
    }

    public static void sendOtpMail(String toEmail, String otp, String purpose) throws MessagingException {
        Session session = buildSession();
        MimeMessage message = new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(Constant.MAIL_USERNAME, Constant.MAIL_FROM_NAME));
        } catch (Exception e) {
            throw new MessagingException("Lỗi tên người gửi", e);
        }
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Mã OTP xác thực - " + purpose, "UTF-8");
        message.setContent("<h2>Mã OTP của bạn: <b>" + otp + "</b></h2><p>Hết hạn sau "
                + Constant.OTP_EXPIRE_MINUTES + " phút.</p>", "text/html; charset=UTF-8");
        Transport.send(message);
    }
}