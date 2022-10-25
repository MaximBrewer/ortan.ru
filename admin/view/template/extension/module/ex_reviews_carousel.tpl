<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-technics_news" data-toggle="tooltip" title="<?php echo $button_save; ?>"
          class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i
            class="fa fa-reply"></i></a></div>
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
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-technics_news"
          class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#main-settings" data-toggle="tab"><?php echo $text_main_settings; ?></a></li>
            <li><a href="#thumb-settings" data-toggle="tab"><?php echo $text_media_settings; ?></a></li>
            <li><a href="#carousel-settings" data-toggle="tab"><?php echo $text_carousel_settings; ?></a></li>
            <li><a href="#css-settings" data-toggle="tab"><?php echo $text_style_settings; ?></a></li>
            <li><a href="#compatibility-settings" data-toggle="tab"><?php echo $text_compatibility_settings; ?></a></li>
            <li><a href="#plagin-settings" data-toggle="tab"><?php echo $text_api_settings; ?></a></li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane active" id="main-settings">
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $entry_name; ?>" id="input-name"
                    class="form-control" />
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-header"><?php echo $text_carousel_title; ?></label>
                <div class="col-sm-10">
                  <?php foreach($languages as $_key => $language) { ?> 
                  <div class="input-group"><span class="input-group-addon"><img
                        src="language/<?php echo $language['code']; ?>/<?php echo $language['code']; ?>.png"
                        title="<?php echo $language['name']; ?>" /></span>
                    <input type="text" name="title[<?php echo $language['language_id']; ?>]"
                      value="<?php echo (isset($title[$language['language_id']]) ? ($title[$language['language_id']]) : ('')); ?>"
                      placeholder="<?php echo $entry_title; ?>" id="input-header" class="form-control" />
                  </div>
                  <?php } ?>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-limit"><?php echo $entry_limit; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="limit" value="<?php echo $limit; ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit"
                    class="form-control" />
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_sort_type; ?></label>
                <div class="col-sm-10">
                  <select name="type" class="form-control">
                    <?php foreach($review_types as $key => $value) { ?> 
                    <?php if ($key == $type) { ?>
                    <option value="<?php echo $key; ?>" selected="selected"><?php echo $value; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $key; ?>"><?php echo $value; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_selection_type; ?></label>
                <div class="col-sm-10">
                  <select name="media" class="form-control">
                    <?php foreach($media_types as $key => $value) { ?> 
                    <?php if ($key == $media) { ?>
                    <option value="<?php echo $key; ?>" selected="selected"><?php echo $value; ?></option>
                    <?php } else { ?>
                    <option value="<?php echo $key; ?>"><?php echo $value; ?></option>
                    <?php } ?>
                    <?php } ?>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="status" id="input-status" class="form-control">
                    <?php if ($status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>


            </div>
            <div class="tab-pane" id="thumb-settings">
              <div class="settings-block">
                <h2 class="text-center"><?php echo $text_thumb_reviews; ?></h2>
                <br>
                <h3><?php echo $text_thumb_product; ?></h3>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 control-label" for="all-thumb-width"><?php echo $text_thumb_size; ?></label>
                  <div class="col-sm-6 col-lg-4 ">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[product_thumb_width]"
                          value="<?php echo (( isset($thumb_settings['product_thumb_width'])) ? ($thumb_settings['product_thumb_width']) : (300)); ?>"
                          placeholder="<?php echo $entry_width; ?>" id="all-thumb-width" class="form-control">
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[product_thumb_height]"
                          value="<?php echo (( isset($thumb_settings['product_thumb_height'])) ? ($thumb_settings['product_thumb_height']) : (300)); ?>"
                          placeholder="<?php echo $entry_height; ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                    for="all-border-radius-photo"><?php echo $text_thumb_radius; ?></label>
                  <div class="col-sm-2 col-lg-1 col-xs-4">
                    <input type="text" name="thumb_settings[border_radius_photo]"
                      value="<?php echo (( isset($thumb_settings['border_radius_photo'])) ? ($thumb_settings['border_radius_photo']) : (2)); ?>"
                      id="all-border-radius-photo" class="form-control">
                  </div>
                </div>
                <hr>
                <br>
                <h3><?php echo $text_thumb_photo; ?></h3>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                    for="input-limit"><?php echo $text_photo_limit; ?></label>
                  <div class="col-sm-2 col-lg-1 col-xs-4">
                    <input type="text" name="thumb_settings[thumb_limit]"
                      value="<?php echo (isset($thumb_settings['thumb_limit']) ? ($thumb_settings['thumb_limit']) : (4)); ?>" placeholder="<?php echo $entry_limit; ?>" id="input-limit"
                      class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 control-label" for="all-thumb-width"><?php echo $text_thumb_size; ?></label>
                  <div class="col-sm-6 col-lg-4 ">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[thumb_width]"
                          value="<?php echo (( isset($thumb_settings['thumb_width'])) ? ($thumb_settings['thumb_width']) : (50)); ?>"
                          placeholder="<?php echo $entry_width; ?>" id="all-thumb-width" class="form-control">
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[thumb_height]"
                          value="<?php echo (( isset($thumb_settings['thumb_height'])) ? ($thumb_settings['thumb_height']) : (50)); ?>"
                          placeholder="<?php echo $entry_height; ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                    for="all-border-radius-photo"><?php echo $text_thumb_radius; ?></label>
                  <div class="col-sm-2 col-lg-1 col-xs-4">
                    <input type="text" name="thumb_settings[border_radius_photo]"
                      value="<?php echo (( isset($thumb_settings['border_radius_photo'])) ? ($thumb_settings['border_radius_photo']) : (2)); ?>"
                      id="all-border-radius-photo" class="form-control">
                  </div>
                </div>
                <hr>
                <br>
                <h3><?php echo $text_thumb_video; ?></h3>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                    for="input-limit"><?php echo $text_video_limit; ?></label>
                  <div class="col-sm-2 col-lg-1 col-xs-4">
                    <input type="text" name="thumb_settings[video_thumb_limit]"
                      value="<?php echo (isset($thumb_settings['video_thumb_limit']) ? ($thumb_settings['video_thumb_limit']) : (2)); ?>" placeholder="<?php echo $entry_limit; ?>"
                      id="input-limit" class="form-control" />
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 control-label"
                    for="all-video-thumb-width"><?php echo $text_thumb_size; ?></label>
                  <div class="col-sm-6 col-lg-4">
                    <div class="row">
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[video_thumb_width]"
                          value="<?php echo (( isset($thumb_settings['video_thumb_width'])) ? ($thumb_settings['video_thumb_width']) : (90)); ?>"
                          placeholder="<?php echo $entry_width; ?>" id="all-video-thumb-width" class="form-control">
                      </div>
                      <div class="col-sm-6">
                        <input type="text" name="thumb_settings[video_thumb_height]"
                          value="<?php echo (( isset($thumb_settings['video_thumb_height'])) ? ($thumb_settings['video_thumb_height']) : (50)); ?>"
                          placeholder="<?php echo $entry_height; ?>" class="form-control">
                      </div>
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 col-lg-4 col-xs-8 control-label"
                    for="border-radius-video"><?php echo $text_thumb_radius; ?></label>
                  <div class="col-sm-2 col-lg-1 col-xs-4">
                    <input type="text" name="thumb_settings[border_radius_video]"
                      value="<?php echo (( isset($thumb_settings['border_radius_video'])) ? ($thumb_settings['border_radius_video']) : (2)); ?>"
                      id="all-border-radius-video" class="form-control">
                  </div>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="carousel-settings">
              <div class="settings-block">
                <h4><?php echo $text_slide_count; ?></h4>
                <div class="row">
                  <div class="form-group col-lg-4 col-md-6 col-xs-12">
                    <label class="col-sm-6 control-label">1200px+</label>
                    <div class="col-sm-6">
                      <input type="text" name="carousel[count_1200]"
                        value="<?php echo (( isset($carousel['count_1200'])) ? ($carousel['count_1200']) : (4)); ?>"
                        class="form-control">
                    </div>
                  </div>
                  <div class="form-group col-lg-4 col-md-6 col-xs-12">
                    <label class="col-sm-6 control-label">769px - 1199px</label>
                    <div class="col-sm-6">
                      <input type="text" name="carousel[count_769]"
                        value="<?php echo (( isset($carousel['count_769'])) ? ($carousel['count_769']) : (3)); ?>"
                        class="form-control">
                    </div>
                  </div>
                  <div class="form-group col-lg-4 col-md-6 col-xs-12">
                    <label class="col-sm-6 control-label">481px - 768px</label>
                    <div class="col-sm-6">
                      <input type="text" name="carousel[count_481]"
                        value="<?php echo (( isset($carousel['count_481'])) ? ($carousel['count_481']) : (2)); ?>"
                        class="form-control">
                    </div>
                  </div>
                  <div class="form-group col-lg-4 col-md-6 col-xs-12">
                    <label class="col-sm-6 control-label">480px-</label>
                    <div class="col-sm-6">
                      <input type="text" name="carousel[count_0]"
                        value="<?php echo (( isset($carousel['count_0'])) ? ($carousel['count_0']) : (1)); ?>" class="form-control">
                    </div>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_navigation_arrows; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="carousel[arrows]" value="1"
                        <?php echo (isset($carousel['arrows']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-6 control-label"><?php echo $text_carousel_pagination; ?></label>
                  <div class="col-sm-6">
                    <label class="fresh-check">
                      <input type="checkbox" name="carousel[pagination]" value="1"
                        <?php echo (isset($carousel['pagination']) ? ('checked="checked"') : ('')); ?> /><span></span>
                    </label>
                  </div>
                </div>
              </div>

            </div>
            <div class="tab-pane" id="css-settings">
              <h2><?php echo $text_card_style; ?></h2>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_castom_style; ?></label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="style[status]" value="1"
                      <?php echo (isset($style['status']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 control-label"><?php echo $text_card_shadow; ?></label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="style[shadow]" value="1"
                      <?php echo (isset($style['shadow']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_card_margin; ?></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="style[box][margin]"
                    value="<?php echo (isset($style['box']['margin']) ? ($style['box']['margin']) : ('10')); ?>"
                    class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><span data-toggle="tooltip"
                    title="<?php echo $text_border_radius_help; ?>"><?php echo $text_card_border_radius; ?></span></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="style[box][border-radius]"
                    value="<?php echo (isset($style['box']['border-radius']) ? ($style['box']['border-radius']) : (4)); ?>"
                    class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_card_border; ?></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="style[box][border]"
                    value="<?php echo (isset($style['box']['border']) ? ($style['box']['border']) : (0)); ?>" class="form-control">
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-8 control-label"><?php echo $text_font_size; ?></label>
                <div class="col-sm-2 col-lg-1 col-xs-4">
                  <input type="text" name="style[box][font-size]"
                    value="<?php echo (isset($style['box']['font-size']) ? ($style['box']['font-size']) : (12)); ?>" class="form-control">
                </div>
              </div>


              <div class="form-group">
                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_text_color; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box][color]"
                      value="<?php echo (isset($style['box']['color']) ? ($style['box']['color']) : ('#777777')); ?>">
                  </div>
                </div>

                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_link_color; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box][link-color]"
                      value="<?php echo (isset($style['box']['link-color']) ? ($style['box']['link-color']) : ('#337ab7')); ?>">
                  </div>
                </div>

                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_link_hover_color; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box][link-hover-color]"
                      value="<?php echo (isset($style['box']['link-hover-color']) ? ($style['box']['link-hover-color']) : ('#23527c')); ?>">
                  </div>
                </div>
              </div>

              <div class="form-group">
                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_background_color; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box][background]"
                      value="<?php echo (isset($style['box']['background']) ? ($style['box']['background']) : ('#fbfbfb')); ?>">
                  </div>
                </div>

                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_border_color; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box][border-color]"
                      value="<?php echo (isset($style['box']['border-color']) ? ($style['box']['border-color']) : ('#fbfbfb')); ?>">
                  </div>
                </div>
              </div>

              <div class="form-group">
                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_card_footer_background; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box_footer][background]"
                      value="<?php echo (isset($style['box_footer']['background']) ? ($style['box_footer']['background']) : ('#f6f6f6')); ?>">
                  </div>
                </div>
                <div class="col-lg-3 col-sm-6 col-xs-12">
                  <div class="input-group">
                    <span class="input-group-addon"><?php echo $text_card_footer_text; ?></span>
                    <input class="form-control jscolor {required:false}" name="style[box_footer][color]"
                      value="<?php echo (isset($style['box_footer']['color']) ? ($style['box_footer']['color']) : ('#777777')); ?>">
                  </div>
                </div>
              </div>
            </div>
            <div class="tab-pane" id="compatibility-settings">
              <?php $carousel_types = ['1' => 'Swiper', '2' => 'Owl-carousel', '3' => 'Owl-carousel 2', '4' => 'Slick', '0' => $text_disabled]; ?>
              <?php $gallery_types = ['1' => 'Magnific Popup', '2' => 'Fancybox', '0' => $text_disabled]; ?>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_carousel_type; ?></label>
                <div class="col-sm-10">
                  <select name="carousel_type" class="form-control">
                    <?php foreach($carousel_types as $key => $name) { ?> 
                    <option value="<?php echo $key; ?>" <?php echo (($carousel_type == $key) ? ('selected') : ('')); ?>><?php echo $name; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $text_gallery_type; ?></label>
                <div class="col-sm-10">
                  <select name="gallery_type" class="form-control">
                    <?php foreach($gallery_types as $key => $name) { ?> 
                    <option value="<?php echo $key; ?>" <?php echo (($gallery_type == $key) ? ('selected') : ('')); ?>><?php echo $name; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-12 control-label"><span data-toggle="tooltip"
                    title="<?php echo $text_box_class_help; ?>"><?php echo $text_box_class; ?></span></label>
                <div class="col-sm-6 col-lg-4 col-xs-12">
                  <input type="text" name="box_classname" value="<?php echo $box_classname; ?>" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-12 control-label"><span data-toggle="tooltip"
                    title="<?php echo $text_title_class_help; ?>"><?php echo $text_title_class; ?></span></label>
                <div class="col-sm-6 col-lg-4 col-xs-12">
                  <input type="text" name="title_classname" value="<?php echo $title_classname; ?>" class="form-control">
                </div>
              </div>
              <div class="form-group">
                <label class="col-sm-6 col-lg-4 col-xs-12 control-label"><span data-toggle="tooltip"
                    title="<?php echo $text_card_class_help; ?>"><?php echo $text_card_class; ?></span></label>
                <div class="col-sm-6 col-lg-4 col-xs-12">
                  <input type="text" name="card_classname" value="<?php echo $card_classname; ?>" class="form-control">
                </div>
              </div>
            </div>
            <div class="tab-pane" id="plagin-settings">

              <div class="clarification-for-users"><?php echo $api_notifications; ?></div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Ex_carousel.css</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[ex_css]" value="1"
                      <?php echo (isset($plagin['ex_css']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Ex_carousel.js</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[ex_js]" value="1"
                      <?php echo (isset($plagin['ex_js']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">MagnificPopup</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[magnific]" value="1"
                      <?php echo (isset($plagin['magnific']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Fancybox</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[fancybox]" value="1"
                      <?php echo (isset($plagin['fancybox']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Owl-carousel</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[carousel]" value="1"
                      <?php echo (isset($plagin['carousel']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Owl-carousel 2</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[carousel2]" value="1"
                      <?php echo (isset($plagin['carousel2']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Slick carousel</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[slick]" value="1"
                      <?php echo (isset($plagin['slick']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

              <div class="form-group">
                <label class="col-sm-6 control-label">Swiper carousel</label>
                <div class="col-sm-6">
                  <label class="fresh-check">
                    <input type="checkbox" name="plagin[swiper]" value="1"
                      <?php echo (isset($plagin['swiper']) ? ('checked="checked"') : ('')); ?> /><span></span>
                  </label>
                </div>
              </div>

            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?>