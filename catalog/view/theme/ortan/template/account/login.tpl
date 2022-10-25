<?php echo $header; ?>


<div class="breadcrumbs">
  <div class="container">
    <ul class="breadcrumbs__list">
      <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li class="breadcrumbs__item"><a href="<?php echo $breadcrumb['href']; ?>" class="breadcrumbs__link"><?php echo $breadcrumb['text']; ?></a></li>
      <?php } ?>
    </ul>
  </div>
</div>


<?php if ($success) { ?>
  <div class="productm__addToCart productm__addToCart_comparison" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path>
    </svg>
    <p class="productm__addInfo"><?php echo $success; ?></p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path>
    </svg>
  </div>
<?php } ?>

<section class="authorization authorization_main">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading">авторизация</h1>
    <form class="authForm" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <div class="authForm__wrapper">
        <p class="authForm__input<?php if ($error_warning) { ?> error<?php } ?>">
          <label for="authForm__email" class="authForm__label">E-mail<span class="authForm__requireStar"></span></label>
          <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="input" />
            <?php if ($error_warning) echo '<span class="authForm__error" style="display:block">' . $error_warning . '</span>'; ?>
        </p>
        <p class="authForm__input">
          <label for="authForm__tel" class="authForm__label">Пароль<span class="authForm__requireStar"></span></label>
          <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="input" />
        </p>
        <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_login; ?>">войти</button>
        <div class="authForm__additional">
          <a href="<?php echo $register; ?>" class="authForm__forget"><?php echo $text_register; ?></a>&nbsp; &nbsp;
          <a href="<?php echo $forgotten; ?>" class="authForm__forget"><?php echo $text_forgotten; ?></a>
        </div>
      </div>
      <?php if ($redirect) { ?>
        <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
      <?php } ?>
    </form>
  </div>
</section>
<?php echo $footer; ?>