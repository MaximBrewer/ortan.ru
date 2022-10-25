<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

class ControllerToolMail extends Controller
{

    public function index()
    {
        //Create an instance; passing `true` enables exceptions

        try {
            // Create the Transport
            $transport = (new Swift_SmtpTransport('smtp.ortan.ru', 587, 'tls'))
              ->setUsername('info@ortan.ru')
              ->setPassword('uF6dD3xF0ntB0t')
            ;
            
            // Create the Mailer using your created Transport
            $mailer = new Swift_Mailer($transport);
            
            // Create a message
            $message = (new Swift_Message('Wonderful Subject'))
              ->setFrom(['info@ortan.ru' => 'John Doe'])
              ->setTo(['test-isyqwcrs0@srv1.mail-tester.com'])
              ->setBody('Комплект защиты для велоспорта TRIPLE EIGHT K6 снижает риск получить ушибы. Состоит из шести предметов: наколенники, налокотники, защита запястий. Из прочного эластичного материала. По внутренней стороне идет мягкая подкладка, которая делает прилегание комфортным. Система вентиляции создает прохладу, исключая возможность образования парникового эффекта. Вставки из ударопрочного пластика. Размер регулируется специальными ремнями. Цвет желто-фиолетовый. Цена указана на сайте Ortan.ru. Купить и быстро оформить доставку по России можно в нашем интернет-магазине.')
              ;
            
            // Send the message
            $result = $mailer->send($message);
            echo 'Message has been sent';
        } catch (\Exception $e) {
            echo "Message could not be sent. Mailer Error: {$e->getMessage()}";
        }
        // try {


        //     $mail = new Mail();
        //     $mail->protocol = $this->config->get('config_mail_protocol');
        //     $mail->parameter = $this->config->get('config_mail_parameter');
        //     $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
        //     $mail->smtp_username = $this->config->get('config_mail_smtp_username');
        //     $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
        //     $mail->smtp_port = $this->config->get('config_mail_smtp_port');
        //     $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

        //     $mail->setTo('4e01jneg@spamtest.smtp.bz');
        //     $mail->setFrom('Ortan');
        //     $mail->setSender(html_entity_decode($this->config->get('config_email'), ENT_QUOTES, 'UTF-8'));
        //     $mail->setSubject(html_entity_decode('Комплект защиты для велоспорта'));
        //     $mail->setHtml('<p>Комплект защиты для велоспорта TRIPLE EIGHT K6 снижает риск получить ушибы. Состоит из шести предметов: наколенники, налокотники, защита запястий. Из прочного эластичного материала. По внутренней стороне идет мягкая подкладка, которая делает прилегание комфортным. Система вентиляции создает прохладу, исключая возможность образования парникового эффекта. Вставки из ударопрочного пластика. Размер регулируется специальными ремнями. Цвет желто-фиолетовый. Цена указана на сайте Ortan.ru. Купить и быстро оформить доставку по России можно в нашем интернет-магазине.</p>');
        //     $mail->setText('Комплект защиты для велоспорта TRIPLE EIGHT K6 снижает риск получить ушибы. Состоит из шести предметов: наколенники, налокотники, защита запястий. Из прочного эластичного материала. По внутренней стороне идет мягкая подкладка, которая делает прилегание комфортным. Система вентиляции создает прохладу, исключая возможность образования парникового эффекта. Вставки из ударопрочного пластика. Размер регулируется специальными ремнями. Цвет желто-фиолетовый. Цена указана на сайте Ortan.ru. Купить и быстро оформить доставку по России можно в нашем интернет-магазине.');
        //     $mail->send();
        // } catch (\Throwable $e) {
        //     echo $e->getMessage();
        // }
    }
}
