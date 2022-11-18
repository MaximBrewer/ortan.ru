<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<?php
global $cityArray;

$shortcodes = [
    'in' => [
        "###Адрес улица###",
        "###Адрес индекс###",
        "###Адрес город###",
        "###Телефон###",
        "###График работы###",
        "###Адрес город 2###",
        "###Широта###",
        "###Долгота###"
    ],
    'out' => [
        $cityArray['address'],
        $cityArray['address_zip'],
        $cityArray['address_city'],
        $cityArray['phone'],
        $cityArray['schedule'],
        $cityArray['address_city2'],
        $cityArray['geo_lat'],
        $cityArray['geo_lon'],
    ]
];


if ($title === 'Контакты') {
    $title = 'Интернет-магазин «Ортан» — Контакты — ' .  $cityArray['city'];
    $description = 'Контакты интернет-магазина «Ортан» со схемой проезда в ' .  $cityArray['address_city2'] . ' адрес, телефон, e-mail.';
    $keywords = 'контакты, телефон, ' .  $cityArray['city'];
} else {
    $title = str_replace($shortcodes['in'], $shortcodes['out'], $title);
    $description = str_replace($shortcodes['in'], $shortcodes['out'], $description);
    $keywords = str_replace($shortcodes['in'], $shortcodes['out'], $keywords);
} ?>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><?php echo $title  ?></title>
    <base href="<?php echo $base; ?>" />

    <?php if ($description) { ?>
        <meta name="description" content="<?php echo $description; ?>" />
    <?php } ?>
    <?php if ($keywords) { ?>
        <meta name="keywords" content="<?php echo $keywords; ?>" />
    <?php } ?>
    <meta property="og:title" content="<?php echo $title; ?>" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="<?php echo $og_url; ?>" />
    <?php if ($og_image) { ?>
        <meta property="og:image" content="<?php echo $og_image; ?>" />
    <?php } else { ?>
        <meta property="og:image" content="<?php echo $logo; ?>" />
    <?php } ?>
    <meta property="og:site_name" content="<?php echo $name; ?>" />
    <link rel="shortcut icon" href="/catalog/view/theme/ortan/assets/images/32x32_ortan.png">
    <link rel="stylesheet" href="/catalog/view/theme/ortan/assets/fonts/stylesheet.css">
    <link rel="stylesheet" href="/catalog/view/theme/ortan/assets/css/normalize.css">
    <link rel="stylesheet" href="/catalog/view/theme/ortan/assets/css/main.css?v=1.10">
    <link rel="stylesheet" href="/catalog/view/theme/ortan/assets/css/responsive.css">
    <link rel="stylesheet" href="/catalog/view/theme/ortan/assets/css/common2.css">
    <?php foreach ($styles as $style) { ?>
        <link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
    <?php } ?>
    <?php foreach ($links as $link) { ?>
        <link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
    <?php } ?>
    <script src="/catalog/view/theme/ortan/assets/javascript/jquery.js"></script>
    <?php foreach ($analytics as $analytic) { ?>
        <?php echo $analytic; ?>
    <?php } ?>
    <script>
        var wishlistIds = Object.values(JSON.parse('<?php echo json_encode($wishlist, JSON_FORCE_OBJECT); ?>'));
        var compareIds = Object.values(JSON.parse('<?php echo json_encode($compare, JSON_FORCE_OBJECT); ?>'));
    </script>


	<!-- zadarma -->
<script>(function(w, c){(w[c]=w[c]||[]).push(function(){new zTracker({"id":"e9956fd947618801ae15d95a4e9b44a014127","metrics":{"metrika":"53398495"}});});})(window, "zTrackerCallbacks");</script>
<script async id="zd_ct_phone_script" src="https://my.zadarma.com/js/ct_phone.min.js"></script>
	<!-- /zadarma -->

	
	<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-RQNJF3JYM9"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'G-RQNJF3JYM9');
  gtag('config', 'UA-219638874-1');
  
</script>

 

    <?php foreach ($scripts as $script) { ?>
        <script src="<?php echo $script; ?>"></script>
    <?php } ?>
	
	<!-- vk pixel -->
