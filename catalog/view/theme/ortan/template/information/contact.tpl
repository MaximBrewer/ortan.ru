<?php echo $header;
global $cityArray; ?>
<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
<div class="breadcrumbs">
    <div class="container">
        <ul class="breadcrumbs__list">
            <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>" class="breadcrumbs__link"><?php echo $breadcrumb['text']; ?></a></li>
            <?php } ?>
        </ul>
    </div>
</div>
<script>
    var locations = [];
</script>
<section class="contacts ordering">
    <div class="contacts__container container">
        <div class="contacts__top">
            <?php echo html_entity_decode($config['config_langdata'][1]['contacts_text'], ENT_QUOTES, 'UTF-8'); ?>
        </div>
        <div class="contacts__top comparison__top">
            <h1 class="comparison__heading innerHeading"><?php echo $heading_title; ?></h1>
            <button class="contacts__back btn btn_red" data-toggle="modal" data-target="#feedBackModal">Обратная связь</button>
        </div>
        <div class="contacts__wrapper" itemscope itemtype="http://schema.org/Organization">
            <meta itemprop="name" content="ООО Ортан">
            <div class="contacts__item">
                <div class="contacts__block contacts__block_first">
                    <div class="contacts__section" itemprop="address" itemscope itemtype="http://schema.org/PostalAddress">
                        <p class="contacts__name">Адрес</p>
                        <p class="contacts__desc">
                            <span itemprop="streetAddress"><?php echo $cityArray['address']?></span>
                            <span itemprop="postalCode"><?php echo $cityArray['zip']?></span>
                            <span itemprop="addressLocality"><?php echo $cityArray['city']?></span>
                        </p>
                    </div>
                    <div class="contacts__section">
                        <p class="contacts__name">Телефон</p>
                        <p class="contacts__desc">Тел.: <span itemprop="telephone"><?php echo $cityArray['phone']?></span></p>
                    </div>
                </div>
                <div class="contacts__block contacts__block_second">
                    <div class="contacts__section">
                        <p class="contacts__name">График работы</p>
                        <p class="contacts__desc"><?php echo $config['config_langdata'][1]['open']?></p>
                    </div>
                    <div class="contacts__section">
                        <p class="contacts__name contacts__name_more">Соц сети</p>
                        <div class="contacts__socials">
                            <a rel="nofollow" target="_blank" href="<?php echo $config['config_social_telegram']; ?>" class="footer__social" style="margin-left: 0">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-telegram-gray.svg" alt="telegram" class="footer__icon">
                            </a>
                            <a rel="nofollow" target="_blank" href="<?php echo $config['config_social_vk']; ?>" class="footer__social">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-vk-gray.svg" alt="vk" class="footer__icon">
                            </a>
                            <!--a rel="nofollow" target="_blank" href="<?php echo $config['config_social_instagram']; ?>" class="footer__social">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-instagram-gray.svg" alt="instagram" class="footer__icon">
                            </a-->
                            <a rel="nofollow" target="_blank" href="<?php echo $config['config_social_youtube']; ?>" class="footer__social">
                                <img src="/catalog/view/theme/ortan/assets/images/icon-youtube-gray.svg" alt="youtube" class="footer__icon">
                            </a>
                        </div>
                    </div>
                </div>


                <div id="mapyandex" class="contacts__block contacts__block_map"></div>
                <?php if ($locc) { ?>
                    <script>
                        let maps = {
                            <?php foreach($locc as $loc) { ?>
                            "<?= $loc['city_id'] ?>": {"id": "<?= $loc['city_id'] ?>",
                                "lat": "<?= $loc['geocode']['geo_lat'] ?>",
                                "lon": "<?= $loc['geocode']['geo_lon'] ?>"},
                            <?php } ?>}

                        locations.push({
                            id: maps[<?php echo $cityArray['city_id']?>]["id"],
                            lat: maps[<?php echo $cityArray['city_id']?>]["lat"],
                            lon: maps[<?php echo $cityArray['city_id']?>]["lon"]
                        });

                        document.getElementById('mapyandex').id = 'map'+maps[<?php echo $cityArray['city_id']?>]["id"]
                    </script>
                <?php } ?>
            </div>
        </div>
</section>
<div class="modal fade" tabindex="-1" role="dialog" id="feedBackModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="callBack-modal">
                <div class="city__close" data-dismiss="modal" aria-label="Close">
                    <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg" class="city__icon">
                        <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="#323031" />
                    </svg>
                </div>
                <div id="popup__formWrapper"><?php include 'contact_form.tpl'; ?></div>
            </div>
        </div>
    </div>
</div>
<script>
    if (locations.length) {
        ymaps.ready(init);
    }

    function init() {
        for (l of locations) {
            var placemark = new ymaps.Placemark(
                [l.lat, l.lon], {}, {
                    iconColor: "#ff0000",
                }
            );
            var map = new ymaps.Map("map" + l.id, {
                center: [l.lat, l.lon],
                zoom: 13,
                controls: ["zoomControl"],
                behaviors: ["drag", "scrollZoom"],
            });
            map.geoObjects.add(placemark);
        }
    }
</script>
<?php echo $footer; ?>
