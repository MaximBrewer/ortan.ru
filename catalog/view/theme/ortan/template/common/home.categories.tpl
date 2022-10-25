<section class="home-categories">
  <?php
  $home_categories = array(
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ МОТОЦИКЛА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-motocikla/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_moto.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_moto.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ МОТОКРОССА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-motokrossa/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_motocross.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_motocross.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ КВАДРОЦИКЛА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-kvadrocikla/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_atv.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_atv.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ СНЕГОХОДА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-snegohoda/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_snowmobile.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_snowmobile.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ ГОРНЫХ ЛЫЖ',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-gornyh-lyzh/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_sky.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_sky.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ СНОУБОРДА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-snouborda/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_snowboard.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_snowboard.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ КАРТИНГА / АВТО',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-kartinga/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_carting.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_carting.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ ВЕЛОСПОРТА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-velosporta/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_bike.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_bike.webp'
    ),
    array(
      'name' => 'ЭКИПИРОВКА ДЛЯ КОННОГО СПОРТА',
      'url' => 'https://' . $lang_link . 'tovary/ekipirovka-dlya-konnogo-sporta/',
      'img' => '/catalog/view/theme/ortan/assets/images/equipment_horse.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/equipment_horse.webp'
    ),
    array(
      'name' => 'ПОДАРКИ',
      'url' => 'https://' . $lang_link . 'tovary/podarki1/',
      'img' => '/catalog/view/theme/ortan/assets/images/gifts.jpg',
      'webp' => '/catalog/view/theme/ortan/assets/images/gifts.webp'
    )
  );
  ?>
  <div class="home-categories__cat">
    <?php foreach ($home_categories as $home_category) : ?>
      <a href="<?= $home_category['url']; ?>" class="home-categories__item" title="<?= $home_category['name']; ?>">
        <div class="home-categories__link btn btn_red">Просмотреть</div>
        <img src="<?= $home_category['img']; ?>" class="home-categories__img" alt="<?= $home_category['name']; ?>">
        <div class="home-categories__box">
          <p class="home-categories__name"><?= $home_category['name']; ?></p>
        </div>
      </a>
    <?php endforeach; ?>

  </div>
</section>