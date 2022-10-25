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

<section class="authorization authorization_main">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading">восстановление пароля</h1>
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="authForm">
      <div class="authForm__wrapper">
        <p class="authForm__input <?php if ($error_warning) { ?> error<?php } ?>">
          <label for="authForm__email" class="authForm__label">E-mail<span class="authForm__requireStar"></span></label>
          <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="input" />
            <?php if ($error_warning) echo '<span class="authForm__error" style="display:block">' . $error_warning . '</span>'; ?>
        </p>
        <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_continue; ?>">восстановить</button>
      </div>
    </form>
  </div>
</section>
<?php echo $footer; ?>