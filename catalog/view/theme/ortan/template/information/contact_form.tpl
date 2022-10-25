<div class="popupForm">
    <form action="#" class="form-callback" method="post" enctype="multipart/form-data" onsubmit="ym(53398495,'reachGoal','feedBackModalSend'); return true;">
        <div class="popup__heading flex-vc">
            <div>
            <span class="popup__label">
                Алеся Гвоздик
            </span>
            <span class="popup__label popup__label-feedback">
            Отвечу на ваши вопросы
            </span>
               <span class="popup__label popup__label-callback">
            Мы Вам перезвоним
            </span>
            </div>
        </div>
        <p class="popup__input popup__input-name">
            <label for="input-name" class="popup__label">Имя</label>
            <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="input" />
            <?php if ($error_name) echo '<span class="authForm__error" style="display:block">' . $error_name . '</span>'; ?>
        </p>
        <p class="popup__input popup__input-mail">
            <label for="input-email" class="popup__label">E-mail</label>
            <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="input" />
            <?php if ($error_email) echo '<span class="authForm__error" style="display:block">' . $error_email . '</span>'; ?>
        </p>
        <p class="popup__input">
            <label for="popup__tel2" class="popup__label required">Телефон</label>
            <input type="text" name="phone" value="<?php echo $phone; ?>" id="input-phone" class="input" />
            <?php if ($error_phone) echo '<span class="authForm__error" style="display:block">' . $error_phone . '</span>'; ?>
        </p>
        <p class="popup__input popup__input_text">
            <label for="input-enquiry" class="popup__label">Сообщение</label>
            <textarea name="enquiry" rows="10" id="input-enquiry" class="textarea"><?php echo $enquiry; ?></textarea>
            <?php if ($error_enquiry) echo '<span class="authForm__error" style="display:block">' . $error_enquiry . '</span>'; ?>
        </p>
        <div class="popup__input">
            <div class="popup__check">
                <input id="input-agree" checked="checked" type="checkbox" class="popup__checkbox" name="agree" <?php if($agree) echo 'checked=""';?>>
                <label for="input-agree" class="popup__labelCheck"></label>
                <span class="popup__info">
                    Соглашаюсь на
                    <a href="/privacy/" class="popup__term" target="_blank">Обработку персональных данных</a>
                </span>
            </div>
            <?php if ($error_agree) echo '<span class="authForm__error" style="display:block">' . $error_agree . '</span>'; ?>
        </div>
        <button type="submit" class="popup__submit btn btn_red">
            <span class="popup__label-feedback">
        отправить
            </span>
            <span class="popup__label-callback">
                жду звонка
            </span>

    </button>
    </form>
</div>