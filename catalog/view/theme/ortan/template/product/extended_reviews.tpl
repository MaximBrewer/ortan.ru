<?php
 $uniqid = uniqid();
?>
<div id="ex-reviews-<?php echo $uniqid;?>" class="ex-reviews-class">
  <div class="ex-button-right-block"><button class="opbtn__buy btn"
      onclick="$('#ex-form-review-<?php echo $uniqid;?>').slideToggle(200);">
      <svg class="ex-pencil-svg">
        <use xlink:href="#ex-pencil-<?php echo $uniqid;?>"></use>
      </svg> <?php echo $text_write; ?> </button></div>
  <!-- review-written-block -->
  <form id="ex-form-review-<?php echo $uniqid;?>" style="<?php echo $reviews ? '' : 'display:block'; ?>" class="ex-form-review-class">
    <div class="ex-title"><?php echo $text_write; ?></div>
    <div class="ex-form">
      <div class="add-review-star-wrap" id='super-stars-<?php echo $uniqid;?>'>
        <div class='star-block' value='1'><svg class="ex-star-input">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg></div>
        <div class='star-block' value='2'><svg class="ex-star-input">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg></div>
        <div class='star-block' value='3'><svg class="ex-star-input">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg></div>
        <div class='star-block' value='4'><svg class="ex-star-input">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg></div>
        <div class='star-block' value='5'><svg class="ex-star-input">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg></div>
      </div>
      <div class="super-star-text"></div>
      <input type="hidden" value="0" id="rating-<?php echo $uniqid;?>" name="rating">
    </div>
    <div style="display:<?php echo ((( isset($settings['limitations']) && $settings['limitations'])) ? ('block') : ('none')); ?>">
      <div class="ex-form">
        <label for="input-text-plus"><?php echo $text_plus; ?></label>
        <input type="text" name="plus" id="input-text-plus-<?php echo $uniqid;?>" class="form-control" />
      </div>
      <div class="ex-form">
        <label for="input-text-plus"><?php echo $text_minus; ?></label>
        <input type="text" name="minus" id="input-text-minus-<?php echo $uniqid;?>" class="form-control" />
      </div>
    </div>
    <div class="ex-form">
      <label class="control-label" for="input-review"><?php echo $entry_review; ?></label>
      <textarea name="text" rows="5" id="input-review-<?php echo $uniqid;?>" class="form-control"></textarea>
    </div>
    <?php if ((isset($settings['photo_status']) || isset($settings['video_status']))) { ?>
    <div class="reviews-user-add-content-block">
      <?php if (isset($settings['photo_status'])) { ?>
      <div class="review-media-add-block">
        <div class="btn-link-review" id="add-photo-<?php echo $uniqid;?>">
          <svg class="media-add-button-icon">
            <use href="#ex-photo-svg-<?php echo $uniqid;?>"></use>
          </svg>
          <span class="btn-link-text"><?php echo $text_add_photo; ?></span></div>
      </div>
      <?php } ?>
      <?php if (isset($settings['video_status'])) { ?>
      <div class="review-media-add-block">
        <div class="btn-link-review" id="add-video-<?php echo $uniqid;?>">
          <svg class="media-add-button-icon">
            <use href="#ex-video-svg-<?php echo $uniqid;?>"></use>
          </svg>
          <span class="btn-link-text"><?php echo $text_add_video; ?></span></div>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="ex-form">
      <?php if (isset($settings['photo_status'])) { ?>
      <div id="review-image-<?php echo $uniqid;?>" class="dropzone ex-hidden"></div>
      <?php } ?>
      <?php if (isset($settings['video_status'])) { ?>
      <div class="ex-hidden" id="tab-add-video-<?php echo $uniqid;?>">
        <label for="input-text-plus"><?php echo $youtube_link; ?></label>
        <div class="video-input">
          <input type="text" id="input-video-href-<?php echo $uniqid;?>" class="form-control" />
          <button class="ex-btn ex-light" id="add-video-button-<?php echo $uniqid;?>" onclick="addVideo(this)"
            type="button"><?php echo $button_add_video_text; ?></button>
        </div>
        <div id='video-caption-<?php echo $uniqid;?>'><?php echo $add_video_note; ?></div>
      </div>
      <?php } ?>
      <div class="ex-allert-block"></div>
    </div>
    <div class="images-user-content-block"></div>
    <div id="video-thumb-preview-<?php echo $uniqid;?>"></div>
    <div class="ex-form">
      <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
      <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-name-<?php echo $uniqid;?>" class="form-control" />
    </div>
    <?php if (isset($settings['email'])) { ?>
    <div class="ex-form">
      <label class="control-label" for="input-email"><?php echo $text_email; ?></label>
      <input type="text" name="email" value="<?php echo $customer_email; ?>" id="input-email-<?php echo $uniqid;?>" class="form-control" />
    </div>
    <div class="ex-form">
      <input class="ex-check-input" name="alert" type="checkbox" value="1" id="email-alert-<?php echo $uniqid;?>">
      <label class="ex-check-label" for="email-allert"><?php echo $text_answer_alert; ?></label>
    </div>
    <?php } ?>
    <?php echo $captcha; ?>
    <input type="hidden" name="image_id" id="input-image-id-<?php echo $uniqid;?>" class="form-control" />
    <input type="hidden" name="video_links" id="input-video-links-<?php echo $uniqid;?>" class="form-control" />
    <div class="ex-form-footer">
      <?php if ($review_guest) { ?>
      <button type="button" id="button-review-extended-<?php echo $uniqid;?>" data-loading-text="<?php echo $text_loading; ?>"
        class="opbtn__buy btn"><?php echo $leave_feedback; ?></button>
      <?php } else { ?>
      <div class="ex-alert alert-info"> <?php echo $text_login; ?></div>
      <?php } ?>
    </div>
  </form>
  <?php if ($reviews) { ?>
  <?php if ((isset($settings['all_media']) && ( isset($total_videos) ||  isset($total_images)))) { ?>
  <div class="review-media-all">
    <?php if (!empty($total_images)) { ?>
    <p class="review-all-photo-title"><?php echo $customers_photo; ?></p>
    <div class="ex-drag all-reviews-thumbnails">
      <?php foreach($total_images as $_key => $images) { ?> 
      <?php foreach($images as $_key => $image) { ?> 
      <div class="ex-image-additional">
        <a class="ex-thumbnail" <?php echo ((isset($settings['fancy'])) ? ('data-fancybox="allreviews-gallery"') : ('')); ?>
          href="<?php echo $image['popup']; ?>"> <img src="<?php echo $image['thumb']; ?>"
            class="<?php echo (($image['type'] == '0') ? ('image-crop') : ('imgbb')); ?>" /></a>
      </div>
      <?php } ?>
      <?php } ?>
    </div>
    <?php } ?>
    <?php if (!empty($total_videos)) { ?>
    <p class="review-all-photo-title"><?php echo $customers_video; ?></p>
    <div class="ex-drag all-reviews-videos">
      <?php foreach($total_videos as $_key => $video) { ?> 
      <div class="ex-video-thumbnail"><a <?php echo ((isset($settings['fancy'])) ? ('data-fancybox') : ('')); ?> class="popup-youtube"
          href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img
            src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt="" class="youtube-click">
          <svg class="ex-youtube-svg">
            <use xlink:href="#ex-youtube-<?php echo $uniqid;?>"></use>
          </svg></a></div>
      <?php } ?>
    </div>
    <?php } ?>
  </div>
  <?php } ?>

  <div class="ex-top-group">
    <div class="ex-sort">
      <select class="ex-select form-control" onchange="$('#ex-review-<?php echo $uniqid;?>').load(this.value);">
        <?php foreach($sorts as $_key => $sorts) { ?> 
        <?php if ($sorts['value'] == $sort) { ?>
        <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sort_title; ?>: <?php echo $sorts['text']; ?></option>
        <?php } else { ?>
        <option value="<?php echo $sorts['href']; ?>"><?php echo $sort_title; ?>: <?php echo $sorts['text']; ?></option>
        <?php } ?>
        <?php } ?>
      </select>
    </div>
  </div>
  <div class="ex-reviews-box">
    <div class="ex-reviews-stack">
      <?php foreach($reviews as $_key => $review) { ?> 
      <div class="review-container"
        <?php echo ((isset($settings['micro'])) ? ('itemprop="review" itemscope itemtype="http://schema.org/Review"') : ('')); ?>>
        <div class="review-title-container">
          <?php if ($review['purchased']) { ?>
            <span class='allready-buy' data-toggle="tooltip" title="<?php echo $text_already_buy; ?>"><svg class="ex-cart-svg">
                <use xlink:href="#ex-cart-<?php echo $uniqid;?>"></use>
              </svg></span>
            <?php } ?>
          <div class="review-author">
            <span class="review-author-name"
              <?php echo ((isset($settings['micro'])) ? ('itemprop="author"') : ('')); ?>><?php echo $review['author']; ?></span>
          </div>
          <div class="review-rating-change-buttons">
            <button class="review-vote review-vote-positive" data-value="<?php echo $review['review_id']; ?>">
              <svg class="ex-like">
                <use xlink:href="#ex-thumb-<?php echo $uniqid;?>"></use>
              </svg>
              <span class="review-vote-count" data-value="<?php echo $review['likes']; ?>"
                id="vote_count_positive-<?php echo $review['review_id']; ?>-<?php echo $uniqid;?>"><?php echo $review['likes'] > 0 ? $review['likes'] : 0; ?></span>
            </button>
            <button class="review-vote review-vote-negative" data-value="<?php echo $review['review_id']; ?>">
              <svg class="ex-like ex-dislike">
                <use xlink:href="#ex-thumb-<?php echo $uniqid;?>"></use>
              </svg>
              <span class="review-vote-count" data-value="<?php echo $review['dislikes']; ?>"
                id="vote_count_negative-<?php echo $uniqid;?>-<?php echo $review['review_id']; ?>"><?php echo $review['dislikes'] > 0 ? $review['dislikes'] : 0; ?></span>
            </button>
          </div>
          <?php if (isset($settings['micro'])) { ?>
          <meta itemprop="name" content="<?php echo $review['pd_name']; ?>">
          <meta itemprop="datePublished" content="<?php echo $review['date_added']; ?>">
          <div itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
            <meta itemprop="worstRating" content="1">
            <meta itemprop="ratingValue" content="<?php echo $review['rating']; ?>">
            <meta itemprop="bestRating" content="5">
          </div>
          <?php } ?>
        </div>
        <div class="rating-container">
          <?php if ($review['rating'] != 0) { ?>
          <?php $i = 1; ?>
          <?php foreach(range($i, 5) as $_key => $i) { ?> 
          <?php if ($review['rating'] < $i) { ?>
          <svg class="ex-star ex-star-grey">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg>
          <?php } else { ?>
          <svg class="ex-star">
            <use xlink:href="#ex-star-<?php echo $uniqid;?>"></use>
          </svg>
          <?php } ?>
          <?php } ?>
          <?php } ?>
        </div>
        <div class="review-text-container">
          <div class="ex-comment-text" <?php echo ((isset($settings['micro'])) ? ('itemprop="reviewBody"') : ('')); ?>>
            <?php echo $review['text']; ?>
            <?php if (isset($settings['limitations'])) { ?>
            <?php if ($review['plus']) { ?>
              <div class='ex-plus'><?php echo $text_plus; ?> </div><?php echo $review['plus']; ?>
            <?php } ?>
            <?php if ($review['minus']) { ?>
              <div class='ex-minus'><?php echo $text_minus; ?> </div><?php echo $review['minus']; ?>
            <?php } ?>
            <?php } ?>
          </div>
        </div>
        <?php if ((isset($settings['photo_status']) || isset($settings['video_status']))) { ?>
        <div class="review-media-container">
          <?php if (isset($settings['photo_status'])) { ?>
          <?php if ($review['images']) { ?>
          <div class="ex-drag ex-photo-thumbnails">
            <?php foreach($review['images'] as $_key => $image) { ?> 
            <div class="ex-image-additional"><a class="ex-thumbnail"
                <?php echo (isset($settings['fancy']) ? ('data-fancybox="reviews-gallery"') : ('')); ?> href="<?php echo $image['popup']; ?>"
                title="<?php echo $review['pd_name']; ?>"> <img src="<?php echo $image['thumb']; ?>" title="<?php echo $review['pd_name']; ?>"
                  alt="<?php echo $review['pd_name']; ?>" class="<?php echo (($image['type'] == '0') ? ('image-crop') : ('imgbb')); ?>" /></a>
            </div>
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>
          <?php if (isset($settings['video_status'])) { ?>
          <?php if ($review['videos']) { ?>
          <div class="ex-drag ex-video-thumbnails">
            <?php foreach($review['videos'] as $_key => $video) { ?> 
            <div class="ex-video-thumbnail"><a <?php echo (isset($settings['fancy']) ? ('data-fancybox') : ('')); ?> class="popup-youtube"
                href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img
                  src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt="" class="youtube-click"><svg
                  class="ex-youtube-svg">
                  <use xlink:href="#ex-youtube-<?php echo $uniqid;?>"></use>
                </svg></a></div>
            <?php } ?>
          </div>
          <?php } ?>
          <?php } ?>
        </div>
        <?php } ?>
        <div class="review-container-footer">
          <div class="review-date"><?php echo $review['date_added']; ?></div>
          <?php if (isset($settings['answer'])) { ?>
          <button type="button" class="ex-btn ex-light review-answer-button" data-value="<?php echo $review['review_id']; ?>"><svg
              class="ex-reply-svg">
              <use xlink:href="#ex-reply-<?php echo $uniqid;?>"></use>
            </svg> <?php echo $text_reply; ?></button>
          <?php } ?>
          <div class="review_note" id="review-note-<?php echo $uniqid;?>-<?php echo $review['review_id']; ?>"></div>
        </div>
        <div class="review-answer-container" id="review_answer_container-<?php echo $uniqid;?>-<?php echo $review['review_id']; ?>"></div>
        <?php if ($review['admin_reply'] ||  $review['children_reviews']) { ?>
        <div class="review-childrens-container">
          <?php if ($review['admin_reply']) { ?>
          <div class="review-answer-title-container">
            <div class="review-author">
              <span class="review-author-name review-admin-name"><?php echo $review['admin_name']; ?></span>
              <svg data-toggle="tooltip" data-original-title="<?php echo $text_admin_answer; ?>" class="ex-check-svg">
                <use xlink:href="#ex-check-<?php echo $uniqid;?>"></use>
              </svg>
            </div>
          </div>
          <div class="review-text-container">
            <div class="ex-comment-text">
              <?php echo $review['admin_reply']; ?>
            </div>
          </div>
          <?php } ?>
          <?php if ($review['children_reviews']) { ?>
          <?php foreach($review['children_reviews'] as $_key => $children_review) { ?> 
          <div class="children-review-container">
            <div class="review-answer-title-container">
              <div class="review-author"><span class="review-author-name"><?php echo $children_review['author']; ?></span>
              </div>
            </div>
            <div class="review-text-container">
              <div class="ex-comment-text">
                <?php echo $children_review['text']; ?>
              </div>
            </div>
            <div class="review-date"><?php echo $children_review['date_added']; ?></div>
          </div>
          <?php } ?>
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if (isset($more) ) { ?>
      <div class="text-center show-more-block">
        <button class="show-more-button" id="show-more-<?php echo $uniqid;?>" onclick="showMore('<?php echo $more; ?>')"><svg class="ex-more-svg">
            <use xlink:href="#ex-more-<?php echo $uniqid;?>"></use>
          </svg> <?php echo $more_text; ?></button>
      </div>
      <?php } ?>
      <?php if (isset($pagination)) { ?>
      <div class="pagination-block text-right"><?php echo $pagination; ?></div>
      <?php } ?>
    </div>
  </div>
  <?php } else { ?>
  <p><?php echo $text_no_reviews; ?></p>
  <?php } ?>

  <!-- media-add-popup -->
  <div class="ex-hidden" id="hidden-popups-<?php echo $uniqid;?>">
    <form class="form-horizontal" id="form-answer-review-<?php echo $uniqid;?>">
      <div class="ex-form">
        <label class="control-label" for="input-review"><?php echo $text_comment; ?></label>
        <textarea name="text" rows="5" id="input-answer-review-<?php echo $uniqid;?>" class="form-control"></textarea>
      </div>
      <div class="ex-form">
        <label class="control-label" for="input-name"><?php echo $entry_name; ?></label>
        <input type="text" name="name" value="<?php echo $customer_name; ?>" id="input-answer-name-<?php echo $uniqid;?>" class="form-control" />
      </div>
      <?php echo $captcha; ?>
      <div class="ex-form-buttons">
        <button type="button" class="ex-btn ex-cancel" id="review-cancel-button-<?php echo $uniqid;?>"><?php echo $text_cancel; ?></button>
        <button type="button" class="opbtn__buy btn" id="button-answer-review-<?php echo $uniqid;?>"
          data-loading-text="<?php echo $text_loading; ?>"><?php echo $leave_feedback; ?></button>
      </div>
    </form>
  </div>
</div>
  <script>
    <?php if (isset($settings['magn']) &&  !isset($settings['fancy'])) { ?>
    addMagnific('.all-reviews-thumbnails');
    addMagnific('.ex-photo-thumbnails');
    addMagnificVideo('.popup-youtube');
    <?php } ?>
    addDrag('ex-drag');
    function showMore(link){
    $('.show-more-block').remove();
    $('.pagination-block').remove();
    $('.ex-reviews-box').append($('<div>').load(link + ' .ex-reviews-stack', function(){
      addDrag('ex-drag');
      <?php if ((isset($settings['magn']) &&  !isset($settings['fancy']))) { ?>
        addMagnific('.all-reviews-thumbnails');
        addMagnific('.ex-photo-thumbnails');
        addMagnificVideo('.popup-youtube');
      <?php } ?>
    }));
    }
  </script>
<script>
var product_id = <?php echo $product_id; ?>;
var inputImageId = $("#input-image-id-<?php echo $uniqid;?>");
var inputVideos = $("#input-video-links-<?php echo $uniqid;?>");
var photoTab = $('.photo-tab');
var tabPhoto = $('#tab-add-photo-<?php echo $uniqid;?>');
var videoTab = $('.video-tab');
var tabVideo = $('#tab-add-video-<?php echo $uniqid;?>');
var images_id = [];
var count = 0;
<?php if (isset($settings['photo_status'])) { ?>
    Dropzone.autoDiscover = false;
    var myDropzone = new Dropzone("div#review-image-<?php echo $uniqid;?>", {
    url:"index.php?route=product/extended_reviews/check",
    maxFiles: <?php echo $settings['image_max_count']; ?>,
    maxFilesize: <?php echo $settings['image_max_size']; ?>,
    dictInvalidFileType: '<?php echo $error_invalid_type; ?>',
    dictFileTooBig: '<?php echo $error_too_big; ?>',
    dictRemoveFile: '<svg class="ex-trash-svg"><use href="#ex-trash-<?php echo $uniqid;?>"></use></svg>',
    dictCancelUpload: '<svg class="ex-trash-svg"><use href="#ex-trash-<?php echo $uniqid;?>"></use></svg>',
    dictDefaultMessage: '<?php echo $text_loading; ?>',
    dictMaxFilesExceeded: '<?php echo $error_max_files; ?>',
    addRemoveLinks: true,
    timeout: 180000,
    parallelUploads: 1,
    init: function(){
      $(this.element).html(this.options.dictDefaultMessage);
    },
    dictDefaultMessage: '<?php echo $dropzone_default_message; ?>',
    acceptedFiles:'.jpg, .jpeg, .png',
    error: function(file, errorMessage){
      $('.ex-alert').remove();
      $('.ex-allert-block').append('<div class="ex-alert alert-danger"> '+ errorMessage +'</div>');
      myDropzone.removeFile(file);
    },
    success: function(file, responce){
      //console.log(responce);
      if(responce.error){
        this.options.error(file, responce.error);
      }
      else{
      var btndelete = file.previewElement.querySelector(".dz-remove");
      btndelete.setAttribute("id", 'delete-midia-id-'+ responce.image_id);
      btndelete.setAttribute("num", count);
      images_id.push(responce.image_id);
      count++;
      this.defaultOptions.success(file);
      $('.images-user-content-block').append($('.dz-success'));
      if($('#review-image-<?php echo $uniqid;?>').find('.dz-preview').length == 0){
        $('#review-image-<?php echo $uniqid;?>').removeClass('dz-started');
      }
    }

    },
    params: {'product-id':product_id}
});

myDropzone.on("removedfile", function (file) {
  var btndelete = file.previewElement.querySelector(".dz-remove");
  if(btndelete.hasAttribute("id")) {
    var iddelete = btndelete.getAttribute("id").split('-').pop();
    var countdelete = btndelete.getAttribute("num");
    $.ajax({
      url: 'index.php?route=product/extended_reviews/deleteImage',
      type: 'post',
      data: { image_id : iddelete } ,
      dataType: 'json',
      success: function(json) {
      images_id[countdelete] = null;
      }
    });
  }
});
<?php } ?>
var review_id;
var note_block;
var form = $('#form-answer-review-<?php echo $uniqid;?>');
$(document).on('click','.review-answer-button',function(){
review_id = $(this).data("value");
var block = $('#review_answer_container-<?php echo $uniqid;?>'+review_id);
note_block = $("#review-note-<?php echo $uniqid;?>-"+review_id);
<?php if ($answer_guest) { ?>
  if(!$(block).children(form).length > 0){
$(form).hide().appendTo(block).slideDown(300);
}
<?php } else { ?>
  $('.ex-alert').remove();
  $(note_block).append('<div class="ex-alert alert-danger"> <?php echo $text_login; ?></div>');
  <?php } ?>
});

$('#review-cancel-button-<?php echo $uniqid;?>').on('click', function(e){
e.preventDefault();
var block = $('#hidden-popups-<?php echo $uniqid;?>');
$(form).slideUp(200).delay(300).queue(function (next) {
  $(this).appendTo(block);
  next();
});
$('.ex-alert').remove();
});

$('#button-answer-review-<?php echo $uniqid;?>').on('click', function(e){
e.preventDefault();
var form = $('#form-answer-review-<?php echo $uniqid;?>');
var btn = $(this);
btn.button('loading');
$.ajax({
  url: 'index.php?route=product/extended_reviews/writeAnswer&product_id=' + product_id + '&parent_id=' + review_id,
  type: 'post',
  dataType: 'json',
  data: $(form).serialize(),
  success: function(json) {
    $('.review-container-footer .ex-alert').remove();
    if (json['error']) {
      $(note_block).append('<div class="ex-alert alert-danger"> ' + json['error'] + '</div>');
      btn.button('reset');
    }

    if (json['success']) {
      $('input[name=\'name\']').val('');
      $('textarea[name=\'text\']').val('');
      $('#review-cancel-button-<?php echo $uniqid;?>').click();
      $(note_block).append('<div class="ex-alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
      btn.button('reset');
    }
  }
});
//  grecaptcha.reset();
});
$('#button-review-extended-<?php echo $uniqid;?>').on('click', function(e) {
e.preventDefault();
var strImages = '';
var strVideos ='';
var btn = $(this);
btn.button('loading');
if(images_id){
for(var i=0; i<images_id.length; i++){
  if(images_id[i] != null)
  strImages+=images_id[i] + ' ';
}
}
if(video_links){
for(var i=0; i<video_links.length; i++){
  if(video_links[i] != null)
  strVideos+=video_links[i] + ' ';
}
}
inputImageId.val(strImages.trim());
inputVideos.val(strVideos.trim());
$.ajax({
  url: 'index.php?route=product/extended_reviews/write&product_id=' + product_id,
  type: 'post',
  dataType: 'json',
  data: $("#ex-form-review-<?php echo $uniqid;?>").serialize(),
  success: function(json) {
    $('.ex-alert').remove();
    if (json['error']) {
      $('.ex-form-footer').prepend('<div class="ex-alert alert-danger"> ' + json['error'] + '</div>');
      btn.button('reset');
    }

    if (json['success']) {
      $('.ex-form-footer').prepend('<div class="ex-alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
      $('input[name=\'plus\']').val('');
      $('input[name=\'minus\']').val('');
      $('textarea[name=\'text\']').val('');
      $('input[name=\'image_id\']').val('');
      $('input[name=\'rating\']').val('0');
      $('input[name=\'video_links\']').val('');
      $('.star-block').removeClass('star-active');
      $('.images-user-content-block > div').remove();
      $('#video-thumb-preview-<?php echo $uniqid;?> > div').remove();
      $('.super-star-text').html('');
      btn.button('reset');
      images_id = [];
      video_links = [];
      count = 0;
    }
  }
});
 //grecaptcha.reset();
});

$(document).on('click', '.review-vote-negative', function() {
$('.review-container-footer .ex-alert').remove();
var id = $(this).data("value");
var votename = "vote"+id;
var note_block = $("#review-note-<?php echo $uniqid;?>-"+id);
<?php if ($likes_guest) { ?>
if(localStorage.getItem(votename) == null){
var vote_count_span = $('#vote_count_negative-<?php echo $uniqid;?>-'+id);
var vote_count = parseInt(vote_count_span.data("value"));
  $.ajax({
    url: 'index.php?route=product/extended_reviews/minusReviewRating',
    type: 'post',
    data: { review_id : id } ,
    dataType: 'json',
    success: function(json) {
      if (json['success']) {
      $(vote_count_span).text(vote_count + 1);
      localStorage.setItem(votename , true);
    }
    }
  });
  $(note_block).append('<div class="ex-alert alert-success"><?php echo $thank_for_rating; ?></div>');
}
else{
  $(note_block).append('<div class="ex-alert alert-warning"><?php echo $already_rating; ?></div>');
}
<?php } else { ?>
  $(note_block).append('<div class="ex-alert alert-info"><?php echo $text_login; ?></div>');
  <?php } ?>
});
$(document).on('click', '.review-vote-positive',  function() {
$('.review-container-footer .ex-alert').remove();
var id = $(this).data("value");
var votename = "vote"+id;
var note_block = $("#review-note-<?php echo $uniqid;?>-"+id);
<?php if ($likes_guest) { ?>
if(localStorage.getItem(votename) == null){
var vote_count_span = $('#vote_count_positive-<?php echo $uniqid;?>-'+id);
var vote_count = parseInt(vote_count_span.data("value"));
  $.ajax({
    url: 'index.php?route=product/extended_reviews/plusReviewRating',
    type: 'post',
    data: { review_id : id } ,
    dataType: 'json',
    success: function(json) {
      $('.success-note').remove();
      if (json['success']) {
      $(vote_count_span).text(vote_count + 1);
      localStorage.setItem(votename , true);
    }
  }
  });
  $(note_block).append('<div class="ex-alert alert-success">&nbsp; <?php echo $thank_for_rating; ?></div>');
}
else{
    $(note_block).append('<div class="ex-alert alert-warning"><?php echo $already_rating; ?></div>');
}
<?php } else { ?>
  $(note_block).append('<div class="ex-alert alert-info"><?php echo $text_login; ?></div>');
<?php } ?>
});
  var starText = ['', '<?php echo $entry_bad; ?>', '<?php echo $entry_soso; ?>', '<?php echo $entry_normal; ?>', '<?php echo $entry_good; ?>', '<?php echo $entry_excellent; ?>'];
$('#super-stars-<?php echo $uniqid;?> > div').on('click', function(){
  $('#super-stars-<?php echo $uniqid;?> > div').removeClass('star-active');
  var id_val = $(this).index()+1;
  $('#super-stars-<?php echo $uniqid;?> > .star-block:nth-child(-n+' + id_val + ')').addClass('star-active');
  $('#rating-<?php echo $uniqid;?>').val(id_val);
  $('.super-star-text').html(starText[id_val]);
});
$('#super-stars-<?php echo $uniqid;?> > div').hover(function(){
  var id_val = $(this).index()+1;
  $('.super-star-text').html(starText[id_val]);
},
function(){
  var current_val = $('#rating-<?php echo $uniqid;?>').val();
  $('.super-star-text').html(starText[current_val]);
});
$('#add-photo-<?php echo $uniqid;?>').on('click', function(){
  $('#tab-add-video-<?php echo $uniqid;?>').hide(100);
  $('#review-image-<?php echo $uniqid;?>').slideToggle(100);
});
$('#add-video-<?php echo $uniqid;?>').on('click', function(){
  $('#review-image-<?php echo $uniqid;?>').hide(100);
  $('#tab-add-video-<?php echo $uniqid;?>').slideToggle(100);
});
var api_key = "<?php echo $settings['api_key_youtube']; ?>";
var video_thumb_block = $('#video-thumb-preview-<?php echo $uniqid;?>');
var video_links = [];
var video_num = 0;
var inputHref = $('#input-video-href-<?php echo $uniqid;?>');
function addVideo(button){
var inputSelector = "#input-video-href-<?php echo $uniqid;?>";
var href = $(inputSelector).val();
var video_id = youtube_parser(href);
if(video_id && !video_links.includes(video_id)){
  $.ajax({
        url: "https://www.googleapis.com/youtube/v3/videos?id=" + video_id + "&key="+ api_key + "&fields=items(snippet(title, thumbnails(default)))&part=snippet",
        dataType: "jsonp",
        success: function(data){
          var video_title = data.items[0].snippet.title;
          var video_thumbnail = data.items[0].snippet.thumbnails.default.url;
          video_links.push(video_id);
          video_thumb_block.append("<div class='vd-prev' id='video-"+video_num+"'><img src='"+video_thumbnail+"' title='"+video_title+"'><button type='button' class='remove_video' onclick='removeVideo("+video_num+")'><svg class='ex-trash-svg'><use href='#ex-trash-<?php echo $uniqid;?>'></use></svg></button></div>");
          video_num++;
          $(inputSelector).val('');
        },
        error: function(jqXHR, textStatus, errorThrown) {
          alert (textStatus, + ' | ' + errorThrown);
        }
    });
}else if(video_links.includes(video_id)){
  $('.ex-alert').remove();
  $('.ex-allert-block').append('<div class="ex-alert alert-danger"><?php echo $error_video; ?></div>');
}else{
  $('.ex-alert').remove();
  $('.ex-allert-block').append('<div class="ex-alert alert-danger"><?php echo $error_bad_link; ?></div>');
}
}
</script>
<style type="text/css">
#ex-reviews-<?php echo $uniqid;?>{
  font-size: <?php echo $settings['main']['font-size']; ?>px !important;
  padding: <?php echo $settings['main']['padding-y']; ?>px <?php echo $settings['main']['padding-x']; ?>px !important;
  font-weight: <?php echo $settings['main']['font-weight']; ?> !important;
}
.ex-image-additional a{
  height: <?php echo $settings['thumb_height']; ?>px !important;
  width: <?php echo $settings['thumb_width']; ?>px !important;
  border-radius: <?php echo $settings['border_radius_photo']; ?>px !important;
}
.ex-image-additional a .image-crop{
  height: <?php echo ($settings['thumb_height'] * 1.8); ?>px !important;
  width: <?php echo ($settings['thumb_width'] * 1.8); ?>px !important;
}
.imgbb{
  height: <?php echo $settings['thumb_height']; ?>px !important;
  width: <?php echo $settings['thumb_width']; ?>px !important;
}
.ex-video-thumbnail img{
  height: <?php echo $settings['video_thumb_height']; ?>px !important;
  width: <?php echo $settings['video_thumb_width']; ?>px !important;
}
.ex-video-thumbnail a{
  height: <?php echo $settings['video_thumb_height']; ?>px !important;
  width: <?php echo $settings['video_thumb_width']; ?>px !important;
  border-radius: <?php echo $settings['border_radius_video']; ?>px !important;
}
.ex-btn{
  border-radius: <?php echo $settings['button']['border-radius']; ?>px !important;
  padding: <?php echo $settings['button']['padding-y']; ?>px <?php echo $settings['button']['padding-x']; ?>px !important;
  font-size: <?php echo $settings['button']['font-size']; ?>px !important;
  text-transform: <?php echo (isset($settings['button']['uppercase']) ? ('uppercase') : ('none')); ?> !important;
  border: <?php echo $settings['button']['border']; ?>px solid !important;
  font-weight: <?php echo $settings['button']['font-weight']; ?> !important;
  transition: all .<?php echo $settings['button']['transition']; ?>s ease-in-out !important;
  min-width: <?php echo $settings['button']['min-width']; ?>px !important;
}
.ex-select{
  border-radius: <?php echo $settings['button']['border-radius']; ?>px !important;
  padding: <?php echo $settings['button']['padding-y']; ?>px <?php echo $settings['button']['padding-x']; ?>px !important;
  font-size: <?php echo $settings['button']['font-size']; ?>px !important;
  text-transform: <?php echo (isset($settings['button']['uppercase']) ? ('uppercase') : ('none')); ?> !important;
}
.ex-accept{
<?php if ($settings['accept']['gradient']) { ?>
  background: linear-gradient(<?php echo $settings['accept']['gradient']; ?>, #<?php echo $settings['accept']['background']; ?>, #<?php echo $settings['accept']['background2']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['accept']['background']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['accept']['text']; ?> !important;
  border-color: #<?php echo $settings['accept']['border_color']; ?> !important;
}
.ex-accept:hover{
<?php if ($settings['accept']['hover_gradient']) { ?>
  background: linear-gradient(<?php echo $settings['accept']['hover_gradient']; ?>, #<?php echo $settings['accept']['background_h']; ?>, #<?php echo $settings['accept']['background2_h']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['accept']['background_h']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['accept']['text_h']; ?> !important;
  border-color: #<?php echo $settings['accept']['border_color_h']; ?> !important;
}
.ex-cancel{
<?php if ($settings['cancel']['gradient']) { ?>
  background: linear-gradient(<?php echo $settings['cancel']['gradient']; ?>, #<?php echo $settings['cancel']['background']; ?>, #<?php echo $settings['cancel']['background2']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['cancel']['background']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['cancel']['text']; ?> !important;
  border-color: #<?php echo $settings['cancel']['border_color']; ?> !important;
}
.ex-cancel:hover{
<?php if ($settings['cancel']['hover_gradient']) { ?>
  background: linear-gradient(<?php echo $settings['cancel']['hover_gradient']; ?>, #<?php echo $settings['cancel']['background_h']; ?>, #<?php echo $settings['cancel']['background2_h']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['cancel']['background_h']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['cancel']['text_h']; ?> !important;
  border-color: #<?php echo $settings['cancel']['border_color_h']; ?> !important;
}
.ex-light{
<?php if ($settings['light']['gradient']) { ?>
  background: linear-gradient(<?php echo $settings['light']['gradient']; ?>, #<?php echo $settings['light']['background']; ?>, #<?php echo $settings['light']['background2']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['light']['background']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['light']['text']; ?> !important;
  border-color: #<?php echo $settings['light']['border_color']; ?> !important;
  fill: #<?php echo $settings['light']['text']; ?> !important;
}
.ex-light:hover{
<?php if ($settings['light']['hover_gradient']) { ?>
  background: linear-gradient(<?php echo $settings['light']['hover_gradient']; ?>, #<?php echo $settings['light']['background_h']; ?>, #<?php echo $settings['light']['background2_h']; ?>) !important;
<?php } else { ?>
  background: #<?php echo $settings['light']['background_h']; ?> !important;
<?php } ?>
  color: #<?php echo $settings['light']['text_h']; ?> !important;
  border-color: #<?php echo $settings['light']['border_color_h']; ?> !important;
  fill: #<?php echo $settings['light']['text_h']; ?> !important;
}
#ex-form-review-<?php echo $uniqid;?>{
  background: #<?php echo $settings['form']['background']; ?>;
  color: #<?php echo $settings['form']['color']; ?>;
  border-radius: <?php echo $settings['form']['border-radius']; ?>px;
  border: <?php echo $settings['form']['border']; ?>px solid #<?php echo $settings['form']['border-color']; ?>;
  <?php echo (isset($settings['form']['shadow']) ? ('box-shadow: none;') : ('')); ?>
}
.review-container{
  background: #<?php echo $settings['box']['background']; ?>;
  color: #<?php echo $settings['box']['color']; ?>;
  border-radius: <?php echo $settings['box']['border-radius']; ?>px;
  border: <?php echo $settings['box']['border']; ?>px solid #<?php echo $settings['box']['border-color']; ?>;
  <?php echo (isset($settings['box']['shadow']) ? ('box-shadow: none;') : ('')); ?>
}
.review-title-container, .review-answer-title-container{
  color: #<?php echo $settings['box_header']['color']; ?>;
  font-size: <?php echo $settings['main']['font-size-name']; ?>px !important;
  line-height: <?php echo $settings['main']['font-size-name'] + 4; ?>px !important;
}
.review-title-container, .review-answer-title-container::before{
  background: #<?php echo $settings['box_header']['background']; ?>;
}
.ex-form .form-control{
  border-radius: <?php echo $settings['form']['input-border-radius']; ?>px !important;
}
#form-review-<?php echo $uniqid;?>{
  display: none !important;
}
</style>
<div style="position: absolute;	left: -9999px;">
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><symbol viewBox="0 0 512 511" id="ex-star-<?php echo $uniqid;?>"><path xmlns="http://www.w3.org/2000/svg" d="m510.652344 185.902344c-3.351563-10.367188-12.546875-17.730469-23.425782-18.710938l-147.773437-13.417968-58.433594-136.769532c-4.308593-10.023437-14.121093-16.511718-25.023437-16.511718s-20.714844 6.488281-25.023438 16.535156l-58.433594 136.746094-147.796874 13.417968c-10.859376 1.003906-20.03125 8.34375-23.402344 18.710938-3.371094 10.367187-.257813 21.738281 7.957031 28.90625l111.699219 97.960937-32.9375 145.089844c-2.410156 10.667969 1.730468 21.695313 10.582031 28.09375 4.757813 3.4375 10.324219 5.1875 15.9375 5.1875 4.839844 0 9.640625-1.304687 13.949219-3.882813l127.46875-76.183593 127.421875 76.183593c9.324219 5.609376 21.078125 5.097657 29.910156-1.304687 8.855469-6.417969 12.992187-17.449219 10.582031-28.09375l-32.9375-145.089844 111.699219-97.941406c8.214844-7.1875 11.351563-18.539063 7.980469-28.925781zm0 0"></path></symbol><symbol id="ex-photo-svg-<?php echo $uniqid;?>" viewBox="0 0 38 34"><path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.008a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.865H4A2.869 2.869 0 0 0 1.135 4.01V28A2.869 2.869 0 0 0 4 30.866h23.992A2.869 2.869 0 0 0 30.859 28V4.008v.002z"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M17 20l-5-5-7 7v-2l7-7 5 5 4-4 7 7v2l-7-7-4 4z"></path><path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path><path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path><path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M21.5 12a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5zm0-4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3z"></path><path fill-rule="evenodd" clip-rule="evenodd" d="M4 4h24v20H4V4zm1 1h22v18H5V5z"></path></symbol><symbol viewBox="0 0 38 34" id="ex-video-svg-<?php echo $uniqid;?>"><path fill-rule="evenodd" clip-rule="evenodd" d="M27.994 32H4a4 4 0 0 1-4-4V4.01a4 4 0 0 1 4-4h23.992a4 4 0 0 1 4 4V28a4 4 0 0 1-3.998 4zm2.865-27.99a2.869 2.869 0 0 0-2.865-2.867H4A2.869 2.869 0 0 0 1.135 4.01V28A2.873 2.873 0 0 0 4 30.87h23.992A2.873 2.873 0 0 0 30.857 28V4.01h.002zM24.02 26.7a64.388 64.388 0 0 1-7.958.3c-2.375 0-5.978-.06-7.362-.18-2.7-.24-2.462-3.57-2.581-6.35.001-1.427.122-2.852.36-4.26.541-2.32 2.042-2.02 4.206-2.14.23 0 1.92-.06 5.285-.06 4.983.06 6.546 0 7.926.24 2.1.3 1.925 3.63 2.044 6.19-.063 3.02-.076 4.43-.779 5.37-.276.41-.676.722-1.141.89zM11.945 15.98H7.98v1.25H9.3v7.21h1.266v-7.21h1.379c.03-.416.03-.833 0-1.25zm3.544 2.2h-1.142v4.77c-.144.28-.41.476-.719.53a.255.255 0 0 1-.3-.23v-5.07h-1.141v5.19c0 .77.243 1.19.9 1.19.504-.09.954-.369 1.26-.78v.72h1.142v-6.32zm4.387 1.01a1.052 1.052 0 0 0-1.082-1.13 2.03 2.03 0 0 0-1.142.72v-2.75h-1.141v8.47h1.141v-.66c.319.447.831.715 1.38.72.72 0 .844-1.19.844-1.19v-4.18zm4.382 3.1h-1.141v.48s0 .71-.482.71a.636.636 0 0 1-.66-.71v-1.25h2.283v-1.73a1.573 1.573 0 0 0-1.623-1.67c-1.439 0-1.558.72-1.682 1.07a2.456 2.456 0 0 0-.119.6v2.98a1.73 1.73 0 0 0 1.861 1.79 1.68 1.68 0 0 0 1.5-1.19 3.61 3.61 0 0 0 .063-1.08zm-3.92-10.61c-.318.392-.76.664-1.252.77a.826.826 0 0 1-.894-.94V6.128h1.132v5.023s-.059.3.358.3a1.05 1.05 0 0 0 .656-.54V6.128h1.131v6.263h-1.131v-.71zm-4.521.75a3.267 3.267 0 0 1-.438.01 1.536 1.536 0 0 1-1.179-.7 2.06 2.06 0 0 1-.3-.94V7.842c0-.178.059-.59.059-.59a1.65 1.65 0 0 1 1.34-1.154 1.63 1.63 0 0 1 .526 0c.637.09 1.165.54 1.352 1.156 0 0 .059.413.059.591v2.958a2.063 2.063 0 0 1-.3.94c-.249.388-.66.64-1.119.688zm-.246-5.357s-.6-.06-.6.77V10.8a.56.56 0 0 0 .6.65.526.526 0 0 0 .536-.65V7.842s.06-.769-.536-.769zm-3.277 5.258H11.1V8.96L9.494 4h1.311l.893 3.251L12.591 4h1.252l-1.549 4.961v3.37zm10.823 7.46a.685.685 0 0 0-.541-.66.672.672 0 0 0-.6.66v.77h1.142v-.77h-.001zm-4.864-.66a.863.863 0 0 0-.541.24v3.88a.76.76 0 0 0 .541.23.506.506 0 0 0 .481-.53v-3.16a.54.54 0 0 0-.481-.66z"></path><path d="M30.5 34a7.5 7.5 0 1 0 0-15 7.5 7.5 0 0 0 0 15z"></path><path d="M30.5 23a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0v-6a.5.5 0 0 1 .5-.5z" fill="#fff"></path><path d="M27.5 26h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1 0-1z" fill="#fff"></path></symbol><symbol id="ex-trash-<?php echo $uniqid;?>"  viewBox="0 0 512 512"><g><path d="m424 64h-88v-16c0-26.467-21.533-48-48-48h-64c-26.467 0-48 21.533-48 48v16h-88c-22.056 0-40 17.944-40 40v56c0 8.836 7.164 16 16 16h8.744l13.823 290.283c1.221 25.636 22.281 45.717 47.945 45.717h242.976c25.665 0 46.725-20.081 47.945-45.717l13.823-290.283h8.744c8.836 0 16-7.164 16-16v-56c0-22.056-17.944-40-40-40zm-216-16c0-8.822 7.178-16 16-16h64c8.822 0 16 7.178 16 16v16h-96zm-128 56c0-4.411 3.589-8 8-8h336c4.411 0 8 3.589 8 8v40c-4.931 0-331.567 0-352 0zm313.469 360.761c-.407 8.545-7.427 15.239-15.981 15.239h-242.976c-8.555 0-15.575-6.694-15.981-15.239l-13.751-288.761h302.44z"/><path d="m256 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z"/><path d="m336 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z"/><path d="m176 448c8.836 0 16-7.164 16-16v-208c0-8.836-7.164-16-16-16s-16 7.164-16 16v208c0 8.836 7.163 16 16 16z"/></g></symbol><symbol id="ex-thumb-<?php echo $uniqid;?>" viewBox="0, 0, 400,400" version="1.1"><g id="svgg-<?php echo $uniqid;?>"><path id="path0-<?php echo $uniqid;?>" d="M181.557 42.708 C 178.182 47.865,174.197 59.754,172.701 69.128 C 170.624 82.143,163.677 93.273,143.324 116.198 L 116.667 146.222 116.667 239.778 C 116.667 360.805,106.942 350.000,215.870 350.000 C 315.166 350.000,304.598 356.200,339.300 277.588 C 389.110 164.749,382.881 150.000,285.417 150.000 C 249.896 150.000,220.854 149.531,220.878 148.958 C 220.903 148.385,223.716 138.712,227.128 127.463 C 240.084 84.756,234.486 50.953,212.583 39.626 C 195.909 31.004,188.751 31.715,181.557 42.708 M38.333 155.000 C 31.250 162.083,31.250 337.917,38.333 345.000 C 44.802 351.469,71.865 351.469,78.333 345.000 C 85.417 337.917,85.417 162.083,78.333 155.000 C 75.583 152.250,66.583 150.000,58.333 150.000 C 50.083 150.000,41.083 152.250,38.333 155.000 " stroke="none"></path></g></symbol><symbol viewBox="0 0 57 40" id="ex-youtube-<?php echo $uniqid;?>"><path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path><path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></symbol><symbol id="ex-reply-<?php echo $uniqid;?>" viewBox="0 0 24 24"><path d="m10 7.002v-4.252c0-.301-.181-.573-.458-.691-.276-.117-.599-.058-.814.153l-8.5 8.25c-.146.141-.228.335-.228.538s.082.397.228.538l8.5 8.25c.217.21.539.269.814.153.277-.118.458-.39.458-.691v-4.25h1.418c4.636 0 8.91 2.52 11.153 6.572l.021.038c.134.244.388.39.658.39.062 0 .124-.007.186-.023.332-.085.564-.384.564-.727 0-7.774-6.257-14.114-14-14.248z"/></symbol><symbol version="1.1" id="ex-cart-<?php echo $uniqid;?>" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve"><g><path d="M394.667,0c-64,0-117.333,53.333-117.333,117.333s53.333,117.333,117.333,117.333S512,181.333,512,117.333S458.667,0,394.667,0z M467.2,83.2l-85.333,85.333c-2.133,2.133-6.4,2.133-8.533,2.133c-2.133,0-6.4,0-8.533-2.133l-42.667-42.667c-4.267-4.267-4.267-10.667,0-14.933s10.667-4.267,14.933,0l34.133,34.133l76.8-76.8c4.267-4.267,10.667-4.267,14.933,0C469.333,70.4,469.333,78.933,467.2,83.2z"/></g><g><circle cx="394.667" cy="458.667" r="53.333"/></g><g><circle cx="181.333" cy="458.667" r="53.333"/></g><g><path d="M471.467,236.8c-2.133,0-6.4,0-10.667,2.133C441.6,249.6,418.133,256,394.667,256C317.867,256,256,194.133,256,117.333c0-6.4-4.267-10.667-10.667-10.667H96L85.333,51.2c-2.133-4.267-6.4-8.533-10.667-8.533h-64C4.267,42.667,0,46.933,0,53.333C0,59.733,4.267,64,10.667,64h55.467l51.2,260.267C125.867,358.4,155.733,384,192,384h245.333c6.4,0,10.667-4.267,10.667-10.667c0-6.4-4.267-10.667-10.667-10.667H192c-17.067,0-34.133-8.533-42.667-23.467L460.8,296.533c4.267,0,8.533-4.267,8.533-8.533l6.4-40.533C475.733,243.2,475.733,238.933,471.467,236.8z"/></g></symbol><symbol id="ex-check-<?php echo $uniqid;?>" viewBox="0 0 512 512"><g><path d="m256 0c-141.49 0-256 114.5-256 256 0 141.49 114.5 256 256 256 141.49 0 256-114.5 256-256 0-141.49-114.5-256-256-256zm-60.914 363.99s-88.422-88.458-94.778-94.802c-14.139-14.139-14.139-37.147 0-51.274 14.175-14.175 37.099-14.175 51.274 0l57.244 57.244c7.118 7.118 18.67 7.069 25.728-.085l125.69-127.502c14.127-14.332 37.208-14.429 51.455-.181 14.03 14.03 14.115 36.942.181 51.081-136.493 138.486-162.414 165.507-162.414 165.507-14.985 14.984-39.383 14.997-54.38.012z"/></g></symbol><symbol id="ex-pencil-<?php echo $uniqid;?>" viewBox="0 0 469.336 469.336"><g><g><g><path d="M347.878,151.357c-4-4.003-11.083-4.003-15.083,0L129.909,354.414c-2.427,2.429-3.531,5.87-2.99,9.258     c0.552,3.388,2.698,6.307,5.76,7.84l16.656,8.34v28.049l-51.031,14.602l-51.51-51.554l14.59-51.075h28.025l8.333,16.67     c1.531,3.065,4.448,5.213,7.833,5.765c0.573,0.094,1.146,0.135,1.708,0.135c2.802,0,5.531-1.105,7.542-3.128L317.711,136.26     c2-2.002,3.125-4.712,3.125-7.548c0-2.836-1.125-5.546-3.125-7.548l-39.229-39.263c-2-2.002-4.708-3.128-7.542-3.128h-0.021     c-2.844,0.01-5.563,1.147-7.552,3.159L45.763,301.682c-0.105,0.107-0.1,0.27-0.201,0.379c-1.095,1.183-2.009,2.549-2.487,4.208     l-18.521,64.857L0.409,455.73c-1.063,3.722-0.021,7.736,2.719,10.478c2.031,2.033,4.75,3.128,7.542,3.128     c0.979,0,1.958-0.136,2.927-0.407l84.531-24.166l64.802-18.537c0.195-0.056,0.329-0.203,0.52-0.27     c0.673-0.232,1.262-0.61,1.881-0.976c0.608-0.361,1.216-0.682,1.73-1.146c0.138-0.122,0.319-0.167,0.452-0.298l219.563-217.789     c2.01-1.991,3.146-4.712,3.156-7.558c0.01-2.836-1.115-5.557-3.125-7.569L347.878,151.357z"/><path d="M456.836,76.168l-64-64.054c-16.125-16.139-44.177-16.17-60.365,0.031l-39.073,39.461     c-4.135,4.181-4.125,10.905,0.031,15.065l108.896,108.988c2.083,2.085,4.813,3.128,7.542,3.128c2.719,0,5.427-1.032,7.51-3.096     l39.458-39.137c8.063-8.069,12.5-18.787,12.5-30.192S464.899,84.237,456.836,76.168z"/></g></g></g></symbol><symbol viewBox="0 0 19 21" id="ex-more-<?php echo $uniqid;?>" ><path fill-rule="evenodd" clip-rule="evenodd" d="M8.827.118c-.27-.203-.74-.135-.943.134-.202.27-.202.741.135.943l1.14.874a9.134 9.134 0 00-3.363.743c-2.29 1.01-4.11 2.83-5.052 5.187-.943 2.358-.876 4.917.067 7.208a9.106 9.106 0 002.83 3.705c.201.202.336.202.47.202.203 0 .405-.068.54-.27.202-.27.202-.74-.135-.943-1.078-.808-1.886-1.953-2.425-3.166-.876-1.953-.876-4.176-.068-6.197.809-2.021 2.358-3.57 4.312-4.446 1.024-.41 2.086-.664 3.188-.673L8.49 4.766c-.202.269-.202.74.135.943.067.067.202.067.337.067.202 0 .404-.067.539-.27l1.953-2.56c.202-.269.202-.74-.134-.942L8.827.118zm9.364 7.814c-.135-.337-.54-.472-.876-.337-.337.135-.472.539-.337.876.135.269.27.606.337.943.067.202.337.404.606.404h.202c.337-.135.54-.472.472-.809-.135-.404-.27-.74-.404-1.077zm-.607 3.974c0 .539-.134 1.078-.27 1.617-.066.337.136.74.473.808.067.135.134.135.202.135.269 0 .538-.202.673-.472.135-.606.27-1.28.27-1.953a.733.733 0 00-.607-.741.79.79 0 00-.74.606zm-3.166 6.063c.741-.54 1.348-1.213 1.886-2.021.203-.337.607-.405.944-.202.336.202.404.606.202.943a10.516 10.516 0 01-2.223 2.357c-.135.068-.27.135-.405.135-.202 0-.404-.067-.538-.27-.203-.269-.135-.74.134-.942zm-7.342 1.28c-.337-.135-.741.067-.876.471-.135.404.067.741.472.876.943.27 1.886.404 2.829.404a9.45 9.45 0 002.762-.404c.337-.135.539-.472.471-.876-.134-.337-.471-.539-.876-.471a8.263 8.263 0 01-4.782 0z"></path></symbol><symbol viewBox="0 0 16 16" id="ex-sort-<?php echo $uniqid;?>"><path d="M3.931 1.61v-.241l.17.17 1.747 1.74a.525.525 0 00.743-.002l.07.07-.07-.07a.525.525 0 00-.002-.743l.07-.07-.07.07L4.667.62A1.762 1.762 0 003.412.1c-.474 0-.92.184-1.255.52L.253 2.536l-.071-.07.07.07a.525.525 0 00.745.74l.07.07-.07-.07L2.71 1.553l.171-.172V14.6l-.17-.17-1.715-1.708a.523.523 0 00-.743.001.525.525 0 00.001.743l-.07.07.07-.07 1.923 1.915c.335.335.78.519 1.254.519.475 0 .92-.184 1.255-.52l1.905-1.916.071.07-.07-.07a.525.525 0 10-.746-.74l-1.744 1.755-.17.171V1.61zm11.444 9.553h-6.25a.525.525 0 100 1.05h6.25a.525.525 0 100-1.05zm0-6.325a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0 3.687a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0 7.375a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25zm0-14.75a.525.525 0 100-1.05h-6.25a.525.525 0 100 1.05h6.25z"></path></symbol>
</svg>
</div>
