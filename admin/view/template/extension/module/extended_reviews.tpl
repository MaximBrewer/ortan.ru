<?php echo ($header . $column_left); ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button id="save-settings" type="submit" form="extended_reviews_settings" data-toggle="tooltip"
          title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
            class="fa fa-reply"></i></a>
      </div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach($breadcrumbs as $_key => $breadcrumb) { ?> 
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } elseif ($error_keyword) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_keyword; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } elseif ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>

    <div class="panel panel-default">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="extended_reviews_settings"
        class="form-horizontal">
        <ul class="nav nav-tabs">
          <li class="active"><a href="#main-settings" data-toggle="tab" aria-expanded="false"><?php echo $text_main_settings; ?></a></li>
          <li class=""><a href="#media-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_media_settings; ?></a></li>
          <li class=""><a href="#style-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_style_settings; ?></a></li>
          <li class=""><a href="#all-reviews-page" data-toggle="tab" aria-expanded="true"><?php echo $text_page_settings; ?></a></li>
          <li class=""><a href="#reward-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_reward_settings; ?></a></li>
          <li class=""><a href="#compatibility-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_compatibility_settings; ?></a></li>
          <li class=""><a href="#api-settings" data-toggle="tab" aria-expanded="true"><?php echo $text_api_settings; ?></a></li>
          <li class=""><a href="#tab-support" data-toggle="tab" aria-expanded="true"><?php echo $text_support; ?></a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="main-settings">

            <ul class="nav nav-tabs">
              <li class="active"><a href="#main-functions" data-toggle="tab" aria-expanded="false"><?php echo $text_functional_settings; ?></a></li>
              <li class=""><a href="#main-limitations" data-toggle="tab" aria-expanded="true"><?php echo $text_restriction_settings; ?></a>
              </li>
            </ul>
            <div class="tab-content">

              <div class="tab-pane active" id="main-functions">
                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_enable; ?>"><?php echo $entry_status; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[status]" value="1"
                        <?php echo (isset($extended_reviews['status']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_selector_help; ?>"><?php echo $text_selector; ?></span></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="extended_reviews_settings[selector]"
                          value="<?php echo (isset($extended_reviews['selector']) ? ($extended_reviews['selector']) : ('#tab-review')); ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label" for="sort_order"><?php echo $text_default_sorting; ?></label>
                  <div class="col-sm-3">
                    <select id="sort_order" class="form-control" name="extended_reviews_settings[sort_order]">
                      <?php foreach($sorts as $key => $value) { ?> 
                      <?php if ($value == (($extended_reviews['sort_order']) ? ($extended_reviews['sort_order']) : ('date_added'))) { ?>
                      <option value="<?php echo $value; ?>" selected="selected"><?php echo $key; ?></option>
                      <?php } else { ?>
                      <option value="<?php echo $value; ?>"><?php echo $key; ?></option>
                      <?php } ?>
                      <?php } ?>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $entry_automoderate_help; ?>"><?php echo $entry_automoderate; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[automoderate]" value="1"
                        <?php echo (isset($extended_reviews['automoderate']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="С помощью HTML разметки пользователь может менять размер и цвет текста, вставлять фрагменты html кода, ссылки. Желательно не включать данную настройку без крайней необходимости. Неправильно закрытые HTML теги внутри отзыва могут сломать загрузку страницы.">Сохранять HTML разметку внутри отзыва</span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[html]" value="1"
                        <?php echo (isset($extended_reviews['html']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip" title="<?php echo $text_pagination_help; ?>"><?php echo $text_pagination; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[pagination]" value="1"
                        <?php echo (isset($extended_reviews['pagination']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_more_button_help; ?>"><?php echo $text_more_button; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[show_more]" value="1"
                        <?php echo (isset($extended_reviews['show_more']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_user_mail_help; ?>"><?php echo $text_user_mail; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[email]" value="1"
                        <?php echo (isset($extended_reviews['email']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_micro; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[micro]" value="1"
                        <?php echo (isset($extended_reviews['micro']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_limitations; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[limitations]" value="1"
                        <?php echo (isset($extended_reviews['limitations']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_answer; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[answer]" value="1"
                        <?php echo (isset($extended_reviews['answer']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_mail_alert; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[admin_alert]" value="1"
                        <?php echo (isset($extended_reviews['admin_alert']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_additional_mail_alert_help; ?>"><?php echo $text_additional_mail_alert; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[admin_additional_alert]" value="1"
                        <?php echo (isset($extended_reviews['admin_additional_alert']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_captcha_help; ?>"><?php echo $text_captcha; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[captcha]" value="1"
                        <?php echo (isset($extended_reviews['captcha']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

              </div>

              <div class="tab-pane" id="main-limitations">

                <div class="form-group">
                  <label class="col-sm-6 control-label" for="admin-name"><?php echo $entry_admin_name; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="extended_reviews_settings[admin_name]"
                          value="<?php echo (isset($extended_reviews['admin_name']) ? ($extended_reviews['admin_name']) : ('Manager')); ?>"
                          placeholder="<?php echo $entry_admin_name; ?>" id="admin-name" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_num_reviews; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="extended_reviews_settings[limit]"
                          value="<?php echo (isset($extended_reviews['limit']) ? ($extended_reviews['limit']) : (10)); ?>"
                          placeholder="<?php echo $text_num_reviews; ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label" for="name-min"><?php echo $text_name_limitation; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <div class="row">
                          <div class="col-sm-6">
                            <input type="text" name="extended_reviews_settings[name_min]"
                              value="<?php echo (isset($extended_reviews['name_min']) ? ($extended_reviews['name_min']) : (3)); ?>"
                              id="name-min" class="form-control">
                          </div>
                          <div class="col-sm-6">
                            <input type="text" name="extended_reviews_settings[name_max]"
                              value="<?php echo (isset($extended_reviews['name_max']) ? ($extended_reviews['name_max']) : (64)); ?>"
                              id="name-max" class="form-control">
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label" for="text-min"><?php echo $text_review_limitation; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <div class="row">
                          <div class="col-sm-6">
                            <input type="text" name="extended_reviews_settings[text_min]"
                              value="<?php echo (isset($extended_reviews['text_min']) ? ($extended_reviews['text_min']) : (10)); ?>"
                              id="text-min" class="form-control">
                          </div>
                          <div class="col-sm-6">
                            <input type="text" name="extended_reviews_settings[text_max]"
                              value="<?php echo (isset($extended_reviews['text_max']) ? ($extended_reviews['text_max']) : (3000)); ?>"
                              id="text-max" class="form-control">
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label" for="limitations-min"><?php echo $text_worth_limitation; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="extended_reviews_settings[limitations_max]"
                          value="<?php echo (isset($extended_reviews['limitations_max']) ? ($extended_reviews['limitations_max']) : (1000)); ?>"
                          id="limitations-min" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_register; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[review_access]" value="1"
                        <?php echo (isset($extended_reviews['review_access']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_likes; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[likes_access]" value="1"
                        <?php echo (isset($extended_reviews['likes_access']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_answer_register; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[answer_access]" value="1"
                        <?php echo (isset($extended_reviews['answer_access']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

              </div>

            </div>

          </div>


          <div class="tab-pane" id="style-settings">

            <div class="settings-block">
              <h3>Основные стили модуля</h3>
              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_font_size; ?></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="extended_reviews_settings[main][font-size]"
                    onchange="updateFontSize(this.value)"
                    value="<?php echo (isset($extended_reviews['main']['font-size']) ? ($extended_reviews['main']['font-size']) : (14)); ?>"
                    class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label">Размер шрифта внутри блока имени</label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="extended_reviews_settings[main][font-size-name]"
                    onchange="updateFontSize(this.value)"
                    value="<?php echo (isset($extended_reviews['main']['font-size-name']) ? ($extended_reviews['main']['font-size-name']) : (14)); ?>"
                    class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_font_weight; ?></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="extended_reviews_settings[main][font-weight]"
                    onchange="updateFontWeight(this.value)"
                    value="<?php echo (isset($extended_reviews['main']['font-weight']) ? ($extended_reviews['main']['font-weight']) : (400)); ?>"
                    class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                    title="Отступы внутри вкладки отзывов"><?php echo $text_padding; ?></span></label>
                <div class="col-sm-6 col-lg-4">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="extended_reviews_settings[main][padding-y]"
                        onchange="updatePaddngY(this.value)"
                        value="<?php echo (isset($extended_reviews['main']['padding-y']) ? ($extended_reviews['main']['padding-y']) : (0)); ?>"
                        placeholder="<?php echo $text_vertical; ?>" class="form-control">
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="extended_reviews_settings[main][padding-x]"
                        onchange="updatePaddngX(this.value)"
                        value="<?php echo (isset($extended_reviews['main']['padding-x']) ? ($extended_reviews['main']['padding-x']) : (0)); ?>"
                        placeholder="<?php echo $text_horizontal; ?>" class="form-control">
                    </div>
                  </div>
                </div>
              </div>

          </div>

            <ul class="nav nav-tabs">
              <li class="active"><a href="#key-css" data-toggle="tab" aria-expanded="false"><?php echo $text_button_settings; ?></a></li>
              <li><a href="#form-css" data-toggle="tab" aria-expanded="false"><?php echo $text_form_settings; ?></a></li>
              <li><a href="#review-box-css" data-toggle="tab" aria-expanded="false"><?php echo $text_card_settings; ?></a></li>
              <li><a href="#thumb-css" data-toggle="tab" aria-expanded="false"><?php echo $text_thumb_settings; ?></a></li>
            </ul>



            <div class="tab-content">

              <div class="tab-pane" id="thumb-css">

                <div class="settings-block">
                  <h2 class="text-center"><?php echo $text_thumb_product; ?></h2>
                  <br>
                  <h3><?php echo $text_thumb_photo; ?></h3>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label" for="thumb-width"><?php echo $text_thumb_size; ?></label>
                    <div class="col-sm-6 col-lg-4">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[thumb_width]"
                            value="<?php echo (( isset($extended_reviews['thumb_width'])) ? ($extended_reviews['thumb_width']) : (100)); ?>"
                            placeholder="<?php echo $entry_width; ?>" id="thumb-width" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[thumb_height]"
                            value="<?php echo (( isset($extended_reviews['thumb_height'])) ? ($extended_reviews['thumb_height']) : (100)); ?>"
                            placeholder="<?php echo $entry_height; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                      for="border-radius-photo"><?php echo $text_thumb_radius; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[border_radius_photo]"
                        value="<?php echo (( isset($extended_reviews['border_radius_photo'])) ? ($extended_reviews['border_radius_photo']) : (2)); ?>"
                        id="border-radius-photo" class="form-control">
                    </div>
                  </div>
                  <hr>
                  <br>
                  <h3><?php echo $text_thumb_video; ?></h3>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label" for="video-thumb-width"><?php echo $text_thumb_size; ?></label>
                    <div class="col-sm-6 col-lg-4">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[video_thumb_width]"
                            value="<?php echo (( isset($extended_reviews['video_thumb_width'])) ? ($extended_reviews['video_thumb_width']) : (160)); ?>"
                            placeholder="<?php echo $entry_width; ?>" id="video-thumb-width" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[video_thumb_height]"
                            value="<?php echo (( isset($extended_reviews['video_thumb_height'])) ? ($extended_reviews['video_thumb_height']) : (100)); ?>"
                            placeholder="<?php echo $entry_height; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                      for="border-radius-video"><?php echo $text_thumb_radius; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[border_radius_video]"
                        value="<?php echo (( isset($extended_reviews['border_radius_video'])) ? ($extended_reviews['border_radius_video']) : (2)); ?>"
                        id="border-radius-video" class="form-control">
                    </div>
                  </div>
                  <br>
                </div>

              </div>

              <div class="tab-pane" id="review-box-css">
                <div class="settings-block">
                  <h2><?php echo $text_card_style_title; ?></h2>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_border_radius_help; ?>"><?php echo $text_border_radius; ?></span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[box][border-radius]"
                        value="<?php echo (isset($extended_reviews['box']['border-radius']) ? ($extended_reviews['box']['border-radius']) : (4)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_border_width; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[box][border]"
                        value="<?php echo (isset($extended_reviews['box']['border']) ? ($extended_reviews['box']['border']) : (0)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[box][background]"
                          value="<?php echo (isset($extended_reviews['box']['background']) ? ($extended_reviews['box']['background']) : ('#fbfbfb')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[box][border-color]"
                          value="<?php echo (isset($extended_reviews['box']['border-color']) ? ($extended_reviews['box']['border-color']) : ('#fbfbfb')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[box][color]"
                          value="<?php echo (isset($extended_reviews['box']['color']) ? ($extended_reviews['box']['color']) : ('#505050')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_header_background_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[box_header][background]"
                          value="<?php echo (isset($extended_reviews['box_header']['background']) ? ($extended_reviews['box_header']['background']) : ('#f6f6f6')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_header_text_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[box_header][color]"
                          value="<?php echo (isset($extended_reviews['box_header']['color']) ? ($extended_reviews['box_header']['color']) : ('#505050')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_shadow_remove; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[box][shadow]" value="1"
                          <?php echo (isset($extended_reviews['box']['shadow']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                </div>
              </div>

              <div class="tab-pane" id="form-css">
                <div class="settings-block">
                  <h2><?php echo $text_review_form_title; ?></h2>
                  
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_border_radius_help; ?>"><?php echo $text_border_radius; ?> формы</span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[form][border-radius]"
                        value="<?php echo (isset($extended_reviews['form']['border-radius']) ? ($extended_reviews['form']['border-radius']) : (4)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_border_radius_help; ?>"><?php echo $text_border_radius; ?> полей ввода</span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[form][input-border-radius]"
                        value="<?php echo (isset($extended_reviews['form']['input-border-radius']) ? ($extended_reviews['form']['input-border-radius']) : (4)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_border_width; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[form][border]"
                        value="<?php echo (isset($extended_reviews['form']['border']) ? ($extended_reviews['form']['border']) : (0)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[form][background]"
                          value="<?php echo (isset($extended_reviews['form']['background']) ? ($extended_reviews['form']['background']) : ('#f5f5f5')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[form][border-color]"
                          value="<?php echo (isset($extended_reviews['form']['border-color']) ? ($extended_reviews['form']['border-color']) : ('#fbfbfb')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input class="form-control jscolor {required:false}"
                          name="extended_reviews_settings[form][color]"
                          value="<?php echo (isset($extended_reviews['form']['color']) ? ($extended_reviews['form']['color']) : ('#505050')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_shadow_remove; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[form][shadow]" value="1"
                          <?php echo (isset($extended_reviews['form']['shadow']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                </div>
              </div>

              <div class="tab-pane active" id="key-css">
                <div class="settings-block">
                  <h2><?php echo $text_button_common_settings; ?></h2>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_border_radius_help; ?>"><?php echo $text_border_radius; ?></span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][border-radius]"
                        onchange="updateBorderRadius(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['border-radius']) ? ($extended_reviews['button']['border-radius']) : (2)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_border_width; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][border]"
                        onchange="updateBorder(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['border']) ? ($extended_reviews['button']['border']) : (1)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_font_size; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][font-size]"
                        onchange="updateFontSize(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['font-size']) ? ($extended_reviews['button']['font-size']) : (14)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_min_button_width_help; ?>"><?php echo $text_min_button_width; ?></span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][min-width]"
                        onchange="updateMinWidth(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['min-width']) ? ($extended_reviews['button']['min-width']) : (40)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_transition_help; ?>">Transition (0 - 9)</span></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][transition]"
                        onchange="updateFontSize(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['transition']) ? ($extended_reviews['button']['transition']) : (1)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_font_weight; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[button][font-weight]"
                        onchange="updateFontWeight(this.value)"
                        value="<?php echo (isset($extended_reviews['button']['font-weight']) ? ($extended_reviews['button']['font-weight']) : (400)); ?>"
                        class="form-control">
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-lg-4 col-sm-6 col-xs-8 control-label"><?php echo $text_font_uppercase; ?></label>
                    <div class="col-lg-1 col-sm-2 col-xs-4">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[button][uppercase]"
                          onchange="updateTextTransform(this)" value="1"
                          <?php echo (isset($extended_reviews['button']['uppercase']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                        title="<?php echo $text_padding_help; ?>"><?php echo $text_padding; ?></span></label>
                    <div class="col-sm-6 col-lg-4">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[button][padding-y]"
                            onchange="updatePaddngY(this.value)"
                            value="<?php echo (isset($extended_reviews['button']['padding-y']) ? ($extended_reviews['button']['padding-y']) : (7)); ?>"
                            placeholder="<?php echo $text_vertical; ?>" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[button][padding-x]"
                            onchange="updatePaddngX(this.value)"
                            value="<?php echo (isset($extended_reviews['button']['padding-x']) ? ($extended_reviews['button']['padding-x']) : (10)); ?>"
                            placeholder="<?php echo $text_horizontal; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>

                </div>
                <?php $types = ['to right' => $text_right, 'to bottom' => $text_bottom, '45deg' => $text_right_top, '135deg' => $text_right_bottom]; ?>

                <div class="settings-block">
                  <h3><?php echo $text_button_comfirm; ?></h3>
                  <button type="button" class="ex-btn ex-accept"><?php echo $text_demonstration; ?></button>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[accept][gradient]"
                          onchange="gradientChange(this.value, 'accept')" id="accept-gradient" class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['accept']['gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'accept\', 1)'}"
                          id="accept-background-1" name="extended_reviews_settings[accept][background]"
                          value="<?php echo (isset($extended_reviews['accept']['background']) ? ($extended_reviews['accept']['background']) : ('#337ab7')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 accept-background <?php echo (isset($extended_reviews['accept']['gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'accept\', 0)'}"
                          id="accept-background-2" name="extended_reviews_settings[accept][background2]"
                          value="<?php echo (isset($extended_reviews['accept']['background2']) ? ($extended_reviews['accept']['background2']) : ('#337ab7')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'accept\')'}"
                          id="accept-color" name="extended_reviews_settings[accept][text]"
                          value="<?php echo (isset($extended_reviews['accept']['text']) ? ($extended_reviews['accept']['text']) : ('#fff')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'accept\')'}"
                          id="accept-border" name="extended_reviews_settings[accept][border_color]"
                          value="<?php echo (isset($extended_reviews['accept']['border_color']) ? ($extended_reviews['accept']['border_color']) : ('#337ab7')); ?>">
                      </div>
                    </div>
                  </div>

                  <h4><?php echo $text_on_hover; ?></h4>
                  <button type="button" class="ex-btn ex-accept-hover"><?php echo $text_demonstration; ?></button>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[accept][hover_gradient]"
                          onchange="gradientChange(this.value, 'accept-hover')" id="accept-hover-gradient"
                          class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['accept']['hover_gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'accept-hover\', 1)'}"
                          name="extended_reviews_settings[accept][background_h]" id="accept-hover-background-1"
                          value="<?php echo (isset($extended_reviews['accept']['background_h']) ? ($extended_reviews['accept']['background_h']) : ('#286090')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 accept-hover-background <?php echo (isset($extended_reviews['accept']['hover_gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'accept-hover\', 0)'}"
                          id="accept-hover-background-2" name="extended_reviews_settings[accept][background2_h]"
                          value="<?php echo (isset($extended_reviews['accept']['background2_h']) ? ($extended_reviews['accept']['background2_h']) : ('#286090')); ?>">
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'accept-hover\')'}"
                          name="extended_reviews_settings[accept][text_h]" id="accept-hover-color"
                          value="<?php echo (isset($extended_reviews['accept']['text_h']) ? ($extended_reviews['accept']['text_h']) : ('#fff')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'accept-hover\')'}"
                          name="extended_reviews_settings[accept][border_color_h]" id="accept-hover-border"
                          value="<?php echo (isset($extended_reviews['accept']['border_color_h']) ? ($extended_reviews['accept']['border_color_h']) : ('#286090')); ?>">
                      </div>
                    </div>
                  </div>
                </div>



                <div class="settings-block">
                  <h3><?php echo $text_button_cancel; ?></h3>
                  <button type="button" class="ex-btn ex-cancel"><?php echo $text_demonstration; ?></button>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[cancel][gradient]"
                          onchange="gradientChange(this.value, 'cancel')" id="cancel-gradient" class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['cancel']['gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'cancel\', 1)'}"
                          id="cancel-background-1" name="extended_reviews_settings[cancel][background]"
                          value="<?php echo (isset($extended_reviews['cancel']['background']) ? ($extended_reviews['cancel']['background']) : ('#d9534f')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 cancel-background <?php echo (isset($extended_reviews['cancel']['gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'cancel\', 0)'}"
                          id="cancel-background-2" name="extended_reviews_settings[cancel][background2]"
                          value="<?php echo (isset($extended_reviews['cancel']['background2']) ? ($extended_reviews['cancel']['background2']) : ('#d9534f')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'cancel\')'}"
                          id="cancel-color" name="extended_reviews_settings[cancel][text]"
                          value="<?php echo (isset($extended_reviews['cancel']['text']) ? ($extended_reviews['cancel']['text']) : ('#fff')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'cancel\')'}"
                          id="cancel-border" name="extended_reviews_settings[cancel][border_color]"
                          value="<?php echo (isset($extended_reviews['cancel']['border_color']) ? ($extended_reviews['cancel']['border_color']) : ('#d9534f')); ?>">
                      </div>
                    </div>
                  </div>

                  <h4><?php echo $text_on_hover; ?></h4>
                  <button type="button" class="ex-btn ex-cancel-hover"><?php echo $text_demonstration; ?></button>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[cancel][hover_gradient]"
                          onchange="gradientChange(this.value, 'cancel-hover')" id="cancel-hover-gradient"
                          class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['cancel']['hover_gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'cancel-hover\', 1)'}"
                          name="extended_reviews_settings[cancel][background_h]" id="cancel-hover-background-1"
                          value="<?php echo (isset($extended_reviews['cancel']['background_h']) ? ($extended_reviews['cancel']['background_h']) : ('#c9302c')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 cancel-hover-background <?php echo (isset($extended_reviews['cancel']['hover_gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'cancel-hover\', 0)'}"
                          id="cancel-hover-background-2" name="extended_reviews_settings[cancel][background2_h]"
                          value="<?php echo (isset($extended_reviews['cancel']['background2_h']) ? ($extended_reviews['cancel']['background2_h']) : ('#c9302c')); ?>">
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'cancel-hover\')'}"
                          name="extended_reviews_settings[cancel][text_h]" id="cancel-hover-color"
                          value="<?php echo (isset($extended_reviews['cancel']['text_h']) ? ($extended_reviews['cancel']['text_h']) : ('#fff')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'cancel-hover\')'}"
                          name="extended_reviews_settings[cancel][border_color_h]" id="cancel-hover-border"
                          value="<?php echo (isset($extended_reviews['cancel']['border_color_h']) ? ($extended_reviews['cancel']['border_color_h']) : ('#c9302c')); ?>">
                      </div>
                    </div>
                  </div>
                </div>


                <div class="settings-block">
                  <h3><?php echo $text_button_lite; ?></h3>
                  <button type="button" class="ex-btn ex-light"><?php echo $text_demonstration; ?></button>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[light][gradient]"
                          onchange="gradientChange(this.value, 'light')" id="light-gradient" class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['light']['gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'light\', 1)'}"
                          id="light-background-1" name="extended_reviews_settings[light][background]"
                          value="<?php echo (isset($extended_reviews['light']['background']) ? ($extended_reviews['light']['background']) : ('#F2F2F2')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 light-background <?php echo (isset($extended_reviews['light']['gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'light\', 0)'}"
                          id="light-background-2" name="extended_reviews_settings[light][background2]"
                          value="<?php echo (isset($extended_reviews['light']['background2']) ? ($extended_reviews['light']['background2']) : ('#F2F2F2')); ?>">
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'light\')'}"
                          id="light-color" name="extended_reviews_settings[light][text]"
                          value="<?php echo (isset($extended_reviews['light']['text']) ? ($extended_reviews['light']['text']) : ('#3F7DBA')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'light\')'}"
                          id="light-border" name="extended_reviews_settings[light][border_color]"
                          value="<?php echo (isset($extended_reviews['light']['border_color']) ? ($extended_reviews['light']['border_color']) : ('#F2F2F2')); ?>">
                      </div>
                    </div>
                  </div>

                  <h4><?php echo $text_on_hover; ?></h4>
                  <button type="button" class="ex-btn ex-light-hover"><?php echo $text_demonstration; ?></button>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <label class="input-group-addon" for="input-gradient"><?php echo $text_gradient; ?></label>
                        <select name="extended_reviews_settings[light][hover_gradient]"
                          onchange="gradientChange(this.value, 'light-hover')" id="light-hover-gradient"
                          class="form-control">
                          <option value="0"><?php echo $text_off; ?></option>
                          <?php foreach($types as $key => $name) { ?> 
                          <option value="<?php echo $key; ?>"
                            <?php echo (($extended_reviews['light']['hover_gradient'] == $key) ? ('selected="selected"') : ('')); ?>><?php echo $name; ?>
                          </option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'light-hover\', 1)'}"
                          name="extended_reviews_settings[light][background_h]" id="light-hover-background-1"
                          value="<?php echo (isset($extended_reviews['light']['background_h']) ? ($extended_reviews['light']['background_h']) : ('#E3E3E3')); ?>">
                      </div>
                    </div>
                    <div
                      class="col-lg-3 col-sm-6 col-xs-12 light-hover-background <?php echo (isset($extended_reviews['light']['hover_gradient']) ? ('') : ('hidden')); ?>">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_background_color; ?> 2</span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBackground(this, \'light-hover\', 0)'}"
                          id="light-hover-background-2" name="extended_reviews_settings[light][background2_h]"
                          value="<?php echo (isset($extended_reviews['light']['background2_h']) ? ($extended_reviews['light']['background2_h']) : ('#E3E3E3')); ?>">
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateTextColor(this, \'light-hover\')'}"
                          name="extended_reviews_settings[light][text_h]" id="light-hover-color"
                          value="<?php echo (isset($extended_reviews['light']['text_h']) ? ($extended_reviews['light']['text_h']) : ('#FF7878')); ?>">
                      </div>
                    </div>
                    <div class="col-lg-3 col-sm-6 col-xs-12">
                      <div class="input-group">
                        <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                        <input
                          class="form-control jscolor {required:false, onFineChange:'updateBorderColor(this, \'light-hover\')'}"
                          name="extended_reviews_settings[light][border_color_h]" id="light-hover-border"
                          value="<?php echo (isset($extended_reviews['light']['border_color_h']) ? ($extended_reviews['light']['border_color_h']) : ('#E3E3E3')); ?>">
                      </div>
                    </div>
                  </div>
                </div>

              </div>

            </div>

          </div>

          <div class="tab-pane" id="all-reviews-page">

            <ul class="nav nav-tabs">
              <li class="active"><a href="#all-main-settings" data-toggle="tab"
                  aria-expanded="false"><?php echo $text_main_settings; ?></a></li>
              <li><a href="#all-seo" data-toggle="tab" aria-expanded="false"><?php echo $text_page_seo; ?></a></li>
              <li><a href="#all-thumb-css" data-toggle="tab" aria-expanded="false"><?php echo $text_thumb_settings; ?></a></li>
            </ul>

            <div class="tab-content">

              <div class="tab-pane active" id="all-main-settings">

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_page_enabled_help; ?>"><?php echo $entry_status; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[all_status]" value="1"
                        <?php echo (isset($extended_reviews['all_status']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_page_index_help; ?>"><?php echo $text_page_index; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[all_noindex]" value="1"
                      <?php echo (isset($extended_reviews['all_noindex']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_link_allreviews; ?></label>
                  <div class="col-sm-6">
                    <div class="row" style="padding: 10px">
                      <a href="<?php echo $reviews_link; ?>" target="_blank"><?php echo $reviews_link; ?></a>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_num_reviews; ?></label>
                  <div class="col-sm-6">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="extended_reviews_settings[all_limit]"
                          value="<?php echo (isset($extended_reviews['all_limit']) ? ($extended_reviews['all_limit']) : (10)); ?>"
                          placeholder="<?php echo $text_num_reviews; ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_more_button_help; ?>"><?php echo $text_more_button; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[all_show_more]" value="1"
                        <?php echo (isset($extended_reviews['all_show_more']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-6 control-label"><span data-toggle="tooltip"
                      title="<?php echo $text_page_pagination_help; ?>"><?php echo $text_page_pagination; ?></span></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="extended_reviews_settings[all_pagination]" value="1"
                        <?php echo (isset($extended_reviews['all_pagination']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>

              </div>

              <div class="tab-pane" id="all-seo">
                <div class="settings-block">
                  <div class="form-group">
                    <label class="col-sm-3 control-label"><?php echo $entry_url; ?></label>
                    <div class="col-sm-9">
                      <div class="input-group">
                        <input type="text"
                          name="extended_reviews_settings[seo_url]"
                          value="<?php echo (isset($extended_reviews['seo_url']) ? ($extended_reviews['seo_url']) : ('')); ?>"
                          placeholder="<?php echo $entry_url; ?>" class="form-control" />
                      </div>
                    </div>
                  </div>

                  <ul class="nav nav-tabs" id="language">
                    <?php foreach($languages as $_key => $language) { ?> 
                    <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img
                          src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png" title="<?php echo $language['name']; ?>" />
                        <?php echo $language['name']; ?></a></li>
                    <?php } ?>
                  </ul>

                  <div class="tab-content">
                    <?php foreach($languages as $_key => $language) { ?> 
                    <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">

                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_h1; ?></label>
                        <div class="col-sm-9">
                          <div class="input-group"><span class="input-group-addon"><img
                                src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"
                                title="<?php echo $language['name']; ?>" /></span>
                            <input type="text"
                              name="extended_reviews_settings[module_h1][<?php echo $language['language_id']; ?>]"
                              value="<?php echo (isset($extended_reviews['module_h1'][$language['language_id']]) ? ($extended_reviews['module_h1'][$language['language_id']]) : ('')); ?>"
                              placeholder="<?php echo $entry_h1; ?>" class="form-control" />
                          </div>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_title; ?></label>
                        <div class="col-sm-9">
                          <div class="input-group"><span class="input-group-addon"><img
                                src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"
                                title="<?php echo $language['name']; ?>" /></span>
                            <input type="text"
                              name="extended_reviews_settings[module_title][<?php echo $language['language_id']; ?>]"
                              value="<?php echo (isset($extended_reviews['module_title'][$language['language_id']]) ? ($extended_reviews['module_title'][$language['language_id']]) : ('')); ?>"
                              placeholder="<?php echo $entry_title; ?>" class="form-control" />
                          </div>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_description; ?></label>
                        <div class="col-sm-9">
                          <div class="input-group"><span class="input-group-addon"><img
                                src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"
                                title="<?php echo $language['name']; ?>" /></span>
                            <textarea rows="3"
                              name="extended_reviews_settings[module_description][<?php echo $language['language_id']; ?>]"
                              placeholder="<?php echo $entry_description; ?>"
                              class="form-control"><?php echo (isset($extended_reviews['module_description'][$language['language_id']]) ? ($extended_reviews['module_description'][$language['language_id']]) : ('')); ?></textarea>
                          </div>
                        </div>
                      </div>

                      <div class="form-group">
                        <label class="col-sm-3 control-label"><?php echo $entry_keywords; ?></label>
                        <div class="col-sm-9">
                          <div class="input-group"><span class="input-group-addon"><img
                                src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"
                                title="<?php echo $language['name']; ?>" /></span>
                            <textarea rows="3"
                              name="extended_reviews_settings[module_keywords][<?php echo $language['language_id']; ?>]"
                              placeholder="<?php echo $entry_keywords; ?>"
                              class="form-control"><?php echo (isset($extended_reviews['module_keywords'][$language['language_id']]) ? ($extended_reviews['module_keywords'][$language['language_id']]) : ('')); ?></textarea>
                          </div>
                        </div>
                      </div>

                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>

              <div class="tab-pane" id="all-thumb-css">
                <div class="settings-block">
                  <h2 class="text-center"><?php echo $text_thumb_reviews; ?></h2>
                  <br>
                  <h3><?php echo $text_thumb_product; ?></h3>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_thumb_size; ?></label>
                    <div class="col-sm-6 col-lg-4 ">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[product_thumb_width]"
                            value="<?php echo (( isset($extended_reviews['product_thumb_width'])) ? ($extended_reviews['product_thumb_width']) : (270)); ?>"
                            placeholder="<?php echo $entry_width; ?>" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[product_thumb_height]"
                            value="<?php echo (( isset($extended_reviews['product_thumb_height'])) ? ($extended_reviews['product_thumb_height']) : (270)); ?>"
                            placeholder="<?php echo $entry_height; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_thumb_radius; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[all_border_radius_photo]"
                        value="<?php echo (( isset($extended_reviews['all_border_radius_photo'])) ? ($extended_reviews['all_border_radius_photo']) : (2)); ?>" class="form-control">
                    </div>
                  </div>
                  <hr>
                  <br>
                  <h3><?php echo $text_thumb_photo; ?></h3>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_thumb_size; ?></label>
                    <div class="col-sm-6 col-lg-4 ">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[all_thumb_width]"
                            value="<?php echo (( isset($extended_reviews['all_thumb_width'])) ? ($extended_reviews['all_thumb_width']) : (110)); ?>"
                            placeholder="<?php echo $entry_width; ?>" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[all_thumb_height]"
                            value="<?php echo (( isset($extended_reviews['all_thumb_height'])) ? ($extended_reviews['all_thumb_height']) : (110)); ?>"
                            placeholder="<?php echo $entry_height; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_thumb_radius; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[all_border_radius_photo]"
                        value="<?php echo (( isset($extended_reviews['all_border_radius_photo'])) ? ($extended_reviews['all_border_radius_photo']) : (2)); ?>" class="form-control">
                    </div>
                  </div>
                  <hr>
                  <br>
                  <h3><?php echo $text_thumb_video; ?></h3>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 control-label"
                      for="all-video-thumb-width"><?php echo $text_thumb_size; ?></label>
                    <div class="col-sm-6 col-lg-4">
                      <div class="row">
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[all_video_thumb_width]"
                            value="<?php echo (( isset($extended_reviews['all_video_thumb_width'])) ? ($extended_reviews['all_video_thumb_width']) : (160)); ?>"
                            placeholder="<?php echo $entry_width; ?>" id="all-video-thumb-width" class="form-control">
                        </div>
                        <div class="col-sm-6">
                          <input type="text" name="extended_reviews_settings[all_video_thumb_height]"
                            value="<?php echo (( isset($extended_reviews['all_video_thumb_height'])) ? ($extended_reviews['all_video_thumb_height']) : (100)); ?>"
                            placeholder="<?php echo $entry_height; ?>" class="form-control">
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                      for="all_border-radius-video"><?php echo $text_thumb_radius; ?></label>
                    <div class="col-sm-2 col-lg-1 col-xs-4">
                      <input type="text" name="extended_reviews_settings[all_border_radius_video]"
                        value="<?php echo (( isset($extended_reviews['all_border_radius_video'])) ? ($extended_reviews['all_border_radius_video']) : (2)); ?>"
                        id="all-border-radius-video" class="form-control">
                    </div>
                  </div>
                </div>
              </div>

            </div>
          </div>


          <div class="tab-pane" id="media-settings">

            <div class="form-group">
              <label class="col-sm-6 control-label"><?php echo $text_add_photo; ?></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[photo_status]" value="1"
                    <?php echo (isset($extended_reviews['photo_status']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"> <span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_youtube_help; ?>"><?php echo $text_add_video; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[video_status]" value="1"
                    <?php echo (isset($extended_reviews['video_status']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"> <span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_thumb_all_block; ?>"><?php echo $text_all_media; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[all_media]" value="1"
                    <?php echo (isset($extended_reviews['all_media']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <?php $watermark_locations = ['' => $text_disabled, 'bottomright' => $text_bottomright, 'topright' => $text_topright, 'middleright' => $text_middleright, 'bottomleft' => $text_bottomleft, 'topleft' => $text_topleft, 'middleleft' => $text_middleleft, 'bottomcenter' => $text_bottomcenter, 'topcenter' => $text_topcenter, 'middlecenter' => $text_middlecenter]; ?>

            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_watermark_add; ?>"><?php echo $text_watermark_location; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <select name="extended_reviews_settings[watermark_location]" class="form-control">
                      <?php foreach($watermark_locations as $key => $name) { ?> 
                      <option value="<?php echo $key; ?>" <?php echo (($extended_reviews['watermark_location'] == $key) ? ('selected') : ('')); ?>><?php echo $name; ?>
                      </option>
                      <?php } ?>
                    </select>
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"><?php echo $text_watermark_size; ?></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[watermark_size]"
                      value="<?php echo (isset($extended_reviews['watermark_size']) ? ($extended_reviews['watermark_size']) : (10)); ?>" class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"><?php echo $text_watermark; ?></label>
              <div class="col-sm-6"><a href="" id="watermark-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $watermark_thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                <input type="hidden" name="extended_reviews_settings[watermark]" value="<?php echo (isset($extended_reviews['watermark']) ? $extended_reviews['watermark'] : ''); ?>" id="input-watermark" />
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="image-width"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_size_control; ?>"><?php echo $text_popup_size; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_width]"
                      value="<?php echo (isset($extended_reviews['image_width']) ? ($extended_reviews['image_width']) : (0)); ?>"
                      placeholder="<?php echo $entry_width; ?>" id="image-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_height]"
                      value="<?php echo (isset($extended_reviews['image_height']) ? ($extended_reviews['image_height']) : (0)); ?>"
                      placeholder="<?php echo $entry_height; ?>" id="image-height" class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="image-max-width"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_max_size; ?>"><?php echo $text_size_limit; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_width]"
                      value="<?php echo (isset($extended_reviews['image_max_width']) ? ($extended_reviews['image_max_width']) : (5000)); ?>"
                      placeholder="<?php echo $entry_width; ?>" id="image-max-width" class="form-control">
                  </div>
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_height]"
                      value="<?php echo (isset($extended_reviews['image_max_height']) ? ($extended_reviews['image_max_height']) : (5000)); ?>"
                      placeholder="<?php echo $entry_height; ?>" class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="image-max-width">
                <span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_max_weight; ?>"><?php echo $text_weight_limit; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_size]"
                      value="<?php echo (isset($extended_reviews['image_max_size']) ? ($extended_reviews['image_max_size']) : (5)); ?>"
                      placeholder="<?php echo $text_weight_limit; ?>" id="image-max-size" class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="image-max-count"><?php echo $text_count_limit; ?></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[image_max_count]"
                      value="<?php echo (isset($extended_reviews['image_max_count']) ? ($extended_reviews['image_max_count']) : (10)); ?>"
                      placeholder="<?php echo $text_count_limit; ?>" id="image-max-count" class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_imgbb_help; ?>"><?php echo $text_imgbb_on; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[photo_hosting]"
                    onchange="changeImageSizes(this);" value="1"
                    <?php echo (isset($extended_reviews['photo_hosting']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="image-max-count">
                <span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_key_help; ?>"><?php echo $text_imgbb_key; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[api_key]"
                      value="<?php echo (isset($extended_reviews['api_key']) ? ($extended_reviews['api_key']) : ('')); ?>"
                      placeholder="<?php echo $text_imgbb_key_help; ?>" id="api_key"
                      class="form-control">
                  </div>
                </div>
              </div>
              <div class="col-sm-12" style="text-align: center">
                <?php echo $text_imgbb_key_link; ?>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label">
                <span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_youtube_key_help; ?>"><?php echo $text_youtube_key; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[api_key_youtube]"
                      value="<?php echo (isset($extended_reviews['api_key_youtube']) ? ($extended_reviews['api_key_youtube']) : ('AIzaSyBV0eSZxQOn3OEf0oRCIXeAF04y2T8-A60')); ?>"
                      class="form-control">
                  </div>
                </div>
              </div>
              <div class="col-sm-12" style="text-align: center">
                <?php echo $text_youtube_key_link; ?>
              </div>
            </div>

          </div>

          <div class="tab-pane" id="reward-settings">

            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_bonus_help; ?>"><?php echo $rewards_status; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[reward]" value="1"
                    <?php echo (isset($extended_reviews['reward']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="bonus-count"><?php echo $text_bonus; ?></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus]"
                      value="<?php echo (isset($extended_reviews['bonus']) ? ($extended_reviews['bonus']) : (0)); ?>"
                      placeholder="<?php echo $text_bonus_help; ?>" id="bonus-count"
                      class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="bonus-photo"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_bonus_photo_help; ?>"><?php echo $text_bonus_photo; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_photo]"
                      value="<?php echo (isset($extended_reviews['bonus_photo']) ? ($extended_reviews['bonus_photo']) : (0)); ?>"
                      placeholder="<?php echo $text_bonus_photo_help; ?>" id="bonus-photo"
                      class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="bonus-video"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_bonus_video_help; ?>"><?php echo $text_bonus_video; ?></span></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_video]"
                      value="<?php echo (isset($extended_reviews['bonus_video']) ? ($extended_reviews['bonus_video']) : (0)); ?>"
                      placeholder="<?php echo $text_bonus_video_help; ?>" id="bonus-video"
                      class="form-control">
                  </div>
                </div>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_likes_help; ?>"><?php echo $text_bonus_likes_status; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[likes_reward]" value="1"
                    <?php echo (isset($extended_reviews['likes_reward']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label class="col-sm-6 control-label" for="bonus-likes"><?php echo $text_bonus_likes; ?></label>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-6">
                    <input type="text" name="extended_reviews_settings[bonus_likes]"
                      value="<?php echo (isset($extended_reviews['bonus_likes']) ? ($extended_reviews['bonus_likes']) : (0)); ?>"
                      placeholder="<?php echo $text_bonus_likes_help; ?>" id="bonus-likes"
                      class="form-control">
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="tab-pane" id="compatibility-settings">

          <div class="settings-block">
          <h3><?php echo $text_gallery_title; ?></h3>
            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_magnific_help; ?>"><?php echo $text_magnific; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[magn]" value="1"
                    <?php echo (isset($extended_reviews['magn']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>


            <div class="form-group">
              <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                  data-original-title="<?php echo $text_fancybox_help; ?>"><?php echo $text_fancybox; ?></span></label>
              <div class="col-sm-6">
                <label class="fresh-check">
                  <input type="checkbox" name="extended_reviews_settings[fancy]" value="1"
                    <?php echo (isset($extended_reviews['fancy']) ? ('checked="checked"') : ('')); ?> /><span></span>
                </label>
              </div>
            </div>
          </div>

          </div>


          <div class="tab-pane" id="api-settings">
            <div class="settings-block">
              <div class="clarification-for-users"><?php echo $api_notifications; ?></div>

              <ul class="nav nav-tabs">
                <li class="active"><a href="#product-api" data-toggle="tab" aria-expanded="true"><?php echo $text_product_page; ?></a>
                </li>
                <li><a href="#reviews-page-api" data-toggle="tab" aria-expanded="true"><?php echo $text_reviews_page; ?></a>
                </li>
              </ul>

              <div class="tab-content">
                <div class="tab-pane active" id="product-api">
                  <div class="form-group">
                    <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                        data-original-title="<?php echo $text_module_style_help; ?>">Ex_reviews.css</span></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[ex_css]" value="1"
                          <?php echo (isset($extended_reviews['ex_css']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                        data-original-title="<?php echo $text_module_script_help; ?>">Ex_reviews.js</span></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[ex_js]" value="1"
                          <?php echo (isset($extended_reviews['ex_js']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                        data-original-title="<?php echo $text_dropzone_help; ?>">Dropzone</span></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[dropzone]" value="1"
                          <?php echo (isset($extended_reviews['dropzone']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label">MagnificPopup</label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[magnific]" value="1"
                          <?php echo (isset($extended_reviews['magnific']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label">Fancybox</label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[fancybox]" value="1"
                          <?php echo (isset($extended_reviews['fancybox']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><?php echo $text_bootstrap_css; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[bootstrap_css]" value="1"
                          <?php echo (isset($extended_reviews['bootstrap_css']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><?php echo $text_bootstrap_js; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[bootstrap_js]" value="1"
                          <?php echo (isset($extended_reviews['bootstrap_js']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>
                </div>
                <div class="tab-pane" id="reviews-page-api">

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                        data-original-title="<?php echo $text_module_style_help; ?>">Ex_reviews.css</span></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[ex_css_page]" value="1"
                          <?php echo (isset($extended_reviews['ex_css_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><span data-toggle="tooltip" title=""
                        data-original-title="<?php echo $text_module_script_help; ?>">Ex_reviews.js</span></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[ex_js_page]" value="1"
                          <?php echo (isset($extended_reviews['ex_js_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label">MagnificPopup</label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[magnific_page]" value="1"
                          <?php echo (isset($extended_reviews['magnific_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label">Fancybox</label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[fancybox_page]" value="1"
                          <?php echo (isset($extended_reviews['fancybox_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><?php echo $text_bootstrap_css; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[bootstrap_css_page]" value="1"
                          <?php echo (isset($extended_reviews['bootstrap_css_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                  <div class="form-group">
                    <label class="col-sm-6 control-label"><?php echo $text_bootstrap_js; ?></label>
                    <div class="col-sm-6">
                      <label class="fresh-check">
                        <input type="checkbox" name="extended_reviews_settings[bootstrap_js_page]" value="1"
                          <?php echo (isset($extended_reviews['bootstrap_js_page']) ? ('checked="checked"') : ('')); ?> /><span></span>
                      </label>
                    </div>
                  </div>

                </div>
              </div>

            </div>
          </div>
          
          <div class="tab-pane" id="tab-support">
            <div class="form-group">
              <div class="col-sm-12">
                <?php echo $text_thanks; ?>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-3"><?php echo $text_contacts; ?></div>
              <div class="col-sm-9">
                <?php echo $text_email; ?> <a href="mailto:Felin0603@gmail.com">Felin0603@gmail.com</a><br>
                <?php echo $text_site; ?> <a href="http://extended-reviews.com/"
                  target="_blank">http://extended-reviews.com/</a><br>
                Opencartforum: <a href="https://opencartforum.com/profile/827231-censorid/"
                  target="_blank">https://opencartforum.com/profile/827231-censorid/</a>
              </div>
            </div>
            <div class="form-group">
              <div class="col-sm-3"><?php echo $text_module_reviews; ?></div>
              <div class="col-sm-9">
                Opencartforum: <a
                  href="https://opencartforum.com/topic/138602-podderzhka-otzyvy-s-foto-i-video-opencart/"
                  target="_blank">opencartforum.com</a><br>
              </div>
            </div>
          </div>

        </div>
      </form>
    </div>
  </div>
</div>

<?php echo $footer; ?>
<script>
$('#language a:first').tab('show');

  function changeImageSizes(checkbox) {
    if (checkbox.checked == true) {
      $('#image-width').val('1000');
    }
  }
</script>
<style type="text/css">
  .ex-btn {
    border-radius: <?php echo (isset($extended_reviews['button']['border-radius']) ? ($extended_reviews['button']['border-radius']) : (2)); ?>px;
    padding: <?php echo (isset($extended_reviews['button']['padding-y']) ? ($extended_reviews['button']['padding-y']) : (4)); ?>px <?php echo (isset($extended_reviews['button']['padding-x']) ? ($extended_reviews['button']['padding-x']) : (10)); ?>px;
    font-size: <?php echo (isset($extended_reviews['button']['font-size']) ? ($extended_reviews['button']['font-size']) : (12)); ?>px;
    text-transform: <?php echo (isset($extended_reviews['button']['uppercase']) ? ('uppercase') : ('none')); ?>;
    border: <?php echo (isset($extended_reviews['button']['border']) ? ($extended_reviews['button']['border']) : (1)); ?>px solid;
    font-weight: <?php echo (isset($extended_reviews['button']['font-weight']) ? ($extended_reviews['button']['font-weight']) : (300)); ?>;
    transition: all . <?php echo (isset($extended_reviews['button']['transition']) ? ($extended_reviews['button']['transition']) : (2)); ?> s ease-in-out;
    min-width: <?php echo (isset($extended_reviews['button']['min-width']) ? ($extended_reviews['button']['min-width']) : (40)); ?>px;
  }
  .ex-accept {
  <?php if ($extended_reviews['accept']['gradient']) { ?>
    background: linear-gradient(<?php echo $extended_reviews['accept']['gradient']; ?>, 
    #<?php echo (isset($extended_reviews['accept']['background']) ? ($extended_reviews['accept']['background']) : ('337AB7')); ?>, 
    #<?php echo (isset($extended_reviews['accept']['background2']) ? ($extended_reviews['accept']['background2']) : ('337AB7')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['accept']['background']) ? ($extended_reviews['accept']['background']) : ('337AB7')); ?>;
  <?php } ?>
    border-color: #<?php echo (isset($extended_reviews['accept']['border_color']) ? ($extended_reviews['accept']['border_color']) : ('337AB7')); ?>;
    color: #<?php echo (isset($extended_reviews['accept']['text']) ? ($extended_reviews['accept']['text']) : ('fff')); ?>;
  }
  .ex-accept-hover,
  .ex-accept:hover {
  <?php if ($extended_reviews['accept']['hover_gradient']) { ?>
    background: linear-gradient(<?php echo $extended_reviews['accept']['hover_gradient']; ?>, 
    #<?php echo (isset($extended_reviews['accept']['background_h']) ? ($extended_reviews['accept']['background_h']) : ('286090')); ?>, 
    #<?php echo (isset($extended_reviews['accept']['background2_h']) ? ($extended_reviews['accept']['background2_h']) : ('286090')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['accept']['background_h']) ? ($extended_reviews['accept']['background_h']) : ('286090')); ?>;
  <?php } ?>
    color: #<?php echo (isset($extended_reviews['accept']['text_h']) ? ($extended_reviews['accept']['text_h']) : ('fff')); ?>;
    border-color: #<?php echo (isset($extended_reviews['accept']['border_color_h']) ? ($extended_reviews['accept']['border_color_h']) : ('286090')); ?>;
  }
  .ex-cancel {
  <?php if ($extended_reviews['cancel']['gradient']) { ?>
    background: linear-gradient(<?php echo $extended_reviews['cancel']['gradient']; ?>, 
    #<?php echo (isset($extended_reviews['cancel']['background']) ? ($extended_reviews['cancel']['background']) : ('fc6e5f')); ?>, 
    #<?php echo (isset($extended_reviews['cancel']['background2']) ? ($extended_reviews['cancel']['background2']) : ('fc6e5f')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['cancel']['background']) ? ($extended_reviews['cancel']['background']) : ('fc6e5f')); ?>;
  <?php } ?>
    color: #<?php echo (isset($extended_reviews['cancel']['text']) ? ($extended_reviews['cancel']['text']) : ('fff')); ?>;
    border-color: #<?php echo (isset($extended_reviews['cancel']['border_color']) ? ($extended_reviews['cancel']['border_color']) : ('fc6e5f')); ?>;
  }
  .ex-cancel-hover,
  .ex-cancel:hover {
  <?php if ($extended_reviews['cancel']['hover_gradient']) { ?>
    background: linear-gradient( <?php echo $extended_reviews['cancel']['hover_gradient']; ?>, 
    #<?php echo (isset($extended_reviews['cancel']['background_h']) ? ($extended_reviews['cancel']['background_h']) : ('ef5949')); ?>, 
    #<?php echo (isset($extended_reviews['cancel']['background2_h']) ? ($extended_reviews['cancel']['background2_h']) : ('ef5949')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['cancel']['background_h']) ? ($extended_reviews['cancel']['background_h']) : ('ef5949')); ?>;
  <?php } ?>
    color: #<?php echo (isset($extended_reviews['cancel']['text_h']) ? ($extended_reviews['cancel']['text_h']) : ('fff')); ?>;
    border-color: #<?php echo (isset($extended_reviews['cancel']['border_color_h']) ? ($extended_reviews['cancel']['border_color_h']) : ('ef5949')); ?>;
  }
  .ex-light {
  <?php if ($extended_reviews['light']['gradient']) { ?>
    background: linear-gradient( <?php echo $extended_reviews['light']['gradient']; ?>, 
    #<?php echo (isset($extended_reviews['light']['background']) ? ($extended_reviews['light']['background']) : ('fc6e5f')); ?>, 
    #<?php echo (isset($extended_reviews['light']['background2']) ? ($extended_reviews['light']['background2']) : ('fc6e5f')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['light']['background']) ? ($extended_reviews['light']['background']) : ('fc6e5f')); ?>;
  <?php } ?>
    color: #<?php echo (isset($extended_reviews['light']['text']) ? ($extended_reviews['light']['text']) : ('fff')); ?>;
    border-color: #<?php echo (isset($extended_reviews['light']['border_color']) ? ($extended_reviews['light']['border_color']) : ('fc6e5f')); ?>;
  }
  .ex-light-hover,
  .ex-light:hover {
  <?php if ($extended_reviews['light']['hover_gradient']) { ?>
    background: linear-gradient(<?php echo $extended_reviews['light']['hover_gradient']; ?>, 
    #<?php echo (isset($extended_reviews['light']['background_h']) ? ($extended_reviews['light']['background_h']) : ('ef5949')); ?>, 
    #<?php echo (isset($extended_reviews['light']['background2_h']) ? ($extended_reviews['light']['background2_h']) : ('ef5949')); ?>);
  <?php } else { ?>
    background: #<?php echo (isset($extended_reviews['light']['background_h']) ? ($extended_reviews['light']['background_h']) : ('ef5949')); ?>;
  <?php } ?>
    color: #<?php echo (isset($extended_reviews['light']['text_h']) ? ($extended_reviews['light']['text_h']) : ('fff')); ?>;
    border-color: #<?php echo (isset($extended_reviews['light']['border_color_h']) ? ($extended_reviews['light']['border_color_h']) : ('ef5949')); ?>;
  }
</style>