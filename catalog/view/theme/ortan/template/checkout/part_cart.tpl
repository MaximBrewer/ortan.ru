<section class="ordering" id="ordering" style="min-height:0;">
    <div class="ordering__container container">
        <h1 class="ordering__heading innerHeading">оформление заказа</h1>
        <?php if ($attention) { ?>
            <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $attention; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($success) { ?>
            <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <?php if ($error_warning2) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning2; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php } ?>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" onsubmit="ym(53398495,'reachGoal','oformlenie'); return true;">
            <div class="cart">
                <p class="cart__top">Корзина покупок</p>
                <ul class="cartPopup__listInner">
                    <?php foreach ($products as $key => $product) { ?>
                        <li class="cartPopup__item">
                            <div style="display:flex;width:50%;align-items:center;">
                                <span class="cart__number" style="margin-right:1rem;"><?php echo $key + 1; ?></span>
                                <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="cartPopup__img" style="margin-right:1rem;">
                                <div>
                                    <a href="<?php echo $product['href']; ?>" class="cartPopup__name"><?php echo $product['name']; ?></a>
                                    <?php if (!$product['stock']) { ?>
                                        <span class="text-danger">***</span>
                                    <?php } ?>
                                    <?php if ($product['option']) { ?>
                                        <?php foreach ($product['option'] as $option) { ?>
                                            <br />
                                            <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
                                        <?php } ?>
                                    <?php } ?>
                                    <?php if ($product['reward']) { ?>
                                        <br />
                                        <small><?php echo $product['reward']; ?></small>
                                    <?php } ?>
                                    <?php if ($product['recurring']) { ?>
                                        <br />
                                        <span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="cartPopup__add">
                                <button type="button" class="cartPopup__sign cartPopup__less" onclick="cart.updateAjax('<?php echo $product['cart_id']; ?>', <?php echo $product['quantity'] - $product['minimum']; ?>);">-</button>
                                <span class="cartPopup__number"><?php echo $product['quantity']; ?></span>
                                <input type="hidden" name="quantity[<?php echo $product['cart_id']; ?>]" value="<?php echo $product['quantity']; ?>" />
                                <button type="button" class="cartPopup__sign cartPopup__more" onclick="cart.updateAjax('<?php echo $product['cart_id']; ?>', <?php echo $product['quantity'] + $product['minimum']; ?>);">+</button>
                            </div>
                            <span class="cartPopup__price"><?php echo $product['total']; ?></span>
                            <img src="/catalog/view/theme/ortan/assets/images/icon-remove-red.svg" alt="icon remove" class="cartPopup__remove" onclick="cart.removeAjax('<?php echo $product['cart_id']; ?>', 1);">
                        </li>
                    <?php } ?>
                </ul>
                <div class="cartPopup__bottom">
                    <div>
                        <?php foreach ($totals as $total) { ?>
                            <p class="cartPopup__all"><?php echo $total['title']; ?> <span><?php echo $total['text']; ?></span></p>
                        <?php break;
                        } ?>
                    </div>
                </div>
            </div>
            <div class="cart__form cart__form_1">
                <div class="cart__inputWrapper">
                    <p class="cart__input">
                        <label for="cart__name" class="cart__label">ФИО<span>*</span></label>
                        <?php if ($firstname || $lastname) { ?>
                            <input id="cart__name" placeholder="ФИО" name="fio" type="text" class="input" value="<?php echo $firstname; ?> <?php echo $lastname; ?>">
                        <?php } else { ?>
                            <input id="cart__name" placeholder="ФИО" name="fio" type="text" class="input" value="">
                        <?php } ?>
                    </p>
                    <p class="cart__input">
                        <label for="cart__tel" class="cart__label">Телефон<span>*</span></label>
                        <input id="cart__tel" placeholder="Телефон" name="telephone" type="text" class="input" value="<?php echo $telephone; ?>">
                    </p>
                    <p class="cart__input">
                        <label for="cart__mail" class="cart__label">E-mail<span>*</span></label>
                        <input id="cart__mail" placeholder="E-mail" name="email" type="text" class="input" value="<?php echo $email; ?>">
                    </p>
                </div>
                <div class="cart__steps">
                    <?php if (!$logged) { ?>
                        <a href="/login/" class="cart__btn cart__btn_registered btn" type="button">УЖЕ ЗАРЕГИСТРИРОВАНЫ?</a>
                    <?php } ?>
                    <span class="cart__step">Шаг 1 из 2</span>
                    <?php if (!$step) { ?><button class="cart__btn cart__btn_next btn btn_red" type="button">далее</button><?php } ?>
                </div>
            </div>
            <?php if ($step) { ?>
                <div class="cart step2 goodsin">
                    <p class="cart__top cart__top_2">АДРЕС ДОСТАВКИ</p>
                    <div class="cart__form cart__form_2">
                        <div class="cart__inputWrapper cart__inputWrapper_step2">
                            <select name="country_id" id="input-country" style="display:none;">
                                <option value="176" selected="selected">Российская федерация</option>
                            </select>
                            <!-- <div class="cart__input">
                                <label for="input-zone" class="cart__label">Регион<span>*</span></label>
                                <select name="zone" id="input-zone" class="select2 js-states">
                                    <option selected="selected"><?php echo $zone; ?></option>
                                </select>
                            </div> -->
                            <p class="cart__input" style="width: 66.66%;">
                                <label for="input-city" class="cart__label">Город<span>*</span></label>
                                <select name="city" id="input-city" class="select2">
                                    <option selected="selected"><?php echo $city; ?></option>
                                </select>
                            </p>
                            <p class="cart__input">
                                <label for="cart__address" class="cart__label">Адрес</label>
                                <input id="cart__address" placeholder="Адрес" name="address" type="text" class="input" value="<?php echo $address; ?>">
                            </p>
                            <p class="cart__input cart__input_text">
                                <label for="cart__comment" class="cart__label">Комментарий к заказу</label>
                                <textarea id="cart__comment" class="input" name="comment"><?php echo $comment; ?></textarea>
                            </p>
                            <div>
                                <div id="shipping-method" style="padding:1rem 0;"></div>
                                <div id="payment-method" style="padding:1rem 0;display:none;"></div>
                            </div>
                        </div>
                        <div id="confirm" style="padding:1rem 0;"></div>
                    </div>
                </div>
            <?php } ?>
        </form>
    </div>
</section>
<script type="text/javascript">
    $(function() {
        // $('#input-zone').select2({
        //     ajax: {
        //         url: 'index.php?route=extension/shipping/cdek/regions',
        //         dataType: 'json',
        //         delay: 1000
        //     },
        //     placeholder: 'Выберите регион',
        //     language: {
        //         searching: function() {
        //             return "Поиск...";
        //         },
        //         noResults: function() {
        //             return "Совпадений не найдено";
        //         }
        //     },
        // }).on('select2:select', function(e) {
        //     $('#input-city').val(null).trigger("change");
        // }).on('select2:open', function(e) {
        //     const selectId = e.target.id
        //     $(".select2-search__field[aria-controls='select2-" + selectId + "-results']").each(function(
        //         key,
        //         value,
        //     ) {
        //         value.focus()
        //     })
        // });
        $('#input-city').select2({
            ajax: {
                url: 'index.php?route=extension/shipping/cdek/cities',
                data: function(params) {
                    // if ($('#input-zone').val()) {
                    //     params.region = $('#input-zone').val()
                    // }
                    return params;
                },
                delay: 1000,
                dataType: 'json'
            },
            placeholder: 'Выберите населенный пункт',
            language: {
                searching: function() {
                    return "Поиск...";
                },
                noResults: function() {
                    return "Совпадений не найдено";
                }
            },
        }).on('select2:select', function(e) {
            // console.log($(e.target).val())
        }).on('select2:open', function(e) {
            const selectId = e.target.id
            $(".select2-search__field[aria-controls='select2-" + selectId + "-results']").each(function(
                key,
                value,
            ) {
                value.focus()
            })
        });
        $('#input-zone').trigger("change");
        refreshShipping();
    })
</script>