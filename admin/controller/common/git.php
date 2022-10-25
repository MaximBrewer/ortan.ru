<?php

use AmoCRM\Client\AmoCRMApiClient;
use AmoCRM\Exceptions\AmoCRMMissedTokenException;
use Symfony\Component\Dotenv\Dotenv;
use League\OAuth2\Client\Token\AccessToken;
use AmoCRM\Exceptions\AmoCRMApiException;
use AmoCRM\Models\LeadModel;
use AmoCRM\Models\ContactModel;
use AmoCRM\Client\AmoCRMApiRequest;
use AmoCRM\Collections\ContactsCollection;
use AmoCRM\Filters\ContactsFilter;



class ControllerCommonGit extends Controller
{
    public function verstka()
    {
        exec("git checkout verstka");
        echo "Verstka";
    }
    public function push()
    {
        exec("git checkout verstka");
        exec("git add .");
        exec("git commit -m \"Server\"");
        exec("git push --set-upstream origin verstka");
        echo "Push Verstka";
    }
}
