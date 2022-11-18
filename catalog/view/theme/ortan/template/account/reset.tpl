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
    <h1 class="authorization__heading innerHeading"><?php echo $heading_title; ?></h1>
    <form class="authForm" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
      <div class="authForm__wrapper">

        <p class="authForm__input">
          <label for="authForm__tel" class="authForm__label">Пароль<span class="authForm__requireStar"></span></label>
          <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="input" />
              <?php if ($error_password) { ?>
              <div class="text-danger"><?php echo $error_password; ?></div>
              <?php } ?>
        </p>

        <p class="authForm__input">
          <label for="authForm__tel" class="authForm__label"><?php echo $entry_confirm; ?><span class="authForm__requireStar"></span></label>
          <input type="password" name="confirm" value="<?php echo $confirm; ?>" id="input-confirm" placeholder="<?php echo $entry_confirm; ?>" class="input" />
              <?php if ($error_confirm) { ?>
              <div class="text-danger"><?php echo $error_confirm; ?></div>
              <?php } ?>
        </p>

        <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_login; ?>"><?php echo $button_continue; ?></button>

        <?php if ($redirect) { ?>
          <input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
        <?php } ?>
    </form>
  </div>
</section>
<?php echo $footer; ?>