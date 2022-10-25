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

<?php if ($error_warning) { ?>
  <div class="productm__addToCart productm__addToCart_red" style="display: flex;"><svg class="productm__addOk" width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M19.9184 2.8527L7.51783 15.2533C7.40861 15.3625 7.23175 15.3625 7.12278 15.2533L0.0817287 8.21196C-0.0272429 8.10325 -0.0272429 7.92639 0.0817287 7.81716L1.79261 6.10628C1.90184 5.99731 2.07869 5.99731 2.18766 6.10628L7.32056 11.2389L17.8127 0.746768C17.9222 0.637796 18.0985 0.637796 18.2078 0.746768L19.9184 2.45765C20.0276 2.56662 20.0276 2.74322 19.9184 2.8527Z" fill="white"></path>
    </svg>
    <p class="productm__addInfo"><?php echo $error_warning; ?></p><svg class="productm__addClose" width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M15 1.76757L13.2324 0L7.49998 5.73241L1.76757 0L0 1.76757L5.73241 7.49998L0 13.2324L1.76757 15L7.49998 9.26759L13.2324 15L15 13.2324L9.26759 7.49998L15 1.76757Z" fill="white"></path>
    </svg>
  </div>
<?php } ?>

<section class="authorization authorization_profile">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading">мой профиль</h1>
    <div class="authorization_prof">
      <div class="authorization__forms">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="authForm profile__part  active">
          <div class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">личные данные</p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label">Имя<span class="authForm__requireStar">*</span></label>
              <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="input" />
            </p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label">Фамилия<span class="authForm__requireStar">*</span></label>
              <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="input" />
            </p>
            <p class="authForm__input">
              <label for="authForm__email" class="authForm__label">E-mail<span class="authForm__requireStar">*</span></label>
              <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="input" />
            </p>
            <p class="authForm__input">
              <label for="authForm__tel" class="authForm__label">Телефон<span class="authForm__requireStar">*</span></label>
              <input type="tel" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="input" />
              <input type="hidden" name="fax" value="" />
            </p>
            <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_continue; ?>">сохранить изменения</button>
          </div>
        </form>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>


<script type="text/javascript">
  $('.form-group[data-sort]').detach().each(function() {
    if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('.form-group').length) {
      $('.form-group').eq($(this).attr('data-sort')).before(this);
    }

    if ($(this).attr('data-sort') > $('.form-group').length) {
      $('.form-group:last').after(this);
    }

    if ($(this).attr('data-sort') == $('.form-group').length) {
      $('.form-group:last').after(this);
    }

    if ($(this).attr('data-sort') < -$('.form-group').length) {
      $('.form-group:first').before(this);
    }
  });

  $('button[id^=\'button-custom-field\']').on('click', function() {
    var node = this;

    $('#form-upload').remove();

    $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

    $('#form-upload input[name=\'file\']').trigger('click');

    if (typeof timer != 'undefined') {
      clearInterval(timer);
    }

    timer = setInterval(function() {
      if ($('#form-upload input[name=\'file\']').val() != '') {
        clearInterval(timer);

        $.ajax({
          url: 'index.php?route=tool/upload',
          type: 'post',
          dataType: 'json',
          data: new FormData($('#form-upload')[0]),
          cache: false,
          contentType: false,
          processData: false,
          beforeSend: function() {
            $(node).button('loading');
          },
          complete: function() {
            $(node).button('reset');
          },
          success: function(json) {
            $(node).parent().find('.text-danger').remove();

            if (json['error']) {
              $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
            }

            if (json['success']) {
              alert(json['success']);

              $(node).parent().find('input').val(json['code']);
            }
          },
          error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
          }
        });
      }
    }, 500);
  });

  $('.date').datetimepicker({
    pickTime: false
  });

  $('.datetime').datetimepicker({
    pickDate: true,
    pickTime: true
  });

  $('.time').datetimepicker({
    pickDate: false
  });
</script>
<?php echo $footer; ?>