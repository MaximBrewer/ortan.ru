<?php
$uniqid = uniqid();
?>
<section class="productm guid-<?php echo $product_id; ?> <?php if (isset($is_ajax) && $is_ajax) { ?>productmAjax<?php } else { ?>productmH<?php } ?>">
    <div class="productm__container container">
        <?php echo $content_top; ?>
        <h1 class="h3"><?php echo $heading_title; ?></h1>
        <div class="productm__wrapper" id="product">
            <div class="productm__view">
                <div style="position:relative;">
                    <div class="product__top">
                        <?php if ($special) { ?><p class="product__label product__label_red">РАСПРОДАЖА</p><?php } ?>
                        <?php if (isset($novelty) && $novelty) { ?><p class="product__label product__label_green">НОВИНКА</p><?php } ?>
                        <?php if (isset($bestseller) && $bestseller) { ?><p class="product__label">БЕСТСЕЛЛЕР</p><?php } ?>
                        <div class="opbtn__emotions">
                            <a class="opbtn__img opbtn__img_like opbtn__child" href="/wishlist" data-wishlist="<?php echo $product_id; ?>">
                                <svg width="23" height="20" viewBox="0 0 23 20" fill="none" class="productm__icon" xmlns="http://www.w3.org/2000/svg">
                                    <title>В закладки</title>
                                    <g>
                                        <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485Z" fill="none" />
                                    </g>
                                    <path d="M11.194 19.9485C10.8753 19.9485 10.568 19.833 10.3285 19.6232C9.42411 18.8324 8.55214 18.0892 7.78282 17.4337L7.77889 17.4302C5.52339 15.5082 3.57567 13.8483 2.22049 12.2131C0.705604 10.3851 0 8.65196 0 6.75856C0 4.91897 0.63079 3.22183 1.77605 1.97955C2.93498 0.722585 4.52519 0.030304 6.25427 0.030304C7.5466 0.030304 8.73012 0.438874 9.77187 1.24457C10.2976 1.65126 10.7742 2.14899 11.194 2.72957C11.614 2.14899 12.0904 1.65126 12.6163 1.24457C13.6581 0.438874 14.8416 0.030304 16.1339 0.030304C17.8628 0.030304 19.4532 0.722585 20.6121 1.97955C21.7574 3.22183 22.388 4.91897 22.388 6.75856C22.388 8.65196 21.6826 10.3851 20.1677 12.2129C18.8125 13.8483 16.865 15.508 14.6098 17.4299C13.8391 18.0865 12.9658 18.8309 12.0593 19.6236C11.82 19.833 11.5126 19.9485 11.194 19.9485ZM6.25427 1.34176C4.89584 1.34176 3.64793 1.8839 2.74009 2.86843C1.81875 3.86783 1.31129 5.24931 1.31129 6.75856C1.31129 8.351 1.90313 9.77519 3.23013 11.3763C4.51272 12.924 6.42046 14.5498 8.62934 16.4322L8.63344 16.4356C9.40566 17.0938 10.281 17.8398 11.1921 18.6365C12.1087 17.8383 12.9854 17.091 13.7592 16.4319C15.9679 14.5494 17.8755 12.924 19.1581 11.3763C20.4849 9.77519 21.0767 8.351 21.0767 6.75856C21.0767 5.24931 20.5693 3.86783 19.6479 2.86843C18.7403 1.8839 17.4922 1.34176 16.1339 1.34176C15.1388 1.34176 14.2252 1.65809 13.4184 2.28188C12.6995 2.83803 12.1987 3.54107 11.9051 4.033C11.7541 4.28596 11.4883 4.43695 11.194 4.43695C10.8997 4.43695 10.6339 4.28596 10.4829 4.033C10.1895 3.54107 9.68869 2.83803 8.96959 2.28188C8.16287 1.65809 7.24922 1.34176 6.25427 1.34176Z" fill="#323031" />
                                </svg>
                            </a>
                            <a class="opbtn__img opbtn__img_comp opbtn__child" href="/compare-products" data-compare="<?php echo $product_id; ?>">
                                <svg width="18" height="20" viewBox="0 0 18 20" fill="none" class="productm__icon" xmlns="http://www.w3.org/2000/svg">
                                    <title>В сравнение</title>
                                    <g>
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M1.06667 10.9333V18.9333H3.46667V10.9333H1.06667Z" fill="none" />
                                    </g>
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M1.06667 10.9333V18.9333H3.46667V10.9333H1.06667ZM0.8 9.86667C0.358172 9.86667 0 10.2248 0 10.6667V19.2C0 19.6418 0.358172 20 0.8 20H3.73333C4.17516 20 4.53333 19.6418 4.53333 19.2V10.6667C4.53333 10.2248 4.17516 9.86667 3.73333 9.86667H0.8Z" fill="#323031" />
                                    <g>
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M7.46669 1.06667V18.9333H9.86669V1.06667H7.46669Z" fill="none" />
                                    </g>
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M7.46669 1.06667V18.9333H9.86669V1.06667H7.46669ZM7.20002 0C6.7582 0 6.40002 0.358173 6.40002 0.8V19.2C6.40002 19.6418 6.7582 20 7.20002 20H10.1334C10.5752 20 10.9334 19.6418 10.9334 19.2V0.8C10.9334 0.358172 10.5752 0 10.1334 0H7.20002Z" fill="#323031" />
                                    <g>
                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6 5.33333V18.9333H16V5.33333H13.6Z" fill="none" />
                                    </g>
                                    <path fill-rule="evenodd" clip-rule="evenodd" d="M13.6 5.33333V18.9333H16V5.33333H13.6ZM13.3333 4.26666C12.8915 4.26666 12.5333 4.62484 12.5333 5.06666V19.2C12.5333 19.6418 12.8915 20 13.3333 20H16.2667C16.7085 20 17.0667 19.6418 17.0667 19.2V5.06666C17.0667 4.62483 16.7085 4.26666 16.2667 4.26666H13.3333Z" fill="#323031" />
                                </svg>
                            </a>
                        </div>
                    </div>
                    <div class="pMain">
                        <?php if ($thumb) { ?>
                            <div class="pMain__slide">
                                <a data-fancybox="gallery1" href="<?php echo $popup; ?>"><img src="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="pMain__img"></a>
                            </div>
                        <?php } ?>
                        <?php if ($images) { ?>
                            <?php foreach ($images as $image) { ?>
                                <div class="pMain__slide">
                                    <a data-fancybox="gallery1" href="<?php echo $image['popup']; ?>"><img src="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" class="pMain__img"></a>
                                </div>
                            <?php } ?>
                        <?php } ?>
                    </div>
                </div>
                <div class="pThumb">
                    <?php if ($thumb) { ?>
                        <div class="pThumb__slide"><img src="<?php echo $popup; ?>" alt="<?php echo $heading_title; ?>" class="pThumb__img"></div>
                    <?php } ?>
                    <?php if ($images) { ?>
                        <?php foreach ($images as $image) { ?>
                            <div class="pThumb__slide"><img src="<?php echo $image['popup']; ?>" alt="<?php echo $heading_title; ?>" class="pThumb__img"></div>
                        <?php } ?>
                    <?php } ?>
                </div>
                <div class="productm__mobile">
                    <div class="productm__mobileDots"></div>
                </div>
            </div>
            <div class="productm__options options">
                <div class="option__data data">
                    <div class="data__info">
                        Артикул: <span class="data__text"><?php echo $model; ?></span>

                        <?php if ($options) { ?>
                            <?php foreach ($options as $option) {
                                if (($option['name'] == 'Бренд' || $option['name'] == 'Цвет') && isset($option['product_option_value'][0])) { ?> / <?php echo $option['name']; ?>
                                    <span class="data__text"><?php echo $option['product_option_value'][0]['name']; ?></span>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </div>
                    <p class="data__info">
                        Наличие:<span class="data__text"> <?php echo $stock == 'В наличии' ? 'В наличии' : 'Уточняйте наличие'; ?></span>
                    </p>
                    <?php if ($price) { ?>
                        <meta id="priceed" data-price="<?php echo $special ? $special : $price; ?>" />
                        <ul class="list-unstyled">
                            <?php if (!$special) { ?>
                                <p class="data__newPrice" style="display:none"><?php echo $price; ?></p>
                            <?php } else { ?>
                                <p class="data__oldPrice"><?php echo $price; ?></p>
                                <p class="data__newPrice" style="display:none"><?php echo $special; ?></p>
                            <?php }
                            /*if ($tax) { ?>
                    <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
                  <?php } ?>
                  <?php if ($points) { ?>
                    <li><?php echo $text_points; ?> <?php echo $points; ?></li>
                  <?php } ?>
                  <?php if ($discounts) { ?>
                    <li>
                      <hr>
                    </li>
                    <?php foreach ($discounts as $discount) { ?>
                      <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
                    <?php } ?>
                  <?php }*/ ?>
                        </ul>
                    <?php } ?>
                </div>
                <?php if ($options) { ?>
                    <?php foreach ($options as $option) { ?>
                        <?php if (in_array($option['name'], ['Омологация', 'Подогрев'])) { ?>
                            <!--<?php var_dump($option['name']); ?> -->
                            <div class="product__toggler">
                                <?php foreach ($option['product_option_value'] as $kd => $option_value) { ?>
                                    <button>
                                        <input type="radio" <?php if ($kd) { ?> checked <?php } ?> class="choption" data-price="<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>" id="option-<?php echo $option['product_option_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>">
                                        <label for="option-<?php echo $option['product_option_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>">
                                            <span><?php echo $option_value['name']; ?>
                                                <?php /* if ($option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php }*/ ?>
                                            </span>
                                        </label>
                                    </button>
                                <?php } ?>
                            </div>
                        <?php } ?>
                    <?php } ?>
                <?php } ?>
                <div class="filter__size size">
                    <?php if ($options) { ?>
                        <?php foreach ($options as $option) {
                            if ($option['name'] == 'Размер') { ?>
                                <?php foreach ($option['product_option_value'] as $option_value) { ?>
                                    <div class="size__top">
                                        <p class="filter__name options__heading">Выберите размер: <span class="redstar">*</span></p>
                                    </div>
                                <?php break;
                                } ?>
                            <?php } ?>
                        <?php } ?>
                    <?php } ?>
                    <div class="size__form">
                        <?php if ($options) { ?>
                            <?php foreach ($options as $option) {
                                if ($option['name'] == 'Размер') { ?>
                                    <?php foreach ($option['product_option_value'] as $kd => $option_value) { ?>
                                        <label class="size__item" for="option-<?php echo $option['product_option_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>">
                                            <input type="radio" <?php if (!$kd && count($option['product_option_value']) < 2) { ?> checked <?php } ?> id="option-<?php echo $option['product_option_id']; ?>-<?php echo $option_value['product_option_value_id']; ?>" class="size__checkbox filter__input" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>">
                                            <span class="size__checkName"><?php echo $option_value['name']; ?>
                                                <?php if ($option_value['price']) { ?>
                                                    (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                                                <?php } ?>
                                            </span>
                                        </label>
                                    <?php } ?>
                                <?php } ?>
                            <?php } ?>
                        <?php } ?>
                    </div>
                    <?php if ($sizes) { ?>
                        <a data-fancybox="sizes" href="<?php echo $sizes; ?>" class="size__link" alt="<?php echo $sizesalt ?? ""; ?>">Таблица размеров</a>
                    <?php } ?>
                    <div class="size__hint"><?php echo $text_size_hint; ?></div>
                </div>
                <div class="options__btns opbtn">
                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                    <div class="cartPopup__add opbtn__child">
                        <button class="cartPopup__sign cartPopup__less">-</button>
                        <input type="hidden" name="quantity" value="<?php echo $minimum; ?>" data-minimum="<?php echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
                        <span class="cartPopup__number"><?php echo $minimum; ?></span>
                        <button class="cartPopup__sign cartPopup__more">+</button>
                    </div>
                    <button class="opbtn__addCart opbtn__child btn btn_red" id="button-cart"><span class="btnBuyShine">ДОБАВИТЬ В КОРЗИНУ</span></button>
                    <?php /*if ($minimum > 1) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
          <?php } */ ?>

                    <?php
                    if (1 || (!isset($is_ajax) || !$is_ajax)) { ?>
                        <button type="button" id="tinkoff-button-<?php echo $product_id; ?>" style="margin-bottom: 13px;margin-right:13px;height: 48px;display:none;" class="TINKOFF_BTN_YELLOW TINKOFF_SIZE_M" onclick="
                        var price = $('.guid-<?php echo $product_id; ?> .data__newPrice').text().replace(/[^\d.]/ig, '') * 1;
                        var quantity = $('.guid-<?php echo $product_id; ?> .cartPopup__number').text() * 1;
                        var sum = quantity * price;
                        
                        console.log(price, quantity, sum)

                        tinkoff.create(
                            {
                                shopId: '84c12bfd-c27c-4e9f-a561-691fdc140ad4',
                                showcaseId: '2e2340c4-ad33-43bf-b2fe-f71871bf8169',
                                items: [
                                    {
                                        name: '<?php echo $heading_title; ?>',
                                        price: price,
                                        quantity: quantity
                                    }
                                ],
                                promoCode: 'installment_0_0_3_5,19',
                                sum: sum
                            },
                            {
                                view: 'modal'
                            }
                        );
                        ym(53398495,'reachGoal','requestCredit');
                        ">Купить в рассрочку</button>
                        <script>
                            var prx = $('.guid-<?php echo $product_id; ?> .data__newPrice').text().replace(/[^\d.]/ig, '') * 1;
                            if (prx >= 3000) $('#tinkoff-button-<?php echo $product_id; ?>').show()
                        </script>
                    <?php } ?>
                    <a href="#" class="opbtn__buy btn" data-toggle="modal" data-target="#oneclickModal-<?php echo $uniqid; ?>">купить в 1 клик</a>
                </div>
                <?php if (isset($bestseller) && !empty($similars)) { ?>
                    <div class="options__color prcolor">
                        <p class="prcolor__heading options__heading">Доступные цвета:</p>
                        <div class="prcolor__wrapper">
                            <span class="prcolor__item active" href="<?php echo $pr['href']; ?>"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" class="prcolor__thumb"></span>
                            <?php foreach ($similars as $pr) { ?>
                                <?php if ($pr['product_id'] == $product_id) continue; ?>
                                <a class="prcolor__item" href="<?php echo $pr['href']; ?>"><img src="<?php echo $pr['thumb']; ?>" alt="<?php echo $pr['name']; ?>" class="prcolor__thumb"></a>
                            <?php } ?>
                        </div>
                    </div>
                <?php } ?>
                <?php if (isset($is_ajax) && $is_ajax) { ?><br />
                    <div><a href="<?php echo $href; ?>">Больше информации о товаре</a></div><? } ?>
            </div>
        </div>
        <div class="productm__tabs prtabs">
            <div class="prtabs__tabs">
                <span class="prtabs__tab">Описание</span>
                <span class="prtabs__tab">Характеристики</span>
                <span class="prtabs__tab">Доставка и оплата</span>
                <span class="prtabs__tab">Как выбрать размер</span>
                <?php if ($youtube ?? 0) { ?><span class="prtabs__tab">Видео</span> <?php } ?>
                <!--span class="prtabs__tab">Отзывы <span class="prtabs__testimonials"><?php echo $reviews; ?></span></span-->
            </div>
            <div class="prtabs__content">
                <div class="prtabs__item ">
                    <span class="prtabs__name">Описание</span>
                    <div class="tabs__more tabs__more_50">
                        <?php echo $description; ?>
                    </div>
                    <p class="tabs__show">Развернуть</p>
                </div>
                <div class="prtabs__item prfeatures">
                    <span class="prtabs__name">Характеристики</span>
                    <div class="tabs__more tabs__more_50">
                        <ul class="prfeatures__list">

                            <?php if ($options) { ?>
                                <?php foreach ($options as $option) { 
                                    if (in_array($option['name'], ['Омологация', 'Подогрев'])) continue; ?>
                                    <li class="prfeatures__item">
                                        <p class="prfeatures__box">
                                            <span class="prfeatures__name" style="white-space:nowrap"><?php echo $option['name']; ?></span>
                                            <span class="prfeatures__dots"></span>
                                        </p>
                                        <span class="prfeatures__answer">
                                            <?php
                                            switch ($option['type']) {
                                                case 'select':
                                                case 'radio':
                                                case 'checkbox':
                                                    foreach ($option['product_option_value'] as $key => $option_value) {
                                                        if ($key) echo ', ';
                                                        if ($option['keyword'] && $option_value['keyword']) {
                                                            echo '<a href="/tovary/' . $option['keyword'] . '/' . $option_value['keyword'] . '/' . '" style="white-space:nowrap">' . $option_value['name'] . '</a>';
                                                        } else {
                                                            echo '<span style="white-space:nowrap">' . $option_value['name'] . '</span>';
                                                        }
                                                    }
                                                    break;
                                                default:
                                                    echo $option['value'];
                                                    break;
                                            } ?>
                                        </span>
                                    </li>
                                <?php } ?>
                            <?php } ?>

                            <?php /* foreach ($attribute_groups as $attribute_group) {
                                // echo $attribute_group['name']; 
                                foreach ($attribute_group['attribute'] as $attribute) { ?>
                                    <li class="prfeatures__item">
                                        <p class="prfeatures__box">
                                            <span class="prfeatures__name"><?php echo $attribute['name']; ?></span>
                                            <span class="prfeatures__dots"></span>
                                        </p>
                                        <span class="prfeatures__answer"><?php echo $attribute['text']; ?></span>
                                    </li>
                                <?php  }
                            } */ ?>
                        </ul>
                    </div>
                    <p class="tabs__show">Развернуть</p>
                </div>
                <div class="prtabs__item">
                    <span class="prtabs__name">Доставка и оплата</span>
                    <div class="tabs__more tabs__more_50">
                        <?php echo html_entity_decode($config['config_langdata'][1]['delivery_text'], ENT_QUOTES, 'UTF-8'); ?>
                    </div>
                    <p class="tabs__show">Развернуть</p>
                </div>
                <div class="prtabs__item">
                    <span class="prtabs__name">Как выбрать размер</span>
                    <div class="tabs__more tabs__more_50">
                        <?php echo html_entity_decode($config['config_langdata'][1]['sizing_text'], ENT_QUOTES, 'UTF-8'); ?>
                    </div>
                    <p class="tabs__show">Развернуть</p>
                </div>
                <?php if ($youtube ?? 0) { ?>
                    <div class="prtabs__item video">
                        <span class="prtabs__name">Видео</span>
                        <div class="video__wrapper">
                            <iframe src="https://www.youtube.com/embed/<?php echo $youtube; ?>" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                        </div>
                    </div>
                <?php } ?>
                <?php if (!isset($is_ajax) || !$is_ajax) { ?>
                    <div class="prtabs__item prtesti">
                        <div id="review"></div>
                        <p class="tabs__show">Развернуть</p>
                    </div>
                <?php } else { ?>
                    <div class="prtabs__item prtesti">
                        <div id="reviewAjax"></div>
                        <p class="tabs__show">Развернуть</p>
                    </div>
                <?php } ?>
            </div>
        </div>
    </div>
</section>
<div class="modal fade" tabindex="-1" role="dialog" id="oneclickModal-<?php echo $uniqid; ?>">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="callBack-modal">
                <div class="city__close" data-dismiss="modal" aria-label="Close">
                    <svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg" class="city__icon">
                        <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="#323031" />
                    </svg>
                </div>
                <div id="popup__formWrapper-<?php echo $uniqid; ?>"></div>
            </div>
        </div>
    </div>
</div>
<script>
    $("#popup__formWrapper-<?php echo $uniqid; ?>").load('index.php?route=product/oneclick&product_id=<?php echo $product_id; ?>&uniqid=<?php echo $uniqid; ?>')
    $('.choption').on('change', function(e) {
        if ($(this).prop('checked')) {
            var total = $("#priceed").data('price').replace(/[^+\d]/g, '') * 1 + $(this).data('price').replace(/[^-\d]/g, '') * 1;
            $('.guid-<?php echo $product_id; ?> .data__newPrice').text(number_format(total, 0, '.', ' '));
        }
    })
    $(function() {
        $('.choption').each(function(e) {
            if ($(this).prop('checked')) {
                var total = $("#priceed").data('price').replace(/[^+\d]/g, '') * 1 + $(this).data('price').replace(/[^-\d]/g, '') * 1;
                $('.guid-<?php echo $product_id; ?> .data__newPrice').text(number_format(total, 0, '.', ' '));
            }
        });
        $('.guid-<?php echo $product_id; ?> .data__newPrice').show();
    })

    function number_format(number, decimals, dec_point, thousands_sep) { // Format a number with grouped thousands
        // 
        // +   original by: Jonas Raoni Soares Silva (http://www.jsfromhell.com)
        // +   improved by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
        // +	 bugfix by: Michael White (http://crestidg.com)

        var i, j, kw, kd, km;

        // input sanitation & defaults
        if (isNaN(decimals = Math.abs(decimals))) {
            decimals = 2;
        }
        if (dec_point == undefined) {
            dec_point = ",";
        }
        if (thousands_sep == undefined) {
            thousands_sep = ".";
        }

        i = parseInt(number = (+number || 0).toFixed(decimals)) + "";

        if ((j = i.length) > 3) {
            j = j % 3;
        } else {
            j = 0;
        }

        km = (j ? i.substr(0, j) + thousands_sep : "");
        kw = i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands_sep);
        //kd = (decimals ? dec_point + Math.abs(number - i).toFixed(decimals).slice(2) : "");
        kd = (decimals ? dec_point + Math.abs(number - i).toFixed(decimals).replace(/-/, 0).slice(2) : "");


        return km + kw + kd;
    }
</script>