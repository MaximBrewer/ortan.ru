<?php if ($reviews) { ?>
  <span class="prtabs__name">Отзывы <span class="prtabs__testimonials">(<?php count($reviews); ?>)</span></span>
  <div class="tabs__more tabs__more_90">
    <ul class="prtesti__list">
      <?php foreach ($reviews as $review) { ?>
        <li class="prtesti__item">
          <div class="prtesti__top">
            <div class="prtesti__stars prtesti__left">
              <?php for ($i = 1; $i <= 5; $i++) { ?>
                <?php if ($review['rating'] < $i) { ?>
                  <img src="/catalog/view/theme/ortan/assets/images/icon-star-gray.png" alt="star" class="prtesti__img">
                <?php } else { ?>
                  <img src="/catalog/view/theme/ortan/assets/images/icon-star.png" alt="star" class="prtesti__img">
                <?php } ?>
              <?php } ?>
            </div>
            <span class="prtesti__name"><?php echo $review['author']; ?></span>
          </div>
          <div class="prtesti__data">
            <span class="prtesti__time prtesti__left"><?php echo $review['date_added']; ?></span>
            <!-- <span class="prtesti__time">14:32</span> -->
          </div>
          <p class="prtesti__text"><?php echo $review['text']; ?></p>
        </li>
      <?php } ?>
    </ul>
  </div>
  <div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
  <p><?php echo $text_no_reviews; ?></p>
<?php } ?>