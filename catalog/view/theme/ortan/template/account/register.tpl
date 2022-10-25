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
    <h1 class="authorization__heading innerHeading">регистрация</h1>
    <div class="authorization_prof">
      <div class="authorization__forms">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="authForm form-horizontal goodsin">
          <input type="hidden" name="address_2" value="" />
          <fieldset id="account" class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">личные данные</p>
            <div class="form-group required" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;">
              <label class="authForm__label"><?php echo $entry_customer_group; ?></label>
              <div class="col-sm-10">
                <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" checked="checked" />
                        <?php echo $customer_group['name']; ?></label>
                    </div>
                  <?php } else { ?>
                    <div class="radio">
                      <label>
                        <input type="radio" name="customer_group_id" value="<?php echo $customer_group['customer_group_id']; ?>" />
                        <?php echo $customer_group['name']; ?></label>
                    </div>
                  <?php } ?>
                <?php } ?>
              </div>
            </div>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label"><?php echo $entry_lastname; ?><span class="authForm__requireStar">*</span></label>
              <input type="text" name="lastname" value="<?php echo $lastname; ?>" placeholder="<?php echo $entry_lastname; ?>" id="input-lastname" class="input" />
              <?php if ($error_lastname) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_lastname ?></span>
              <?php } ?>
            </p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label"><?php echo $entry_firstname; ?><span class="authForm__requireStar">*</span></label>
              <input type="text" name="firstname" value="<?php echo $firstname; ?>" placeholder="<?php echo $entry_firstname; ?>" id="input-firstname" class="input" />
              <?php if ($error_firstname) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_firstname; ?></span>
              <?php } ?>
            </p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label"><?php echo $entry_email; ?><span class="authForm__requireStar">*</span></label>
              <input type="email" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email" class="input" />
              <?php if ($error_email) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_email; ?></span>
              <?php } ?>
            </p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label"><?php echo $entry_telephone; ?><span class="authForm__requireStar">*</span></label>
              <input type="telephone" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-telephone" class="input" />
              <?php if ($error_telephone) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_telephone; ?></span>
              <?php } ?>
            </p>
            <input type="hidden" name="fax" value="<?php echo $fax; ?>" placeholder="<?php echo $entry_fax; ?>" id="input-fax" class="input" />
            <?php foreach ($custom_fields as $custom_field) { ?>
              <?php if ($custom_field['location'] == 'account') { ?>
                <?php if ($custom_field['type'] == 'select') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="authForm__input custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10 goodsin__selectWrapper">
                      <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="goodsin__select">
                        <option value=""><?php echo $text_select; ?></option>
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                          <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
                          <?php } else { ?>
                            <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                          <?php } ?>
                        <?php } ?>
                      </select>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'radio') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <div>
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                          <div class="radio">
                            <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                              <label>
                                <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                <?php echo $custom_field_value['name']; ?></label>
                            <?php } else { ?>
                              <label>
                                <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                <?php echo $custom_field_value['name']; ?></label>
                            <?php } ?>
                          </div>
                        <?php } ?>
                      </div>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'checkbox') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <div>
                        <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                          <div class="checkbox">
                            <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
                              <label>
                                <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                                <?php echo $custom_field_value['name']; ?></label>
                            <?php } else { ?>
                              <label>
                                <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                                <?php echo $custom_field_value['name']; ?></label>
                            <?php } ?>
                          </div>
                        <?php } ?>
                      </div>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'text') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'textarea') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'file') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                      <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'date') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <div class="input-group date">
                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span>
                      </div>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'time') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <div class="input-group time">
                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span>
                      </div>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
                <?php if ($custom_field['type'] == 'datetime') { ?>
                  <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                    <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                    <div class="col-sm-10">
                      <div class="input-group datetime">
                        <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                        <span class="input-group-btn">
                          <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                        </span>
                      </div>
                      <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                        <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                      <?php } ?>
                    </div>
                  </div>
                <?php } ?>
              <?php } ?>
            <?php } ?>
          </fieldset>
          <fieldset id="address" class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">адрес доставки</p>
            <input type="hidden" name="company" value="<?php echo $company; ?>" placeholder="<?php echo $entry_company; ?>" id="input-company" class="input" />
            <div class="authForm__input required">
              <label class="authForm__label" for="input-country"><?php echo $entry_country; ?></label>
              <div class="col-sm-10 goodsin__selectWrapper">
                <select name="country_id" id="input-country" class="goodsin__select">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($countries as $country) { ?>
                    <?php if ($country['country_id'] == $country_id) { ?>
                      <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
                    <?php } else { ?>
                      <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
                    <?php } ?>
                  <?php } ?>
                </select>
                <?php if ($error_country) { ?>
                  <span class="authForm__error" style="display:block;"><?php echo $error_country; ?></span>
                <?php } ?>
              </div>
            </div>
            <div class="authForm__input required">
              <label class="authForm__label" for="input-zone"><?php echo $entry_zone; ?></label>
              <div class="col-sm-10 goodsin__selectWrapper">
                <select name="zone_id" id="input-zone" class="goodsin__select">
                </select>
                <?php if ($error_zone) { ?>
                  <span class="authForm__error" style="display:block;"><?php echo $error_zone; ?></span>
                <?php } ?>
              </div>
            </div>
            <div class="authForm__input required">
              <label class="authForm__label" for="input-address-1"><?php echo $entry_address_1; ?></label>
              <div class="col-sm-10">
                <input type="text" name="address_1" value="<?php echo $address_1; ?>" placeholder="<?php echo $entry_address_1; ?>" id="input-address-1" class="input" />
                <?php if ($error_address_1) { ?>
                  <span class="authForm__error" style="display:block;"><?php echo $error_address_1; ?></span>
                <?php } ?>
              </div>
            </div>
            <div class="authForm__input required">
              <label class="authForm__label" for="input-city"><?php echo $entry_city; ?></label>
              <div class="col-sm-10">
                <input type="text" name="city" value="<?php echo $city; ?>" placeholder="<?php echo $entry_city; ?>" id="input-city" class="input" />
                <?php if ($error_city) { ?>
                  <span class="authForm__error" style="display:block;"><?php echo $error_city; ?></span>
                <?php } ?>
              </div>
            </div>
            <input type="hidden" name="postcode" value="<?php echo $postcode; ?>" placeholder="<?php echo $entry_postcode; ?>" id="input-postcode" class="input" />
            <?php /*foreach ($custom_fields as $custom_field) { ?>
            <?php if ($custom_field['location'] == 'address') { ?>
              <?php if ($custom_field['type'] == 'select') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <select name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input">
                      <option value=""><?php echo $text_select; ?></option>
                      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>" selected="selected"><?php echo $custom_field_value['name']; ?></option>
                        <?php } else { ?>
                          <option value="<?php echo $custom_field_value['custom_field_value_id']; ?>"><?php echo $custom_field_value['name']; ?></option>
                        <?php } ?>
                      <?php } ?>
                    </select>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'radio') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <div>
                      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="radio">
                          <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && $custom_field_value['custom_field_value_id'] == $register_custom_field[$custom_field['custom_field_id']]) { ?>
                            <label>
                              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                              <?php echo $custom_field_value['name']; ?></label>
                          <?php } else { ?>
                            <label>
                              <input type="radio" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                              <?php echo $custom_field_value['name']; ?></label>
                          <?php } ?>
                        </div>
                      <?php } ?>
                    </div>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'checkbox') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <div>
                      <?php foreach ($custom_field['custom_field_value'] as $custom_field_value) { ?>
                        <div class="checkbox">
                          <?php if (isset($register_custom_field[$custom_field['custom_field_id']]) && in_array($custom_field_value['custom_field_value_id'], $register_custom_field[$custom_field['custom_field_id']])) { ?>
                            <label>
                              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" checked="checked" />
                              <?php echo $custom_field_value['name']; ?></label>
                          <?php } else { ?>
                            <label>
                              <input type="checkbox" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>][]" value="<?php echo $custom_field_value['custom_field_value_id']; ?>" />
                              <?php echo $custom_field_value['name']; ?></label>
                          <?php } ?>
                        </div>
                      <?php } ?>
                    </div>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'text') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'textarea') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <textarea name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" rows="5" placeholder="<?php echo $custom_field['name']; ?>" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input"><?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?></textarea>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'file') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <button type="button" id="button-custom-field<?php echo $custom_field['custom_field_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
                    <input type="hidden" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : ''); ?>" />
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'date') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group date">
                      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                      <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span>
                    </div>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'time') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group time">
                      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                      <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span>
                    </div>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
              <?php if ($custom_field['type'] == 'datetime') { ?>
                <div id="custom-field<?php echo $custom_field['custom_field_id']; ?>" class="form-group custom-field" data-sort="<?php echo $custom_field['sort_order']; ?>">
                  <label class="authForm__label" for="input-custom-field<?php echo $custom_field['custom_field_id']; ?>"><?php echo $custom_field['name']; ?></label>
                  <div class="col-sm-10">
                    <div class="input-group datetime">
                      <input type="text" name="custom_field[<?php echo $custom_field['location']; ?>][<?php echo $custom_field['custom_field_id']; ?>]" value="<?php echo (isset($register_custom_field[$custom_field['custom_field_id']]) ? $register_custom_field[$custom_field['custom_field_id']] : $custom_field['value']); ?>" placeholder="<?php echo $custom_field['name']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-custom-field<?php echo $custom_field['custom_field_id']; ?>" class="input" />
                      <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
                      </span>
                    </div>
                    <?php if (isset($error_custom_field[$custom_field['custom_field_id']])) { ?>
                      <span class="authForm__error" style="display:block;"><?php echo $error_custom_field[$custom_field['custom_field_id']]; ?></span>
                    <?php } ?>
                  </div>
                </div>
              <?php } ?>
            <?php } ?>
          <?php }*/ ?>
          </fieldset>

          <fieldset class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">пароль</p>
            <p class="authForm__input <?php if ($error_password) { ?>error<?php } ?>">
              <label for="authForm__password" class="authForm__label"><?php echo $entry_password; ?> <span class="authForm__requireStar">*</span></label>
              <input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" class="input" />
              <span class="authForm__error">Неверный пароль</span>
              <?php if ($error_password) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_password; ?></span>
              <?php } ?>
            </p>
            <p class="authForm__input <?php if ($error_confirm) { ?>error<?php } ?>">
              <label for="authForm__doublePassword" class="authForm__label"><?php echo $entry_confirm; ?> <span class="authForm__requireStar">*</span></label>
              <input type="password" name="confirm" value="<?php echo $confirm; ?>" placeholder="<?php echo $entry_confirm; ?>" id="input-confirm" class="input" />
              <?php if ($error_confirm) { ?>
                <span class="authForm__error" style="display:block;"><?php echo $error_confirm; ?></span>
              <?php } ?>
            </p>
          </fieldset>

          <!-- <fieldset class="authForm__wrapper authForm__wrapper_bg">
          <legend><?php echo $text_newsletter; ?></legend>
          <div class="form-group">
            <label class="authForm__label"><?php echo $entry_newsletter; ?></label>
            <div class="col-sm-10">
              <?php if ($newsletter) { ?>
                <label class="radio-inline">
                  <input type="radio" name="newsletter" value="1" checked="checked" />
                  <?php echo $text_yes; ?></label>
                <label class="radio-inline">
                  <input type="radio" name="newsletter" value="0" />
                  <?php echo $text_no; ?></label>
              <?php } else { ?>
                <label class="radio-inline">
                  <input type="radio" name="newsletter" value="1" />
                  <?php echo $text_yes; ?></label>
                <label class="radio-inline">
                  <input type="radio" name="newsletter" value="0" checked="checked" />
                  <?php echo $text_no; ?></label>
              <?php } ?>
            </div>
          </div>
        </fieldset> -->
          <?php echo $captcha; ?>
          <fieldset class="authForm__wrapper authForm__wrapper_pl" style="border-width:0;">
            <?php if ($text_agree) { ?>
              <div class="popup__check">
                <?php if ($agree) { ?>
                  <input type="checkbox" name="agree" id="checkbox-agree" value="1" checked="checked" class="popup__checkbox" />
                <?php } else { ?>
                  <input type="checkbox" name="agree" id="checkbox-agree" value="1" class="popup__checkbox" />
                <?php } ?>
                <label for="checkbox-agree" class="popup__labelCheck"></label>
                <span class="popup__info">
                  Соглашаюсь на
                  <a href="/processing/" class="popup__term">Обработку персональных данных</a>
                </span>
              </div>
            <?php } ?>
            <?php if ($error_warning) { ?>
              <span class="authForm__error" style="display:block;"><?php echo $error_warning; ?></span>
            <?php } ?>
            <br />
            <button class="authForm__submit btn btn_red" type="submit" value="<?php echo $button_continue; ?>"><?php echo $button_continue; ?></button>

          </fieldset>
        </form>
      </div>
      <?php echo $column_right; ?>
    </div>
  </div>
