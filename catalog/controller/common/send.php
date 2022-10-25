<?php
class ControllerCommonSend extends Controller
{
    protected function validate()
    {
        if (!isset($this->request->post['gift-email'])) {
            $this->error['warning'] = $this->language->get('error_email');
        } elseif (!filter_var($this->request->post['gift-email'], FILTER_VALIDATE_EMAIL)) {
            $this->error['warning'] = $this->language->get('error_email');
        }
        return !$this->error;
    }

    public function index()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            $subject = 'Подарок от компании ORTAN - ПРОМОКОД';

            $text  = "Здравствуйте.\n
            Мы очень рады вручить промокод на подарок от нашей компании.\n
            Промокод: ORTAN_2022\n
            Промокод действует в течении 5 дней и при заказе от трех товаров.\n
            После заказа, с вами свяжется менеджер для уточнения деталей по заказу, необходимо
            сообщить промокод.\n
            Если вы получили это письмо по ошибке - ничего делать не нужно, мы вас больше не
            побеспокоим.";

            $html = "<h3>Здравствуйте.</h3>
            <p>Мы очень рады вручить промокод на подарок от нашей компании.</p>
            <h4 style=\"color:grey\">Промокод: ORTAN_2022</h4>
            <p><img src=\"https://ortan.ru/image/gift.png\" title=\"\" alt=\"\"/></p>
            <p>Промокод действует в течении 5 дней и при заказе от трех товаров.</p>
            <p>После заказа, с вами свяжется менеджер для уточнения деталей по заказу, необходимо
            сообщить промокод.</p>
            <p>Если вы получили это письмо по ошибке - ничего делать не нужно, мы вас больше не
            побеспокоим.</p>";


            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

            $mail->setTo($this->request->post['gift-email']);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));

            $mail->setHtml($html);
            $mail->setText(html_entity_decode($text, ENT_QUOTES, 'UTF-8'));
            $mail->send();

            file_put_contents($_SERVER['DOCUMENT_ROOT'] . "/mails.txt", $this->request->post['gift-email'] . PHP_EOL, FILE_APPEND);
            $this->session->data['success'] = "Спасибо, мы отправили Вам промокод!";
        }
        $this->response->redirect($this->url->link('common/home', '', true));
    }
}
