<?php

namespace Mail;

class Smtp
{
	protected string $to = '';
	protected string $from = '';
	protected string $sender = '';
	protected string $reply_to = '';
	protected string $subject = '';
	protected string $text = '';
	protected string $html = '';
	protected array $attachments = [];
	protected string $smtp_hostname = '';
	protected string $smtp_username = '';
	protected string $smtp_password = '';
	protected int $smtp_port = 25;
	protected int $smtp_timeout = 5;
	protected int $max_attempts = 3;
	protected bool $verp = false;

	public function __construct(array $args)
	{
		foreach ($args as $key => $value) {
			if (property_exists($this, $key)) {
				$this->{$key} = $value;
			}
		}
	}

	public function send(): bool
	{
		foreach ($this->attachments as $attachment) {
			if (file_exists($attachment)) {
				$handle = fopen($attachment, 'r');

				$content = fread($handle, filesize($attachment));

				fclose($handle);
			}
		}

		if (substr($this->smtp_hostname, 0, 3) == 'tls') {
			$protocol = 'tls';
			$hostname = substr($this->smtp_hostname, 6);
		} elseif (substr($this->smtp_hostname, 0, 3) == 'ssl') {
			$protocol = 'ssl';
			$hostname = substr($this->smtp_hostname, 6);
		} else {
			$hostname = $this->smtp_hostname;
		}

		// Create the Transport
		$transport = (new \Swift_SmtpTransport($hostname, $this->smtp_port, $protocol))
			->setUsername($this->smtp_username)
			->setPassword($this->smtp_password);

		// Create the Mailer using your created Transport
		$mailer = new \Swift_Mailer($transport);

		// Create a message
		$message = (new \Swift_Message($this->subject))
			->setFrom([$this->from => $this->sender])
			->setTo($this->to)
			->setBody($this->html, 'text/html')
			->addPart($this->text, 'text/plain');

		// Send the message
		$result = $mailer->send($message);

		return $result;
	}

	private function handleReply($handle, $status_code = false, $error_text = false, $counter = 0)
	{
		$reply = '';

		while (($line = fgets($handle, 515)) !== false) {
			$reply .= $line;

			if (substr($line, 3, 1) == ' ') {
				break;
			}
		}

		// Handle slowish server responses (generally due to policy servers)
		if (!$line && empty($reply) && $counter < $this->max_attempts) {
			sleep(1);

			$counter++;

			return $this->handleReply($handle, $status_code, $error_text, $counter);
		}

		if ($status_code) {
			if (substr($reply, 0, 3) != $status_code) {
				throw new \Exception($error_text);
			}
		}

		return $reply;
	}
}
