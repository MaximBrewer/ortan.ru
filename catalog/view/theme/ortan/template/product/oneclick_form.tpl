<div class="popupForm">
    <form action="<?php echo $action; ?>" class="popup__form" id="oneclickForm-<?php echo $uniqid; ?>" method="post" enctype="multipart/form-data">
        <h4 class="popup__name">Покупка в один клик</h4>
        <p class="popup__input">
            <label for="popup__tel2" class="popup__label">Телефон</label>
            <input type="text" name="phone" value="<?php echo $phone; ?>" id="input-phone" class="input" />
            <?php if ($error_phone) echo '<span class="authForm__error" style="display:block">' . $error_phone . '</span>'; ?>
        </p>
        <p class="popup__input">
            <label for="input-name" class="popup__label">Имя</label>
            <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="input" />
            <?php if ($error_name) echo '<span class="authForm__error" style="display:block">' . $error_name . '</span>'; ?>
        </p>
        <p class="popup__input">
            <label for="input-email" class="popup__label">E-mail</label>
            <input type="text" name="email" value="<?php echo $name; ?>" id="input-email" class="input" />
            <?php if ($error_email) echo '<span class="authForm__error" style="display:block">' . $error_email . '</span>'; ?>
        </p>
        <p class="popup__input popup__input_text">
            <label for="input-enquiry" class="popup__label">Сообщение</label>
            <textarea name="enquiry" rows="10" id="input-enquiry" class="textarea"><?php echo $enquiry; ?></textarea>
            <?php if ($error_enquiry) echo '<span class="authForm__error" style="display:block">' . $error_enquiry . '</span>'; ?>
        </p>
        <div class="popup__input">
            <div class="popup__check">
                <input id="input-agree" type="checkbox" class="popup__checkbox" name="agree" <?php if($agree) echo 'checked=""';?>>
                <label for="input-agree" class="popup__labelCheck"></label>
                <span class="popup__info">
                    Соглашаюсь на
                    <a href="/obrabotka-dannyh" class="popup__term" target="_blank">Обработку персональных данных</a>
                </span>
            </div>
            <?php if ($error_agree) echo '<span class="authForm__error" style="display:block">' . $error_agree . '</span>'; ?>
        </div>
        <button type="submit" class="popup__submit btn btn_red">отправить</button>
    </form>
</div>
<script>
    $('#oneclickForm-<?php echo $uniqid; ?>').submit(function() {
        var data = {
            ajax: 1,
            name: $('#oneclickForm-<?php echo $uniqid; ?> [name=name]').val(),
            email: $('#oneclickForm-<?php echo $uniqid; ?> [name=email]').val(),
            phone: $('#oneclickForm-<?php echo $uniqid; ?> [name=phone]').val(),
            enquiry: $('#oneclickForm-<?php echo $uniqid; ?> [name=enquiry]').val(),
            agree: $('#oneclickForm-<?php echo $uniqid; ?> [name=agree]').prop('checked') * 1,
        }
        ym(53398495,'reachGoal','oneClickBuy');

        for(var opt of $('.productm__options [name^=option]:checked')){
            data[opt.name] = opt.value
        }
        
        $("#popup__formWrapper-<?php echo $uniqid; ?>").load('index.php?route=product/oneclick&product_id=<?php echo $product_id;?>&uniqid=<?php echo $uniqid;?>', data)
        return false;
    })
</script>