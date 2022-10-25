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
<section class="authorization authorization_profile">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading">смена пароля</h1>
    <div class="authorization_prof">
      <div class="authorization__forms">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
          <div class="authForm__wrapper">
            <p class="authForm__input<?php if ($error_password) { ?> error<?php } ?>">
              <label for="authForm__email" class="authForm__label"><?php echo $entry_password; ?><span class="authForm__requireStar"></span></label>
              <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="input" />
              <?php if ($error_password) echo '<span class="authForm__error" style="display:block">' . $error_password . '</span>'; ?>
            </p>
            <p class="authForm__input<?php if ($error_confirm) { ?> error<?php } ?>">
              <label for="authForm__tel" class="authForm__label"><?php echo $entry_confirm; ?><span class="authForm__requireStar"></span></label>
              <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="input" />
              <?php if ($error_confirm) echo '<span class="authForm__error" style="display:block">' . $error_confirm . '</span>'; ?>
            </p>
            <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_continue; ?>"><?php echo $button_continue; ?></button>
          </div>
        </form>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<?php echo $footer; ?>