<script type="text/javascript">!function(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,t.src='https://vk.com/js/api/openapi.js?169',t.onload=function(){VK.Retargeting.Init("VK-RTRG-1564172-8MaSC"),VK.Retargeting.Hit()},document.head.appendChild(t)}();</script><noscript><img src="https://vk.com/rtrg?p=VK-RTRG-1564172-8MaSC" style="position:fixed; left:-999px;" alt=""/></noscript>
	<!-- end vk pixel -->

</head>

<body class="<?php echo $dark ? 'innerPage' : ''; ?> <?php echo $class ? $class : ""; ?>" <?php echo $body_id; ?>>
    <div class="common-wrapper">
        <header class="header">
            <div class="header__container">
                <svg width="30" height="30" viewBox="0 0 30 30" xmlns="http://www.w3.org/2000/svg" class="header__mobileMenu header__mobileMenu_show">
                    <path d="M28.75 16.2241H1.25C0.559998 16.2241 0 15.6641 0 14.9741C0 14.2841 0.559998 13.7241 1.25 13.7241H28.75C29.44 13.7241 30 14.2841 30 14.9741C30 15.6641 29.44 16.2241 28.75 16.2241Z" />
                    <path d="M28.75 6.64062H1.25C0.559998 6.64062 0 6.08063 0 5.39062C0 4.70062 0.559998 4.14062 1.25 4.14062H28.75C29.44 4.14062 30 4.70062 30 5.39062C30 6.08063 29.44 6.64062 28.75 6.64062Z" />
                    <path d="M28.75 25.8072H1.25C0.559998 25.8072 0 25.2472 0 24.5572C0 23.8672 0.559998 23.3072 1.25 23.3072H28.75C29.44 23.3072 30 23.8672 30 24.5572C30 25.2472 29.44 25.8072 28.75 25.8072Z" />
                </svg>
                <svg width="24" height="24" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg" class="header__mobileMenu header__mobileMenu_close">
                    <path d="M1.24047 24.0001C0.924327 24.0001 0.608188 23.8798 0.367994 23.6378C-0.114201 23.1556 -0.114201 22.3739 0.367994 21.8917L21.898 0.361646C22.3802 -0.120549 23.162 -0.120549 23.6442 0.361646C24.1264 0.843842 24.1264 1.6256 23.6442 2.1081L2.11445 23.6378C1.87244 23.8783 1.5563 24.0001 1.24047 24.0001Z" />
                    <path d="M22.772 24.0001C22.4559 24.0001 22.14 23.8798 21.8995 23.6378L0.367994 2.1081C-0.114201 1.6256 -0.114201 0.843842 0.367994 0.361646C0.85019 -0.120549 1.63195 -0.120549 2.11445 0.361646L23.6442 21.8917C24.1264 22.3739 24.1264 23.1556 23.6442 23.6378C23.4022 23.8783 23.0863 24.0001 22.772 24.0001Z" />
                </svg>
                <div class="header__logo">
                    <a href="<?= $home ?>">
                        <svg width="102" height="21" viewBox="0 0 102 21" xmlns="http://www.w3.org/2000/svg" class="header__logoImg">
                            <path d="M15.0849 0H7.72651C2.5755 0 0 2.45005 0 7.35016V13.6504C0 18.5505 2.5755 21.0005 7.72651 21.0005H15.0849C20.2359 21.0005 22.8114 18.5505 22.8114 13.6504V7.35016C22.8114 2.45005 20.2359 0 15.0849 0V0ZM19.1322 13.6498C19.1322 16.683 17.5383 18.1998 14.3493 18.1998H8.46269C5.27427 18.1998 3.67977 16.683 3.67977 13.6498V7.34963C3.67977 4.31597 5.27427 2.79968 8.46269 2.79968H14.3493C17.5383 2.79968 19.1322 4.31597 19.1322 7.34963V13.6498Z" />
                            <path d="M43.4392 11.9001H44.0831C48.2531 11.9001 50.3378 9.91693 50.3378 5.95005C50.3378 1.98317 48.2531 0 44.0831 0H28.9987V21H31.2062C32.1872 21 32.678 20.5331 32.678 19.5999V11.9001H39.1167L45.8926 19.5999C46.7205 20.5331 47.6098 21 48.5908 21H51.4421L43.4398 11.9001H43.4392ZM32.6774 9.09989V2.79968H43.3469C45.5543 2.79968 46.6581 3.84963 46.6581 5.94952C46.6581 8.04941 45.5543 9.09936 43.3469 9.09936H32.6774V9.09989Z" />
                            <path d="M52.7141 0V1.40011C52.7141 2.33333 53.2049 2.80021 54.1859 2.80021H62.2799V21H65.9591V2.80021H74.0537C75.0347 2.80021 75.5255 2.33333 75.5255 1.40011V0H52.7141V0Z" />
                            <path d="M84.7739 1.32515L83.6038 0H81.7645L71.4625 21H73.6395C74.6205 21 75.3561 20.5331 75.8159 19.5999L77.5326 16.0999H90.4281L88.3062 13.2997H78.8822L80.1599 10.7029L83.6038 3.70346L84.7739 1.32461V1.32515Z" />
                            <path d="M99.7925 0C98.8114 0 98.3207 0.466345 98.3207 1.40011V16.654L83.6038 0L82.9149 3.55943L98.3207 21H102V0H99.7925V0Z" />
                        </svg>
                    </a>
                    <?php echo $cities ?>
                </div>
                <div class="userMenu">
                    <ul class="userMenu__list">
                        <li class="userMenu__item">
                            <a href="<?= $home ?>my-account/" class="userMenu__link">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-user.svg" alt="user" class="userMenu__icon">
                                <span class="userMenu__text">Мой профиль</span>
                            </a>
                        </li>
                        <li class="userMenu__item">
                            <a href="<?= $home ?>address-book/" class="userMenu__link">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-location.svg" alt="user" class="userMenu__icon">
                                <span class="userMenu__text">Адрес доставки</span>
                            </a>
                        </li>
                        <li class="userMenu__item">
                            <a href="<?= $home ?>order-history/" class="userMenu__link">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-history.svg" alt="user" class="userMenu__icon">
                                <span class="userMenu__text">История заказов</span>
                            </a>
                        </li>
                        <li class="userMenu__item">
                            <a href="<?= $home ?>wishlist/" class="userMenu__link">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-heart.svg" title="В закладки" alt="user" class="userMenu__icon">
                                <span class="userMenu__text">Избранное</span>
                            </a>
                        </li>
                        <li class="userMenu__item">
                            <a href="<?= $home ?>change-password/" class="userMenu__link">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-lock.svg" alt="user" class="userMenu__icon">
                                <span class="userMenu__text">Пароль</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <nav class="header__nav nav">
                    <ul class="nav__list">

                        <?php if (!$logged) { ?>
                            <li class="nav__enter">
                                <a class="" href="<?= $home ?>login/"><img src="/catalog/view/theme/ortan/assets/images/enter-out.svg" alt="exit icon" class="topMenu__icon"><span>Вход</span></a>
                            </li>
                        <?php } else { ?>
                            <li class="nav__enter">
                                <a class="" href="<?= $home ?>edit-account/"><img src="/catalog/view/theme/ortan/assets/images/icon-user.svg" alt="exit icon" class="topMenu__icon"><span>Мой профиль</span></a>
                            </li>
                        <?php } ?>
                        <?php echo $categoriesList; ?>
                        <li class="nav__item podarki_mob">
                            <a href="<?= $home ?>tovary/podarki1/" class="nav__link">ПОДАРКИ</a>
                        </li>
                        <li class="nav__item">
                            <a href="<?= $home ?>discounts/" class="nav__link">СКИДКИ</a>
                        </li>
                        <!--li class="nav__item">
                            <a href="/bestseller" class="nav__link">БЕСТСЕЛЛЕРЫ</a>
                        </li-->
                        <!--li class="nav__item">
                            <a href="/delivery" class="nav__link">ДОСТАВКА</a>
                        </li-->
                        <li class="nav__item">
                            <a href="<?= $home ?>o-magazine/" class="nav__link">О НАС</a>
                        </li>
                        <li class="nav__item">
                            <a href="<?= $home ?>otzyvy/" class="nav__link">ОТЗЫВЫ</a>
                        </li>
                    </ul>
                </nav>
                                                            <div class="header__tel">
                         
                    <a href="tel:<?php echo $config['config_telephone']; ?>"
                       onclick="ym('53398495','reachGoal','lClickPhone'); return true;"
                       oncontextmenu="ym('53398495','reachGoal','rClickPhone'); return true;"
                       oncopy="ym(53398495,'reachGoal','copyPhone'); return true;"
                    ><?php echo $config['config_telephone']; ?></a> <br />
                    <a href="tel:<?php echo $config['config_fax']; ?>"
                       onclick="ym('53398495','reachGoal','lClickPhone'); return true;"
                       oncontextmenu="ym('53398495','reachGoal','rClickPhone'); return true;"
                       oncopy="ym(53398495,'reachGoal','copyPhone'); return true;"
                    ><?php echo $config['config_fax']; ?></a>
                    <span class="js-open-callback" data-toggle="modal" data-target="#feedBackModal">Заказать звонок</span>
          
                        </div>
                <ul class="header__menu topMenu">
                    <li class="topMenu__item topMenu__item_search">
                        <svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
                            <path d="M19.8105 18.9119L14.6468 13.8308C15.999 12.3616 16.8298 10.4187 16.8298 8.28068C16.8292 3.7071 13.0621 0 8.41471 0C3.76737 0 0.000244141 3.7071 0.000244141 8.28068C0.000244141 12.8543 3.76737 16.5614 8.41471 16.5614C10.4227 16.5614 12.2644 15.8668 13.711 14.7122L18.8947 19.8134C19.1472 20.0622 19.5573 20.0622 19.8099 19.8134C20.063 19.5646 20.063 19.1607 19.8105 18.9119ZM8.41471 15.2873C4.48255 15.2873 1.29493 12.1504 1.29493 8.28068C1.29493 4.41101 4.48255 1.27403 8.41471 1.27403C12.3469 1.27403 15.5345 4.41101 15.5345 8.28068C15.5345 12.1504 12.3469 15.2873 8.41471 15.2873Z" />
                        </svg>
                    </li><?php if ($logged) { ?>
                        <li class="topMenu__item topMenu__item_exit topMenu__item_chart">
                            <a href="<?= $home ?>edit-account/">
                                <svg width="19" height="20" viewBox="0 0 19 20" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
                                    <path d="M8.92758 10.7766C8.94829 10.7766 8.969 10.7766 8.99384 10.7766C9.00213 10.7766 9.01041 10.7766 9.01869 10.7766C9.03112 10.7766 9.04769 10.7766 9.06011 10.7766C10.2736 10.7559 11.2552 10.3293 11.98 9.51336C13.5745 7.71588 13.3094 4.6345 13.2804 4.34044C13.1769 2.13295 12.1332 1.07683 11.2717 0.583972C10.6298 0.215366 9.88016 0.0165666 9.04354 0H9.01455C9.01041 0 9.00213 0 8.99799 0H8.97314C8.51341 0 7.61054 0.0745496 6.74493 0.567405C5.87519 1.06026 4.81493 2.11638 4.71138 4.34044C4.68239 4.6345 4.41733 7.71588 6.01186 9.51336C6.73251 10.3293 7.71408 10.7559 8.92758 10.7766ZM5.8172 4.44398C5.8172 4.43156 5.82135 4.41913 5.82135 4.41085C5.95802 1.44129 8.06612 1.12239 8.96899 1.12239H8.98556C8.99384 1.12239 9.00627 1.12239 9.01869 1.12239C10.1369 1.14724 12.038 1.60282 12.1663 4.41085C12.1663 4.42328 12.1663 4.4357 12.1705 4.44398C12.1746 4.47298 12.4645 7.28929 11.1475 8.772C10.6257 9.36012 9.92986 9.65003 9.01455 9.65831C9.00627 9.65831 9.00213 9.65831 8.99384 9.65831C8.98556 9.65831 8.98142 9.65831 8.97314 9.65831C8.06197 9.65003 7.36204 9.36012 6.84433 8.772C5.53143 7.29758 5.81306 4.46883 5.8172 4.44398Z"></path>
                                    <path d="M17.5049 15.8874C17.5049 15.8832 17.5049 15.8791 17.5049 15.8749C17.5049 15.8418 17.5007 15.8087 17.5007 15.7714C17.4759 14.9513 17.422 13.0338 15.6246 12.4208C15.6121 12.4167 15.5956 12.4125 15.5832 12.4084C13.7153 11.9321 12.1622 10.8552 12.1456 10.8428C11.893 10.6647 11.5451 10.7269 11.367 10.9795C11.1889 11.2321 11.251 11.58 11.5036 11.7581C11.574 11.8078 13.2224 12.9551 15.285 13.4852C16.25 13.829 16.3576 14.8602 16.3866 15.8045C16.3866 15.8418 16.3866 15.8749 16.3908 15.9081C16.3949 16.2808 16.3701 16.8565 16.3038 17.1878C15.6329 17.5689 13.0029 18.8859 9.00208 18.8859C5.01782 18.8859 2.37131 17.5647 1.69622 17.1837C1.62996 16.8524 1.60096 16.2767 1.60925 15.9039C1.60925 15.8708 1.61339 15.8377 1.61339 15.8004C1.64238 14.8561 1.75006 13.8248 2.71507 13.4811C4.77761 12.9509 6.42598 11.7995 6.49639 11.754C6.74903 11.5759 6.81115 11.228 6.63306 10.9754C6.45497 10.7227 6.10707 10.6606 5.85443 10.8387C5.83787 10.8511 4.29303 11.9279 2.41687 12.4042C2.4003 12.4084 2.38788 12.4125 2.37545 12.4166C0.577979 13.0338 0.524137 14.9513 0.499288 15.7672C0.499288 15.8045 0.499287 15.8377 0.495146 15.8708C0.495146 15.8749 0.495146 15.8791 0.495146 15.8832C0.491004 16.0986 0.486863 17.2044 0.70637 17.7594C0.747786 17.8671 0.822336 17.9582 0.921735 18.0203C1.04598 18.1031 4.02383 20 9.00623 20C13.9886 20 16.9665 18.099 17.0907 18.0203C17.186 17.9582 17.2647 17.8671 17.3061 17.7594C17.5132 17.2085 17.509 16.1027 17.5049 15.8874Z"></path>
                                </svg>
                            </a>
                        </li>
                    <?php } else { ?>
                        <li class="topMenu__item topMenu__item_exit topMenu__item_chart">
                            <a href="<?= $home ?>login/">
                                <svg width="19" height="20" viewBox="0 0 19 20" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
                                    <path d="M4.32743 9.53561C4.32335 9.5397 4.32335 9.5397 4.31926 9.54378C4.30702 9.56011 4.29477 9.57236 4.2866 9.58869C4.28252 9.59277 4.28252 9.59685 4.27844 9.60093C4.27027 9.61726 4.25803 9.63359 4.24986 9.64992C4.24986 9.65401 4.24578 9.65809 4.24578 9.65809C4.23761 9.67442 4.22945 9.69075 4.22128 9.71116C4.22128 9.71524 4.22128 9.71524 4.2172 9.71932C4.20904 9.73565 4.20495 9.75607 4.19679 9.77648C4.19679 9.78056 4.19679 9.78464 4.19271 9.78464C4.18862 9.80506 4.18046 9.82139 4.18046 9.8418C4.18046 9.84996 4.18046 9.85405 4.17638 9.86221C4.17229 9.87854 4.17229 9.89487 4.16821 9.9112C4.16413 9.9357 4.16413 9.95611 4.16413 9.9806C4.16413 10.0051 4.16413 10.0255 4.16821 10.05C4.16821 10.0663 4.17229 10.0827 4.17638 10.099C4.17638 10.1072 4.17638 10.1112 4.18046 10.1194C4.18454 10.1398 4.18862 10.1561 4.19271 10.1766C4.19271 10.1806 4.19271 10.1847 4.19679 10.1847C4.20087 10.2051 4.20904 10.2215 4.2172 10.2419C4.2172 10.246 4.2172 10.246 4.22128 10.25C4.22945 10.2664 4.23761 10.2868 4.24578 10.3031C4.24578 10.3072 4.24986 10.3113 4.24986 10.3113C4.25803 10.3276 4.26619 10.3439 4.27844 10.3603C4.28252 10.3644 4.28252 10.3684 4.2866 10.3725C4.29885 10.3888 4.30702 10.4052 4.31926 10.4174C4.32335 10.4215 4.32335 10.4215 4.32743 10.4256C4.34376 10.4419 4.35601 10.4623 4.37642 10.4787L8.41398 14.5121C8.6875 14.7857 9.13249 14.7857 9.40602 14.5121C9.67954 14.2386 9.67954 13.7936 9.40602 13.5201L6.56462 10.6787L17.8608 10.6787C18.2486 10.6787 18.563 10.3644 18.563 9.9806C18.563 9.59277 18.2486 9.27842 17.8608 9.27842L6.56054 9.27842L9.38152 6.45743C9.65505 6.18391 9.65505 5.73892 9.38152 5.4654C9.2468 5.33067 9.06717 5.26127 8.88754 5.26127C8.70791 5.26127 8.52829 5.33067 8.39356 5.4654L4.3805 9.47846C4.36009 9.50295 4.34376 9.51928 4.32743 9.53561Z" />
                                    <path d="M3.80077 1.40029H9.02633C9.41416 1.40029 9.72851 1.08594 9.72851 0.702184C9.72851 0.31435 9.41416 0 9.02633 0H3.80077C1.70647 0 0 1.70647 0 3.80078V16.1992C0 18.2935 1.70647 20 3.80077 20H8.94059C9.32843 20 9.64278 19.6856 9.64278 19.3019C9.64278 18.9141 9.32843 18.5997 8.94059 18.5997H3.80077C2.47806 18.5997 1.40029 17.5219 1.40029 16.1992V3.80078C1.40437 2.47397 2.47806 1.40029 3.80077 1.40029Z" />
                                </svg>
                            </a>
                        </li>
                    <?php } ?>
                    <li class="topMenu__item">
                        <a href="<?= $home ?>wishlist/">
                            <svg width="23" height="20" viewBox="0 0 23 20" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
                                <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485ZM6.25427 1.34176C4.89584 1.34176 3.64793 1.8839 2.74009 2.86843C1.81875 3.86783 1.31129 5.24931 1.31129 6.75856C1.31129 8.351 1.90313 9.77519 3.23013 11.3763C4.51272 12.924 6.42046 14.5498 8.62934 16.4322L8.63344 16.4356C9.40566 17.0938 10.281 17.8398 11.1921 18.6365C12.1087 17.8383 12.9854 17.091 13.7592 16.4319C15.9679 14.5494 17.8755 12.924 19.1581 11.3763C20.4849 9.77519 21.0767 8.351 21.0767 6.75856C21.0767 5.24931 20.5693 3.86783 19.6479 2.86843C18.7403 1.8839 17.4922 1.34176 16.1339 1.34176C15.1388 1.34176 14.2252 1.65809 13.4184 2.28188C12.6995 2.83803 12.1987 3.54107 11.9051 4.033C11.7541 4.28596 11.4883 4.43695 11.194 4.43695C10.8997 4.43695 10.6339 4.28596 10.4829 4.033C10.1895 3.54107 9.68869 2.83803 8.96959 2.28188C8.16287 1.65809 7.24922 1.34176 6.25427 1.34176Z" />
                            </svg>
                            <span id="wishlist-total"><span><?php echo $text_wishlist; ?></span></span>
                        </a>
                    </li>
                    <li class="topMenu__item">
                        <a href="<?= $home ?>compare-products/">
                            <svg width="18" height="20" viewBox="0 0 18 20" xmlns="http://www.w3.org/2000/svg" class="topMenu__icon">
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M1.06667 10.9333V18.9333H3.46667V10.9333H1.06667ZM0.8 9.86667C0.358172 9.86667 0 10.2248 0 10.6667V19.2C0 19.6418 0.358172 20 0.8 20H3.73333C4.17516 20 4.53333 19.6418 4.53333 19.2V10.6667C4.53333 10.2248 4.17516 9.86667 3.73333 9.86667H0.8Z" />
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M7.46669 1.06667V18.9333H9.86669V1.06667H7.46669ZM7.20002 0C6.7582 0 6.40002 0.358173 6.40002 0.8V19.2C6.40002 19.6418 6.7582 20 7.20002 20H10.1334C10.5752 20 10.9334 19.6418 10.9334 19.2V0.8C10.9334 0.358172 10.5752 0 10.1334 0H7.20002Z" />
                                <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6 5.33333V18.9333H16V5.33333H13.6ZM13.3333 4.26666C12.8915 4.26666 12.5333 4.62484 12.5333 5.06666V19.2C12.5333 19.6418 12.8915 20 13.3333 20H16.2667C16.7085 20 17.0667 19.6418 17.0667 19.2V5.06666C17.0667 4.62483 16.7085 4.26666 16.2667 4.26666H13.3333Z" />
                            </svg>
                            <span id="compare-total"><?php echo $text_compare; ?></span>
                        </a>
                    </li>
                    <li class="topMenu__item topMenu__item_cart"><?php echo $cart; ?></li>
                </ul>
                <?php echo $search; ?>
            </div>
            <?php echo $header_bottom; ?>
        </header>
