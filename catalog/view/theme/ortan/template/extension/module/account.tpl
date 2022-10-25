<?php if (false) { ?>
  <?php if (!$logged) { ?>
    <a href="<?php echo $login; ?>" class="list-group-item"><?php echo $text_login; ?></a>
    <a href="<?php echo $register; ?>" class="list-group-item"><?php echo $text_register; ?></a>
    <a href="<?php echo $forgotten; ?>" class="list-group-item"><?php echo $text_forgotten; ?></a>
  <?php } ?>
  <a href="<?php echo $account; ?>" class="list-group-item"><?php echo $text_account; ?></a>
  <?php if ($logged) { ?>
    <a href="<?php echo $edit; ?>" class="list-group-item"><?php echo $text_edit; ?></a>
    <a href="<?php echo $password; ?>" class="list-group-item"><?php echo $text_password; ?></a>
  <?php } ?>
  <a href="<?php echo $address; ?>" class="list-group-item"><?php echo $text_address; ?></a>
  <a href="<?php echo $wishlist; ?>" class="list-group-item"><?php echo $text_wishlist; ?></a>
  <a href="<?php echo $order; ?>" class="list-group-item"><?php echo $text_order; ?></a>
  <a href="<?php echo $download; ?>" class="list-group-item"><?php echo $text_download; ?></a>
  <a href="<?php echo $recurring; ?>" class="list-group-item"><?php echo $text_recurring; ?></a>
  <a href="<?php echo $reward; ?>" class="list-group-item"><?php echo $text_reward; ?></a>
  <a href="<?php echo $return; ?>" class="list-group-item"><?php echo $text_return; ?></a>
  <a href="<?php echo $transaction; ?>" class="list-group-item"><?php echo $text_transaction; ?></a>
  <a href="<?php echo $newsletter; ?>" class="list-group-item"><?php echo $text_newsletter; ?></a>
  <?php if ($logged) { ?>
    <a href="<?php echo $logout; ?>" class="list-group-item"><?php echo $text_logout; ?></a>
  <?php } ?>
<?php } ?>
<div class="authForm__menu">
  <div class="authForm__userMenu">
    <svg id="Layer_1" enable-background="new 0 0 24 24" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg">
      <g>
        <path d="m9 10c-2.757 0-5-2.243-5-5s2.243-5 5-5 5 2.243 5 5-2.243 5-5 5zm0-9c-2.206 0-4 1.794-4 4s1.794 4 4 4 4-1.794 4-4-1.794-4-4-4z"></path>
      </g>
      <g>
        <path d="m8.5 21h-8c-.276 0-.5-.224-.5-.5v-4c0-2.481 2.019-4.5 4.5-4.5h6c.276 0 .5.224.5.5s-.224.5-.5.5h-6c-1.93 0-3.5 1.57-3.5 3.5v3.5h7.5c.276 0 .5.224.5.5s-.224.5-.5.5z"></path>
      </g>
      <g>
        <g>
          <path d="m17 20c-1.378 0-2.5-1.122-2.5-2.5s1.122-2.5 2.5-2.5 2.5 1.122 2.5 2.5-1.122 2.5-2.5 2.5zm0-4c-.827 0-1.5.673-1.5 1.5s.673 1.5 1.5 1.5 1.5-.673 1.5-1.5-.673-1.5-1.5-1.5z"></path>
        </g>
        <g>
          <path d="m17.797 24h-1.595c-.516 0-.944-.387-.995-.901l-.127-1.271c-.303-.135-.592-.303-.865-.503l-1.168.527c-.469.214-1.02.035-1.277-.412l-.797-1.381c-.258-.447-.136-1.011.282-1.312l1.029-.74c-.02-.155-.034-.327-.034-.507s.014-.353.034-.507l-1.029-.74c-.418-.301-.54-.865-.282-1.312l.797-1.381c.258-.447.806-.624 1.277-.412l1.168.527c.273-.2.562-.368.865-.503l.127-1.271c.051-.513.479-.9.995-.9h1.595c.516 0 .944.387.995.901l.127 1.271c.304.135.593.304.865.503l1.168-.527c.471-.211 1.02-.034 1.277.412l.797 1.381c.258.447.136 1.011-.282 1.312l-1.029.74c.02.155.034.327.034.507s-.014.353-.034.507l1.029.74c.418.301.54.865.282 1.312l-.796 1.38c-.258.446-.805.625-1.277.412l-1.168-.527c-.273.2-.562.368-.865.503l-.128 1.272c-.051.513-.479.9-.995.9zm-3.512-3.755c.115 0 .229.04.321.117.339.284.714.501 1.113.647.18.066.307.229.326.42l.158 1.571h1.595l.157-1.571c.019-.191.146-.354.326-.42.399-.146.774-.364 1.113-.647.148-.123.352-.151.526-.072l1.444.652.797-1.381-1.278-.918c-.156-.112-.233-.304-.201-.493.037-.211.067-.426.067-.648s-.03-.437-.067-.648c-.033-.189.045-.38.201-.493l1.278-.918-.797-1.381-1.444.651c-.175.079-.379.051-.527-.072-.338-.284-.712-.501-1.113-.647-.18-.066-.307-.229-.326-.42l-.157-1.574h-1.595l-.157 1.571c-.019.191-.146.354-.326.42-.399.146-.774.364-1.113.647-.147.123-.351.152-.526.072l-1.444-.652-.797 1.381 1.278.918c.156.112.233.304.201.493-.037.211-.067.426-.067.648s.03.437.067.648c.033.189-.045.38-.201.493l-1.278.918.797 1.381 1.444-.651c.066-.028.135-.042.205-.042z"></path>
        </g>
      </g>
    </svg>
  </div>
  <ul class="authForm__list">
    <?php if (!$logged) { ?>
      <li class="authForm__item">
        <a href="<?php echo $login; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M8.92758 10.7766C8.94829 10.7766 8.969 10.7766 8.99384 10.7766C9.00213 10.7766 9.01041 10.7766 9.01869 10.7766C9.03112 10.7766 9.04769 10.7766 9.06011 10.7766C10.2736 10.7559 11.2552 10.3293 11.98 9.51336C13.5745 7.71588 13.3094 4.6345 13.2804 4.34044C13.1769 2.13295 12.1332 1.07683 11.2717 0.583972C10.6298 0.215366 9.88016 0.0165666 9.04354 0H9.01455C9.01041 0 9.00213 0 8.99799 0H8.97314C8.51341 0 7.61054 0.0745496 6.74493 0.567405C5.87519 1.06026 4.81493 2.11638 4.71138 4.34044C4.68239 4.6345 4.41733 7.71588 6.01186 9.51336C6.73251 10.3293 7.71408 10.7559 8.92758 10.7766ZM5.8172 4.44398C5.8172 4.43156 5.82135 4.41913 5.82135 4.41085C5.95802 1.44129 8.06612 1.12239 8.96899 1.12239H8.98556C8.99384 1.12239 9.00627 1.12239 9.01869 1.12239C10.1369 1.14724 12.038 1.60282 12.1663 4.41085C12.1663 4.42328 12.1663 4.4357 12.1705 4.44398C12.1746 4.47298 12.4645 7.28929 11.1475 8.772C10.6257 9.36012 9.92986 9.65003 9.01455 9.65831C9.00627 9.65831 9.00213 9.65831 8.99384 9.65831C8.98556 9.65831 8.98142 9.65831 8.97314 9.65831C8.06197 9.65003 7.36204 9.36012 6.84433 8.772C5.53143 7.29758 5.81306 4.46883 5.8172 4.44398Z" fill="#323031" />
              <path d="M17.5049 15.8874C17.5049 15.8832 17.5049 15.8791 17.5049 15.8749C17.5049 15.8418 17.5007 15.8087 17.5007 15.7714C17.4759 14.9513 17.422 13.0338 15.6246 12.4208C15.6121 12.4167 15.5956 12.4125 15.5832 12.4084C13.7153 11.9321 12.1622 10.8552 12.1456 10.8428C11.893 10.6647 11.5451 10.7269 11.367 10.9795C11.1889 11.2321 11.251 11.58 11.5036 11.7581C11.574 11.8078 13.2224 12.9551 15.285 13.4852C16.25 13.829 16.3576 14.8602 16.3866 15.8045C16.3866 15.8418 16.3866 15.8749 16.3908 15.9081C16.3949 16.2808 16.3701 16.8565 16.3038 17.1878C15.6329 17.5689 13.0029 18.8859 9.00208 18.8859C5.01782 18.8859 2.37131 17.5647 1.69622 17.1837C1.62996 16.8524 1.60096 16.2767 1.60925 15.9039C1.60925 15.8708 1.61339 15.8377 1.61339 15.8004C1.64238 14.8561 1.75006 13.8248 2.71507 13.4811C4.77761 12.9509 6.42598 11.7995 6.49639 11.754C6.74903 11.5759 6.81115 11.228 6.63306 10.9754C6.45497 10.7227 6.10707 10.6606 5.85443 10.8387C5.83787 10.8511 4.29303 11.9279 2.41687 12.4042C2.4003 12.4084 2.38788 12.4125 2.37545 12.4166C0.577979 13.0338 0.524137 14.9513 0.499288 15.7672C0.499288 15.8045 0.499287 15.8377 0.495146 15.8708C0.495146 15.8749 0.495146 15.8791 0.495146 15.8832C0.491004 16.0986 0.486863 17.2044 0.70637 17.7594C0.747786 17.8671 0.822336 17.9582 0.921735 18.0203C1.04598 18.1031 4.02383 20 9.00623 20C13.9886 20 16.9665 18.099 17.0907 18.0203C17.186 17.9582 17.2647 17.8671 17.3061 17.7594C17.5132 17.2085 17.509 16.1027 17.5049 15.8874Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Авторизация</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $register; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M8.92758 10.7766C8.94829 10.7766 8.969 10.7766 8.99384 10.7766C9.00213 10.7766 9.01041 10.7766 9.01869 10.7766C9.03112 10.7766 9.04769 10.7766 9.06011 10.7766C10.2736 10.7559 11.2552 10.3293 11.98 9.51336C13.5745 7.71588 13.3094 4.6345 13.2804 4.34044C13.1769 2.13295 12.1332 1.07683 11.2717 0.583972C10.6298 0.215366 9.88016 0.0165666 9.04354 0H9.01455C9.01041 0 9.00213 0 8.99799 0H8.97314C8.51341 0 7.61054 0.0745496 6.74493 0.567405C5.87519 1.06026 4.81493 2.11638 4.71138 4.34044C4.68239 4.6345 4.41733 7.71588 6.01186 9.51336C6.73251 10.3293 7.71408 10.7559 8.92758 10.7766ZM5.8172 4.44398C5.8172 4.43156 5.82135 4.41913 5.82135 4.41085C5.95802 1.44129 8.06612 1.12239 8.96899 1.12239H8.98556C8.99384 1.12239 9.00627 1.12239 9.01869 1.12239C10.1369 1.14724 12.038 1.60282 12.1663 4.41085C12.1663 4.42328 12.1663 4.4357 12.1705 4.44398C12.1746 4.47298 12.4645 7.28929 11.1475 8.772C10.6257 9.36012 9.92986 9.65003 9.01455 9.65831C9.00627 9.65831 9.00213 9.65831 8.99384 9.65831C8.98556 9.65831 8.98142 9.65831 8.97314 9.65831C8.06197 9.65003 7.36204 9.36012 6.84433 8.772C5.53143 7.29758 5.81306 4.46883 5.8172 4.44398Z" fill="#323031" />
              <path d="M17.5049 15.8874C17.5049 15.8832 17.5049 15.8791 17.5049 15.8749C17.5049 15.8418 17.5007 15.8087 17.5007 15.7714C17.4759 14.9513 17.422 13.0338 15.6246 12.4208C15.6121 12.4167 15.5956 12.4125 15.5832 12.4084C13.7153 11.9321 12.1622 10.8552 12.1456 10.8428C11.893 10.6647 11.5451 10.7269 11.367 10.9795C11.1889 11.2321 11.251 11.58 11.5036 11.7581C11.574 11.8078 13.2224 12.9551 15.285 13.4852C16.25 13.829 16.3576 14.8602 16.3866 15.8045C16.3866 15.8418 16.3866 15.8749 16.3908 15.9081C16.3949 16.2808 16.3701 16.8565 16.3038 17.1878C15.6329 17.5689 13.0029 18.8859 9.00208 18.8859C5.01782 18.8859 2.37131 17.5647 1.69622 17.1837C1.62996 16.8524 1.60096 16.2767 1.60925 15.9039C1.60925 15.8708 1.61339 15.8377 1.61339 15.8004C1.64238 14.8561 1.75006 13.8248 2.71507 13.4811C4.77761 12.9509 6.42598 11.7995 6.49639 11.754C6.74903 11.5759 6.81115 11.228 6.63306 10.9754C6.45497 10.7227 6.10707 10.6606 5.85443 10.8387C5.83787 10.8511 4.29303 11.9279 2.41687 12.4042C2.4003 12.4084 2.38788 12.4125 2.37545 12.4166C0.577979 13.0338 0.524137 14.9513 0.499288 15.7672C0.499288 15.8045 0.499287 15.8377 0.495146 15.8708C0.495146 15.8749 0.495146 15.8791 0.495146 15.8832C0.491004 16.0986 0.486863 17.2044 0.70637 17.7594C0.747786 17.8671 0.822336 17.9582 0.921735 18.0203C1.04598 18.1031 4.02383 20 9.00623 20C13.9886 20 16.9665 18.099 17.0907 18.0203C17.186 17.9582 17.2647 17.8671 17.3061 17.7594C17.5132 17.2085 17.509 16.1027 17.5049 15.8874Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Регистрация</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $forgotten; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M8.92758 10.7766C8.94829 10.7766 8.969 10.7766 8.99384 10.7766C9.00213 10.7766 9.01041 10.7766 9.01869 10.7766C9.03112 10.7766 9.04769 10.7766 9.06011 10.7766C10.2736 10.7559 11.2552 10.3293 11.98 9.51336C13.5745 7.71588 13.3094 4.6345 13.2804 4.34044C13.1769 2.13295 12.1332 1.07683 11.2717 0.583972C10.6298 0.215366 9.88016 0.0165666 9.04354 0H9.01455C9.01041 0 9.00213 0 8.99799 0H8.97314C8.51341 0 7.61054 0.0745496 6.74493 0.567405C5.87519 1.06026 4.81493 2.11638 4.71138 4.34044C4.68239 4.6345 4.41733 7.71588 6.01186 9.51336C6.73251 10.3293 7.71408 10.7559 8.92758 10.7766ZM5.8172 4.44398C5.8172 4.43156 5.82135 4.41913 5.82135 4.41085C5.95802 1.44129 8.06612 1.12239 8.96899 1.12239H8.98556C8.99384 1.12239 9.00627 1.12239 9.01869 1.12239C10.1369 1.14724 12.038 1.60282 12.1663 4.41085C12.1663 4.42328 12.1663 4.4357 12.1705 4.44398C12.1746 4.47298 12.4645 7.28929 11.1475 8.772C10.6257 9.36012 9.92986 9.65003 9.01455 9.65831C9.00627 9.65831 9.00213 9.65831 8.99384 9.65831C8.98556 9.65831 8.98142 9.65831 8.97314 9.65831C8.06197 9.65003 7.36204 9.36012 6.84433 8.772C5.53143 7.29758 5.81306 4.46883 5.8172 4.44398Z" fill="#323031" />
              <path d="M17.5049 15.8874C17.5049 15.8832 17.5049 15.8791 17.5049 15.8749C17.5049 15.8418 17.5007 15.8087 17.5007 15.7714C17.4759 14.9513 17.422 13.0338 15.6246 12.4208C15.6121 12.4167 15.5956 12.4125 15.5832 12.4084C13.7153 11.9321 12.1622 10.8552 12.1456 10.8428C11.893 10.6647 11.5451 10.7269 11.367 10.9795C11.1889 11.2321 11.251 11.58 11.5036 11.7581C11.574 11.8078 13.2224 12.9551 15.285 13.4852C16.25 13.829 16.3576 14.8602 16.3866 15.8045C16.3866 15.8418 16.3866 15.8749 16.3908 15.9081C16.3949 16.2808 16.3701 16.8565 16.3038 17.1878C15.6329 17.5689 13.0029 18.8859 9.00208 18.8859C5.01782 18.8859 2.37131 17.5647 1.69622 17.1837C1.62996 16.8524 1.60096 16.2767 1.60925 15.9039C1.60925 15.8708 1.61339 15.8377 1.61339 15.8004C1.64238 14.8561 1.75006 13.8248 2.71507 13.4811C4.77761 12.9509 6.42598 11.7995 6.49639 11.754C6.74903 11.5759 6.81115 11.228 6.63306 10.9754C6.45497 10.7227 6.10707 10.6606 5.85443 10.8387C5.83787 10.8511 4.29303 11.9279 2.41687 12.4042C2.4003 12.4084 2.38788 12.4125 2.37545 12.4166C0.577979 13.0338 0.524137 14.9513 0.499288 15.7672C0.499288 15.8045 0.499287 15.8377 0.495146 15.8708C0.495146 15.8749 0.495146 15.8791 0.495146 15.8832C0.491004 16.0986 0.486863 17.2044 0.70637 17.7594C0.747786 17.8671 0.822336 17.9582 0.921735 18.0203C1.04598 18.1031 4.02383 20 9.00623 20C13.9886 20 16.9665 18.099 17.0907 18.0203C17.186 17.9582 17.2647 17.8671 17.3061 17.7594C17.5132 17.2085 17.509 16.1027 17.5049 15.8874Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Забыли пароль?</span>
        </a>
      </li>
      <!-- <a href="<?php echo $login; ?>" class="list-group-item"><?php echo $text_login; ?></a> <a href="<?php echo $register; ?>" class="list-group-item"><?php echo $text_register; ?></a> <a href="<?php echo $forgotten; ?>" class="list-group-item"><?php echo $text_forgotten; ?></a> -->
    <?php } ?>
    <?php if ($logged) { ?>
      <li class="authForm__item">
        <a href="<?php echo $edit; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="20" viewBox="0 0 18 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M8.92758 10.7766C8.94829 10.7766 8.969 10.7766 8.99384 10.7766C9.00213 10.7766 9.01041 10.7766 9.01869 10.7766C9.03112 10.7766 9.04769 10.7766 9.06011 10.7766C10.2736 10.7559 11.2552 10.3293 11.98 9.51336C13.5745 7.71588 13.3094 4.6345 13.2804 4.34044C13.1769 2.13295 12.1332 1.07683 11.2717 0.583972C10.6298 0.215366 9.88016 0.0165666 9.04354 0H9.01455C9.01041 0 9.00213 0 8.99799 0H8.97314C8.51341 0 7.61054 0.0745496 6.74493 0.567405C5.87519 1.06026 4.81493 2.11638 4.71138 4.34044C4.68239 4.6345 4.41733 7.71588 6.01186 9.51336C6.73251 10.3293 7.71408 10.7559 8.92758 10.7766ZM5.8172 4.44398C5.8172 4.43156 5.82135 4.41913 5.82135 4.41085C5.95802 1.44129 8.06612 1.12239 8.96899 1.12239H8.98556C8.99384 1.12239 9.00627 1.12239 9.01869 1.12239C10.1369 1.14724 12.038 1.60282 12.1663 4.41085C12.1663 4.42328 12.1663 4.4357 12.1705 4.44398C12.1746 4.47298 12.4645 7.28929 11.1475 8.772C10.6257 9.36012 9.92986 9.65003 9.01455 9.65831C9.00627 9.65831 9.00213 9.65831 8.99384 9.65831C8.98556 9.65831 8.98142 9.65831 8.97314 9.65831C8.06197 9.65003 7.36204 9.36012 6.84433 8.772C5.53143 7.29758 5.81306 4.46883 5.8172 4.44398Z" fill="#323031" />
              <path d="M17.5049 15.8874C17.5049 15.8832 17.5049 15.8791 17.5049 15.8749C17.5049 15.8418 17.5007 15.8087 17.5007 15.7714C17.4759 14.9513 17.422 13.0338 15.6246 12.4208C15.6121 12.4167 15.5956 12.4125 15.5832 12.4084C13.7153 11.9321 12.1622 10.8552 12.1456 10.8428C11.893 10.6647 11.5451 10.7269 11.367 10.9795C11.1889 11.2321 11.251 11.58 11.5036 11.7581C11.574 11.8078 13.2224 12.9551 15.285 13.4852C16.25 13.829 16.3576 14.8602 16.3866 15.8045C16.3866 15.8418 16.3866 15.8749 16.3908 15.9081C16.3949 16.2808 16.3701 16.8565 16.3038 17.1878C15.6329 17.5689 13.0029 18.8859 9.00208 18.8859C5.01782 18.8859 2.37131 17.5647 1.69622 17.1837C1.62996 16.8524 1.60096 16.2767 1.60925 15.9039C1.60925 15.8708 1.61339 15.8377 1.61339 15.8004C1.64238 14.8561 1.75006 13.8248 2.71507 13.4811C4.77761 12.9509 6.42598 11.7995 6.49639 11.754C6.74903 11.5759 6.81115 11.228 6.63306 10.9754C6.45497 10.7227 6.10707 10.6606 5.85443 10.8387C5.83787 10.8511 4.29303 11.9279 2.41687 12.4042C2.4003 12.4084 2.38788 12.4125 2.37545 12.4166C0.577979 13.0338 0.524137 14.9513 0.499288 15.7672C0.499288 15.8045 0.499287 15.8377 0.495146 15.8708C0.495146 15.8749 0.495146 15.8791 0.495146 15.8832C0.491004 16.0986 0.486863 17.2044 0.70637 17.7594C0.747786 17.8671 0.822336 17.9582 0.921735 18.0203C1.04598 18.1031 4.02383 20 9.00623 20C13.9886 20 16.9665 18.099 17.0907 18.0203C17.186 17.9582 17.2647 17.8671 17.3061 17.7594C17.5132 17.2085 17.509 16.1027 17.5049 15.8874Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Мой профиль</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $address; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M15.9814 2.47758C14.3837 0.879884 12.2595 0 10 0C7.74056 0 5.61626 0.879884 4.0186 2.47758C2.4209 4.07532 1.54102 6.19954 1.54102 8.45896C1.54102 13.0298 5.86282 16.8315 8.18466 18.8739C8.50732 19.1578 8.78595 19.4029 9.00794 19.6102C9.28607 19.87 9.64306 20 9.99998 20C10.357 20 10.7139 19.87 10.992 19.6102C11.214 19.4029 11.4927 19.1578 11.8153 18.8739C14.1372 16.8315 18.459 13.0298 18.459 8.45896C18.4589 6.19954 17.5791 4.07532 15.9814 2.47758ZM11.0415 17.9943C10.7118 18.2844 10.427 18.5349 10.1923 18.7541C10.0844 18.8548 9.91552 18.8548 9.80763 18.7541C9.57291 18.5348 9.28814 18.2843 8.95841 17.9943C6.7756 16.0742 2.7125 12.5 2.7125 8.459C2.7125 4.44071 5.98161 1.1716 9.99994 1.1716C14.0182 1.1716 17.2873 4.44071 17.2873 8.459C17.2874 12.5 13.2243 16.0742 11.0415 17.9943Z" fill="#323031" />
              <path d="M10 4.41162C7.94449 4.41162 6.27222 6.08385 6.27222 8.13936C6.27222 10.1949 7.94449 11.8671 10 11.8671C12.0555 11.8671 13.7277 10.1949 13.7277 8.13936C13.7277 6.08385 12.0555 4.41162 10 4.41162ZM10 10.6955C8.5905 10.6955 7.44378 9.54878 7.44378 8.13933C7.44378 6.72987 8.5905 5.58315 10 5.58315C11.4095 5.58315 12.5562 6.72987 12.5562 8.13933C12.5562 9.54878 11.4095 10.6955 10 10.6955Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Адрес доставки</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $order; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
              <g clip-path="url(#clip0)">
                <path d="M17.4727 8.4727C17.1815 8.4727 16.9454 8.70881 16.9454 9.00004C16.9454 13.3811 13.3811 16.9453 9.0001 16.9453C4.61906 16.9453 1.05484 13.3811 1.05484 9.00004C1.05484 4.619 4.61906 1.05478 9.0001 1.05478C10.336 1.05478 11.6355 1.38647 12.7955 2.01851L12.1362 2.67779C11.9854 2.82861 11.9403 3.0554 12.0219 3.25249C12.1035 3.44954 12.2958 3.57803 12.5091 3.57803H15.0323C15.3236 3.57803 15.5597 3.34192 15.5597 3.05069V0.527435C15.5597 0.314143 15.4312 0.121875 15.2341 0.0402422C15.037 -0.0414253 14.8102 0.0037151 14.6594 0.15457L13.569 1.245C12.1878 0.42949 10.6173 0.000129181 9.00006 0.000129181C6.5961 0.000129181 4.33598 0.9363 2.63612 2.63613C0.936257 4.33603 0.00012207 6.59611 0.00012207 9.00008C0.00012207 11.404 0.936257 13.6641 2.63612 15.364C4.33602 17.0639 6.5961 18.0001 9.00006 18.0001C11.404 18.0001 13.6641 17.0639 15.364 15.364C17.0639 13.6641 18 11.404 18 9.00008C18 8.70881 17.7639 8.4727 17.4727 8.4727Z" fill="#323031" />
                <path d="M12.389 8.47302H9.52734V5.61132C9.52734 5.32009 9.29123 5.08398 9 5.08398C8.70876 5.08398 8.47266 5.32009 8.47266 5.61132V9.00036C8.47266 9.29159 8.70876 9.5277 9 9.5277H12.389C12.6802 9.5277 12.9163 9.29159 12.9163 9.00036C12.9163 8.70912 12.6802 8.47302 12.389 8.47302Z" fill="#323031" />
              </g>
              <defs>
                <clipPath id="clip0">
                  <rect width="18" height="18" fill="white" />
                </clipPath>
              </defs>
            </svg>
          </div>
          <span class="authForm__text">История заказов</span>
        </a>
      </li>
      <li class="authForm__item favorites-profile">
        <a href="<?php echo $wishlist; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="23" height="20" viewBox="0 0 23 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485ZM6.25427 1.34176C4.89584 1.34176 3.64793 1.8839 2.74009 2.86843C1.81875 3.86783 1.31129 5.24931 1.31129 6.75856C1.31129 8.351 1.90313 9.77519 3.23013 11.3763C4.51272 12.924 6.42046 14.5498 8.62934 16.4322L8.63344 16.4356C9.40566 17.0938 10.281 17.8398 11.1921 18.6365C12.1087 17.8383 12.9854 17.091 13.7592 16.4319C15.9679 14.5494 17.8755 12.924 19.1581 11.3763C20.4849 9.77519 21.0767 8.351 21.0767 6.75856C21.0767 5.24931 20.5693 3.86783 19.6479 2.86843C18.7403 1.8839 17.4922 1.34176 16.1339 1.34176C15.1388 1.34176 14.2252 1.65809 13.4184 2.28188C12.6995 2.83803 12.1987 3.54107 11.9051 4.033C11.7541 4.28596 11.4883 4.43695 11.194 4.43695C10.8997 4.43695 10.6339 4.28596 10.4829 4.033C10.1895 3.54107 9.68869 2.83803 8.96959 2.28188C8.16287 1.65809 7.24922 1.34176 6.25427 1.34176Z" fill="#323031" />
            </svg>
          </div>
          <span class="authForm__text">Избранное</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $password; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
              <g clip-path="url(#clip0)">
                <path d="M15.625 20H4.375C3.34167 20 2.5 19.1592 2.5 18.125V9.375C2.5 8.34083 3.34167 7.5 4.375 7.5H15.625C16.6583 7.5 17.5 8.34083 17.5 9.375V18.125C17.5 19.1592 16.6583 20 15.625 20ZM4.375 8.75C4.03083 8.75 3.75 9.03 3.75 9.375V18.125C3.75 18.47 4.03083 18.75 4.375 18.75H15.625C15.9692 18.75 16.25 18.47 16.25 18.125V9.375C16.25 9.03 15.9692 8.75 15.625 8.75H4.375Z" fill="#323031" />
                <path d="M14.375 8.75C14.03 8.75 13.75 8.47 13.75 8.125V5C13.75 2.9325 12.0675 1.25 10 1.25C7.9325 1.25 6.25 2.9325 6.25 5V8.125C6.25 8.47 5.97 8.75 5.625 8.75C5.28 8.75 5 8.47 5 8.125V5C5 2.2425 7.2425 0 10 0C12.7575 0 15 2.2425 15 5V8.125C15 8.47 14.72 8.75 14.375 8.75Z" fill="#323031" />
                <path d="M10 14.1666C9.08087 14.1666 8.33337 13.4191 8.33337 12.5C8.33337 11.5808 9.08087 10.8333 10 10.8333C10.9192 10.8333 11.6667 11.5808 11.6667 12.5C11.6667 13.4191 10.9192 14.1666 10 14.1666ZM10 12.0833C9.77088 12.0833 9.58337 12.27 9.58337 12.5C9.58337 12.73 9.77088 12.9166 10 12.9166C10.2292 12.9166 10.4167 12.73 10.4167 12.5C10.4167 12.27 10.2292 12.0833 10 12.0833Z" fill="#323031" />
                <path d="M10 16.6667C9.655 16.6667 9.375 16.3867 9.375 16.0417V13.75C9.375 13.405 9.655 13.125 10 13.125C10.345 13.125 10.625 13.405 10.625 13.75V16.0417C10.625 16.3867 10.345 16.6667 10 16.6667Z" fill="#323031" />
              </g>
              <defs>
                <clipPath id="clip0">
                  <rect width="20" height="20" fill="white" />
                </clipPath>
              </defs>
            </svg>
          </div>
          <span class="authForm__text">Пароль</span>
        </a>
      </li>
      <li class="authForm__item">
        <a href="<?php echo $logout; ?>" class="authForm__link">
          <div class="authForm__iconWrapper">
            <svg class="authForm__icon" width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
              <g clip-path="url(#clip0)">
                <path d="M17.2063 9.39867C17.21 9.395 17.21 9.395 17.2136 9.39132C17.2247 9.37663 17.2357 9.3656 17.243 9.35091C17.2467 9.34723 17.2467 9.34356 17.2504 9.33988C17.2577 9.32519 17.2688 9.31049 17.2761 9.29579C17.2761 9.29212 17.2798 9.28844 17.2798 9.28844C17.2871 9.27375 17.2945 9.25905 17.3018 9.24068C17.3018 9.23701 17.3018 9.23701 17.3055 9.23333C17.3128 9.21863 17.3165 9.20026 17.3239 9.18189C17.3239 9.17822 17.3239 9.17454 17.3275 9.17454C17.3312 9.15617 17.3386 9.14148 17.3386 9.12311C17.3386 9.11576 17.3386 9.11208 17.3422 9.10473C17.3459 9.09004 17.3459 9.07534 17.3496 9.06064C17.3533 9.0386 17.3533 9.02023 17.3533 8.99818C17.3533 8.97614 17.3533 8.95777 17.3496 8.93572C17.3496 8.92102 17.3459 8.90633 17.3422 8.89163C17.3422 8.88428 17.3422 8.88061 17.3386 8.87326C17.3349 8.85489 17.3312 8.84019 17.3275 8.82182C17.3275 8.81814 17.3275 8.81447 17.3239 8.81447C17.3202 8.7961 17.3128 8.7814 17.3055 8.76303C17.3055 8.75936 17.3055 8.75936 17.3018 8.75568C17.2945 8.74099 17.2871 8.72262 17.2798 8.70792C17.2798 8.70424 17.2761 8.70057 17.2761 8.70057C17.2688 8.68587 17.2614 8.67118 17.2504 8.65648C17.2467 8.65281 17.2467 8.64913 17.243 8.64546C17.232 8.63076 17.2247 8.61606 17.2136 8.60504C17.21 8.60137 17.21 8.60137 17.2063 8.59769C17.1916 8.58299 17.1806 8.56462 17.1622 8.54993L13.5284 4.9198C13.2822 4.67363 12.8817 4.67363 12.6356 4.9198C12.3894 5.16597 12.3894 5.56646 12.6356 5.81263L15.1928 8.36989H5.02625C4.6772 8.36989 4.39429 8.6528 4.39429 8.99818C4.39429 9.34723 4.6772 9.63015 5.02625 9.63015H15.1965L12.6576 12.169C12.4114 12.4152 12.4114 12.8157 12.6576 13.0619C12.7789 13.1831 12.9405 13.2456 13.1022 13.2456C13.2639 13.2456 13.4255 13.1831 13.5468 13.0619L17.1585 9.45011C17.1769 9.42807 17.1916 9.41337 17.2063 9.39867Z" fill="#323031" />
                <path d="M4.0673 1.26026H8.7703C9.11935 1.26026 9.40227 0.977342 9.40227 0.631966C9.40227 0.282915 9.11935 0 8.7703 0H4.0673C2.18243 0 0.646606 1.53582 0.646606 3.4207V14.5793C0.646606 16.4642 2.18243 18 4.0673 18H8.69314C9.0422 18 9.32511 17.7171 9.32511 17.3717C9.32511 17.0227 9.0422 16.7397 8.69314 16.7397H4.0673C2.87686 16.7397 1.90686 15.7697 1.90686 14.5793V3.4207C1.91054 2.22658 2.87686 1.26026 4.0673 1.26026Z" fill="#323031" />
              </g>
              <defs>
                <clipPath id="clip0">
                  <rect width="18" height="18" fill="white" />
                </clipPath>
              </defs>
            </svg>
          </div>
          <span class="authForm__text">Выход</span>
        </a>
      </li>
    <?php } ?>
  </ul>
</div>