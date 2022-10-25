<?php

use AmoCRM\Client\AmoCRMApiClient;
use Dotenv\Dotenv;
use AmoCRM\Exceptions\AmoCRMApiException;



class ControllerCommonAmoaccess extends Controller
{
    public function redirect()
    {
        file_put_contents($_SERVER['DOCUMENT_ROOT'] . "/system/storage/logs/amocrm.log", print_r($_REQUEST, true));
    }
    public function index()
    {
        $dotenv = Dotenv::createImmutable(DIR_ROOT_PATH);
        $dotenv->load();

        $clientId = $_ENV['AMO_ID'];
        $clientSecret = $_ENV['AMO_SECRET'];
        $authCode = 'def5020066a12a0f7302ef0e3fa9b304277d00ac7dc38d53ffd219f8eba5bc5dac75671c063680cfc53faeb4c9dc60aba1d8c8037f718162de08e99fb15d709d40a27f9bf536588233a39bba286efaaef900671c5d810c89bbc8fc26cd64917931363a2e6a0bd6af06fb98ba1d680b9c77cbf6d8876a76d6979874315d7e4120b1ba2f9aad0a71cb7c9f9b7b27530a62245b6cf8afea59d4163538808cded013a9ed5c82376f88566109b801a6081bfa711359463c7bdb660a0de1f3657cb007c7dcc723848a0dcb2ba80f05c98cb0fdc63c33f07da6eb37ac7fc91aaab69e6a37a8413b1374b61554e1b78e044a9632af865329dffd51ffc8ffca829c4e97096762bc752343bf7be9aba391e4288542ad55d81ba80418f4b8f97369211f1746fb8c7eea887c8cf6721c92a8f3de4e6a4ce3a8f97144ebbe7122bf5bf64c569bb3d5ae30e92409c612f775ca57ec6f29fe13f45e0e461761037e42a787ad0b0918c9fcf4784a433d6517be539ae063573876a327e435ad32d7e18f84d414447078aef280d329f0b793e9c90cd1b09601a09b708dde744070fd7b3a2eaf65b6f2b7ee5044157f3614893f67bf1cc1399c9cb6997a117e70ca786ba54a596588bc496ddbdb4897c5e2b2238196d7754130a65067a01aafa612e9f4156c2bd8bca812b3d8';
        $redirectUri = 'https://ortan.ru/index.php?route=common/parse/redirect';


        try {
            $apiClient = new AmoCRMApiClient($clientId, $clientSecret, $redirectUri);
            $apiClient->setAccountBaseDomain('infoortanru.amocrm.ru');
            $oAuthClient = $apiClient->getOAuthClient();
            $accessToken = $oAuthClient->getAccessTokenByCode($authCode);
            file_put_contents($_SERVER['DOCUMENT_ROOT'] . '/.htamocrm', json_encode(($accessToken)));
            var_dump($accessToken);
            die;
        } catch (AmoCRMApiException $e) {
            var_dump($e->getErrorCode());
            var_dump($e->getTitle());
            var_dump($e->getDescription());
            var_dump($e->getLastRequestInfo());
        }
    }
}
