<?php echo $header; ?>

<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

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
    <h1 class="authorization__heading innerHeading"><?php echo $text_edit_address; ?></h1>
    <div class="authorization_prof">
      <div class="authorization__forms">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="authForm__input goodsin">
          <input type="hidden" name="company" value="" />
          <input type="hidden" name="address_2" value="" />
          <input type="hidden" name="postcode" value="" />
          <input type="hidden" name="fax" value="" />
          <div class="form-group  authForm__input authForm__input required">
            <label class="authForm__label col-sm-2 control-label" for="input-firstname"><?php echo $entry_firstname; ?></label>
            <div class="col-sm-10">
              <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="form-control" />
              <?php if ($error_firstname) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_firstname; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="form-group  authForm__input authForm__input required">
            <label class="authForm__label col-sm-2 control-label" for="input-lastname"><?php echo $entry_lastname; ?></label>
            <div class="col-sm-10">
              <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="form-control" />
              <?php if ($error_lastname) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_lastname; ?></span>
              <?php } ?>
            </div>
          </div>

          <?php
          $custom_field = $custom_fields[0];
          ?>

          <div class="form-group  authForm__input authForm__input required">
            <label class="authForm__label col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
            <div class="col-sm-10">
              <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select2">
                <option selected="selected"><?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></option>
              </select>
              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
              <?php } ?>
            </div>
          </div>

          <?php
          $custom_field = $custom_fields[1];
          ?>

          <div class="form-group  authForm__input authForm__input required">
            <label class="authForm__label col-sm-2 control-label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
            <div class="col-sm-10">
              <select name="custom_field[<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="select2">
                <option selected="selected"><?php echo (isset($address_custom_field[$custom_field['custom_field_id']]) ? $address_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></option>
              </select>
              <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
              <?php } ?>
            </div>
          </div>

          <div class="form-group  authForm__input authForm__input required">
            <label class="authForm__label col-sm-2 control-label" for="input-address-1"><?php echo $entry_address_1; ?></label>
            <div class="col-sm-10">
              <textarea type="text" name="address_1" placeholder="Адрес" id="input-address-1" class="form-control"><?php echo $address_1; ?></textarea>
              <?php if ($error_address_1) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_address_1; ?></span>
              <?php } ?>
            </div>
          </div>
          <div class="authForm__input required" style="display:none;">
            <label class="authForm__label" for="input-country"><?php echo $entry_country; ?></label>
            <div class="col-sm-10 goodsin__selectWrapper">
              <select name="country_id" id="input-country">
                <option value="176" selected="selected">Российская федерация</option>
              </select>
            </div>
          </div>
          <div class="authForm__input required" style="display:none;">
            <label class="authForm__label" for="input-zone"><?php echo $entry_zone; ?></label>
            <div class="col-sm-10 goodsin__selectWrapper">
              <select name="zone_id" id="input-zone" class="goodsin__select">
                <option value="2761" selected="selected">Москва</option>
              </select>
            </div>
          </div>
          <div class="form-group  authForm__input authForm__input required" style="display:none;">
            <label class="authForm__label col-sm-2 control-label" for="input-city"><?php echo $entry_city; ?></label>
            <div class="col-sm-10">
              <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="form-control" />
              <?php if ($error_city) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_city; ?></span>
              <?php } ?>
            </div>
          </div>
          <input type="hidden" name="default" value="1" />
          <div style="display:flex">
            <a href="<?php echo $back; ?>" class="btn btn_red"><?php echo $button_back; ?></a><span>&nbsp;</span>
            <button type="submit" value="<?php echo $button_continue; ?>" class="btn btn_red"><?php echo $button_continue; ?></button>
          </div>
        </form>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<script type="text/javascript">
  $(function() {
    $('#input-custom-field2').select2({
      ajax: {
        url: 'index.php?route=extension/shipping/cdek/regions',
        dataType: 'json'
        // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
      },
      placeholder: 'Выберите регион',
      language: {
        searching: function() {
          return "Поиск...";
        },
        noResults: function() {
          return "Совпадений не найдено";
        }
      },
    }).on('select2:select', function(e) {
      $('#input-custom-field1').val(null).trigger("change");
    }).on('select2:open', function(e) {
      const selectId = e.target.id
      $(".select2-search__field[aria-controls='select2-" + selectId + "-results']").each(function(
        key,
        value,
      ) {
        value.focus()
      })
    });
    $('#input-custom-field1').select2({
      ajax: {
        url: 'index.php?route=extension/shipping/cdek/cities',
        data: function(params) {
          if ($('#input-custom-field2').val()) {
            params.region = $('#input-custom-field2').val()
          }
          return params;
        },
        dataType: 'json'
        // Additional AJAX parameters go here; see the end of this chapter for the full code of this example
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
      console.log($(e.target).val())
    }).on('select2:open', function(e) {
      const selectId = e.target.id
      $(".select2-search__field[aria-controls='select2-" + selectId + "-results']").each(function(
        key,
        value,
      ) {
        value.focus()
      })
    });
  })
</script>
<?php echo $footer; ?>