</section>
<script type="text/javascript">
  $(function() {

    $(".goodsin__select").styler();

    $('#account .form-group[data-sort]').detach().each(function() {
      if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#account .form-group').length) {
        $('#account .form-group').eq($(this).attr('data-sort')).before(this);
      }

      if ($(this).attr('data-sort') > $('#account .form-group').length) {
        $('#account .form-group:last').after(this);
      }

      if ($(this).attr('data-sort') == $('#account .form-group').length) {
        $('#account .form-group:last').after(this);
      }

      if ($(this).attr('data-sort') < -$('#account .form-group').length) {
        $('#account .form-group:first').before(this);
      }
    });

    $('#address .form-group[data-sort]').detach().each(function() {
      if ($(this).attr('data-sort') >= 0 && $(this).attr('data-sort') <= $('#address .form-group').length) {
        $('#address .form-group').eq($(this).attr('data-sort')).before(this);
      }

      if ($(this).attr('data-sort') > $('#address .form-group').length) {
        $('#address .form-group:last').after(this);
      }

      if ($(this).attr('data-sort') == $('#address .form-group').length) {
        $('#address .form-group:last').after(this);
      }

      if ($(this).attr('data-sort') < -$('#address .form-group').length) {
        $('#address .form-group:first').before(this);
      }
    });

    $('input[name=\'customer_group_id\']').on('change', function() {
      $.ajax({
        url: 'index.php?route=account/register/customfield&customer_group_id=' + this.value,
        dataType: 'json',
        success: function(json) {
          $('.custom-field').hide();
          $('.custom-field').removeClass('required');

          for (i = 0; i < json.length; i++) {
            custom_field = json[i];

            $('#custom-field' + custom_field['custom_field_id']).show();

            if (custom_field['required']) {
              $('#custom-field' + custom_field['custom_field_id']).addClass('required');
            }
          }


        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

    $('input[name=\'customer_group_id\']:checked').trigger('change');

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
                $(node).parent().find('input').after('<span class="authForm__error" style="display:block;">' + json['error'] + '</span>');
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

    $('.time').datetimepicker({
      pickDate: false
    });

    $('.datetime').datetimepicker({
      pickDate: true,
      pickTime: true
    });

    $('select[name=\'country_id\']').on('change', function() {
      $.ajax({
        url: 'index.php?route=account/account/country&country_id=' + this.value,
        dataType: 'json',
        beforeSend: function() {
          $('select[name=\'country_id\']').after(' <i class="fa fa-circle-o-notch fa-spin"></i>');
        },
        complete: function() {
          $('.fa-spin').remove();
        },
        success: function(json) {
          if (json['postcode_required'] == '1') {
            $('input[name=\'postcode\']').parent().parent().addClass('required');
          } else {
            $('input[name=\'postcode\']').parent().parent().removeClass('required');
          }

          html = '<option value=""><?php echo $text_select; ?></option>';

          if (json['zone'] && json['zone'] != '') {
            for (i = 0; i < json['zone'].length; i++) {
              html += '<option value="' + json['zone'][i]['zone_id'] + '"';

              if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
                html += ' selected="selected"';
              }

              html += '>' + json['zone'][i]['name'] + '</option>';
            }
          } else {
            html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
          }

          $('select[name=\'zone_id\']').html(html).trigger('refresh');
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    });

    $('select[name=\'country_id\']').trigger('change');
    $(function() {
      $(".goodsin__select").styler();
    })
  })
</script>
<?php echo $footer; ?>