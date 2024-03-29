	<?php if ( !empty($reviews)) { ?>
	<div class="ex-reviews__carousel" id="ex-reviews-carousel<?php echo $module; ?>">
		<div class="<?php echo $settings['box_classname']; ?>">
			<div class="ex-reviews__head">
				<h2 class="ex-reviews__heading <?php echo $settings['title_classname']; ?>"><?php echo $heading_title; ?></h2>
			</div>
			<div class="ex-reviews__carousel-container">
				<?php foreach($reviews as $_key => $review) { ?> 
				<div class="ex-reviews__carousel-item <?php echo $settings['card_classname']; ?>">
					<div class="ex-reviews__item-image"><a class="ex-reviews__image-link"
							href="<?php echo $review['prod_href']; ?>"><img src="<?php echo $review['prod_thumb']; ?>" alt=""></a></div>
					<div class="ex-reviews__item-body ex-review-body<?php echo $review['review_id']; ?>">
						<div class="ex-reviews__item-title"><a
								href="<?php echo $review['prod_href']; ?>"><?php echo $review['prod_name']; ?></a></div>
								<div class="carousel-rating-container">
									<div class="rating-background">
									<?php if ($review['rating'] != 0) { ?>
									<?php $i = 1; ?>
									<?php foreach(range($i, 5) as $_key => $i) { ?> 
									<?php if ($review['rating'] < $i) { ?>
									<svg class="ex-star ex-star-grey">
										<use xlink:href="#ex-star"></use>
									</svg>
									<?php } else { ?>
									<svg class="ex-star">
										<use xlink:href="#ex-star"></use>
									</svg>
									<?php } ?>
									<?php } ?>
									<?php } ?>
								</div>
								</div>
						<div class="ex-reviews__item-text"><?php echo $review['text']; ?></div><a class="reviews__item-link"
							href="<?php echo $review['review_href']; ?>"><?php echo $text_more; ?></a>
						<?php if (($review['images'] || $review['videos'])) { ?>
						<div class="review-media-container">
							<?php if ( !empty($review['images'])) { ?>
							<div class="ex-reviews__thumbneils">
								<?php foreach($review['images'] as $_key => $image) { ?> 
								<div class="ex-reviews__photo"><a class="ex-thumbnail"
										<?php echo (($settings['gallery_type'] == 2) ? ('data-fancybox="carousel-gallery"') : ('')); ?>
										href="<?php echo $image['popup']; ?>" title="<?php echo $review['prod_name']; ?>"> <img
											src="<?php echo $image['thumb']; ?>" title="<?php echo $review['prod_name']; ?>"
											alt="<?php echo $review['prod_name']; ?>"
											class="<?php echo (($image['type'] == '0') ? ('image-crop') : ('imgbb')); ?>" /></a>
								</div>
								<?php } ?>
							</div>
							<?php } ?>
							<?php if ( !empty($review['videos'])) { ?>
							<div class="ex-reviews__thumbneils">
								<?php foreach($review['videos'] as $_key => $video) { ?> 
								<div class="ex-reviews__video"><a
										<?php echo (($settings['gallery_type'] == 2) ? ('data-fancybox') : ('')); ?> class="popup-youtube"
										href="https://www.youtube.com/watch?v=<?php echo $video; ?>?autoplay=1&rel=0"><img
											src="//img.youtube.com/vi/<?php echo $video; ?>/mqdefault.jpg" alt=""
											class="youtube-click"><svg class="ex-youtube-svg">
											<use xlink:href="#ex-youtube"></use>
										</svg></a></div>
								<?php } ?>
							</div>
							<?php } ?>
						</div>
						<?php } ?>
					</div>
					<div class="review-footer-container">
						<div class="review-author">
							<?php if ($review['purchased']) { ?>
								<span class='allready-buy' title='<?php echo $text_buy; ?>' data-toggle="tooltip"><svg class="ex-cart-svg">
										<use xlink:href="#ex-cart"></use>
									</svg></span>
								<?php } ?>
							<span class="review-author-name"><?php echo $review['author']; ?></span>
						</div>
						<div class="review-rating-change-buttons">
							<button class="review-vote review-vote-positive" data-value="<?php echo $review['review_id']; ?>">
								<svg class="ex-like">
									<use xlink:href="#ex-thumb"></use>
								</svg>
								<span class="review-vote-count vote_count_positive-<?php echo $review['review_id']; ?>"
									data-value="<?php echo $review['likes']; ?>"><?php echo (($review['likes'] > 0) ? ($review['likes']) : ('0')); ?></span>
							</button>
							<button class="review-vote review-vote-negative" data-value="<?php echo $review['review_id']; ?>">
								<svg class="ex-like ex-dislike">
									<use xlink:href="#ex-thumb"></use>
								</svg>
								<span class="review-vote-count vote_count_negative-<?php echo $review['review_id']; ?>"
									data-value="<?php echo $review['dislikes']; ?>"><?php echo (($review['dislikes'] > 0) ? ($review['dislikes']) : ('0')); ?></span>
							</button>
						</div>
					</div>
				</div>
				<?php } ?>
			</div>
			<a href="<?php echo $all_reviews_link; ?>" type="button" class="ex-carousel-btn"><?php echo $text_all; ?><svg
					class="ex-arrow-right">
					<use href="#ex-arrow"></use>
				</svg></a>
		</div>
	</div>
<script type="text/javascript"><!--
<?php if ($settings['gallery_type'] == 1) { ?>
	addMagnific('.ex-reviews__thumbneils');
	addMagnificVideo('.popup-youtube');
<?php } ?>
$(document).on('click', '.review-vote-negative', function() {
  alertRemove()
  var id = $(this).data("value");
  var votename = "vote"+id;
  var note_block = $(".ex-review-body"+id);
  if(localStorage.getItem(votename) == null){
  var vote_count_span = $('.vote_count_negative-'+id);
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

		$(note_block).after('<div class="ex-alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; ' + json['success'] + '</div>');

      } else if(json['login']) {

		$(note_block).after('<div class="ex-alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; ' + json['login'] + '</div>');

		}
      }
    });
  }
  else{
    $(note_block).after('<div class="ex-alert alert-warning m-0"><?php echo $already_rating; ?></div>');
  }
});
$(document).on('click', '.review-vote-positive', function() {
  alertRemove()
  var id = $(this).data("value");
  var votename = "vote"+id;
  var note_block = $(".ex-review-body"+id);
  if(localStorage.getItem(votename) == null){
  var vote_count_span = $('.vote_count_positive-'+id);
  var vote_count = parseInt(vote_count_span.data("value"));
    $.ajax({
		url: 'index.php?route=product/extended_reviews/plusReviewRating',
		type: 'post',
		data: { review_id : id } ,
		dataType: 'json',
		success: function(json) {
			if (json['success']) {

				$(vote_count_span).text(vote_count + 1);
				
				localStorage.setItem(votename , true);

				$(note_block).after('<div class="ex-alert alert-success m-0"><i class="fa fa-check" aria-hidden="true"></i>&nbsp; ' + json['success'] + '</div>');

			} else if(json['login']) {

				console.log(json['login']);

				$(note_block).after('<div class="ex-alert alert-info m-0"><i class="fa fa-exclamation" aria-hidden="true"></i>&nbsp; ' + json['login'] + '</div>');

			}
		}
    });
  }
  else{
      $(note_block).after('<div class="ex-alert alert-warning m-0"><?php echo $already_rating; ?></div>');
  }
});
--></script>
<style type="text/css">
.ex-reviews__carousel-container{
	justify-content: center;
}
.ex-reviews__photo a{
  height: <?php echo $thumb_settings['thumb_height']; ?>px !important;
  width: <?php echo $thumb_settings['thumb_width']; ?>px !important;
  border-radius: <?php echo $thumb_settings['border_radius_photo']; ?>px !important;
}
.ex-reviews__photo a .image-crop{
  height: <?php echo ($thumb_settings['thumb_height'] * 1.8); ?>px !important;
  width: <?php echo ($thumb_settings['thumb_width'] * 1.8); ?>px !important;
}
.ex-reviews__photo .imgbb{
  height: <?php echo $thumb_settings['thumb_height']; ?>px !important;
  width: <?php echo $thumb_settings['thumb_width']; ?>px !important;
}
.ex-reviews__video img{
  height: <?php echo $thumb_settings['video_thumb_height']; ?>px !important;
  width: <?php echo $thumb_settings['video_thumb_width']; ?>px !important;
}
.ex-reviews__video a{
  height: <?php echo $thumb_settings['video_thumb_height']; ?>px !important;
  width: <?php echo $thumb_settings['video_thumb_width']; ?>px !important;
  border-radius: <?php echo $thumb_settings['border_radius_video']; ?>px !important;
}
.ex-reviews__carousel-item{
  <?php echo (isset($style['shadow']) ? ('box-shadow: 1px 1px 3px #c3c3c3;') : ('')); ?>
}
<?php if (isset($style['status'])) { ?>
.ex-reviews__carousel-item{
  margin-right: 10px;
  margin-bottom: 15px;
  flex: 1 0 320px;
  position: relative;
  background: #<?php echo $style['box']['background']; ?>;
  color: #<?php echo $style['box']['color']; ?>;
  border-radius: <?php echo $style['box']['border-radius']; ?>px;
  border: <?php echo $style['box']['border']; ?>px solid #<?php echo $style['box']['border-color']; ?>;
  font-size: <?php echo $style['box']['font-size']; ?>px;
}
.ex-reviews__carousel a{
	color: #<?php echo $style['box']['link-color']; ?>;
}
.ex-reviews__carousel a:hover{
	color: #<?php echo $style['box']['link-hover-color']; ?>;
}
.review-footer-container{
  color: #<?php echo $style['box_footer']['color']; ?>;
  background: #<?php echo $style['box_footer']['background']; ?>;
}
.ex-reviews__carousel-item{
	margin-right: <?php echo $style['box']['margin']; ?>px;
}
.rating-background{
	background: #<?php echo $style['box']['background']; ?>;
}
<?php } ?>
</style>
<div style="position: absolute;	left: -9999px;">
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><symbol viewBox="0 0 512 511" id="ex-star"><path xmlns="http://www.w3.org/2000/svg" d="m510.652344 185.902344c-3.351563-10.367188-12.546875-17.730469-23.425782-18.710938l-147.773437-13.417968-58.433594-136.769532c-4.308593-10.023437-14.121093-16.511718-25.023437-16.511718s-20.714844 6.488281-25.023438 16.535156l-58.433594 136.746094-147.796874 13.417968c-10.859376 1.003906-20.03125 8.34375-23.402344 18.710938-3.371094 10.367187-.257813 21.738281 7.957031 28.90625l111.699219 97.960937-32.9375 145.089844c-2.410156 10.667969 1.730468 21.695313 10.582031 28.09375 4.757813 3.4375 10.324219 5.1875 15.9375 5.1875 4.839844 0 9.640625-1.304687 13.949219-3.882813l127.46875-76.183593 127.421875 76.183593c9.324219 5.609376 21.078125 5.097657 29.910156-1.304687 8.855469-6.417969 12.992187-17.449219 10.582031-28.09375l-32.9375-145.089844 111.699219-97.941406c8.214844-7.1875 11.351563-18.539063 7.980469-28.925781zm0 0"></path></symbol><symbol id="ex-thumb" viewBox="0, 0, 400,400" version="1.1"><g id="svgg"><path id="path0" d="M181.557 42.708 C 178.182 47.865,174.197 59.754,172.701 69.128 C 170.624 82.143,163.677 93.273,143.324 116.198 L 116.667 146.222 116.667 239.778 C 116.667 360.805,106.942 350.000,215.870 350.000 C 315.166 350.000,304.598 356.200,339.300 277.588 C 389.110 164.749,382.881 150.000,285.417 150.000 C 249.896 150.000,220.854 149.531,220.878 148.958 C 220.903 148.385,223.716 138.712,227.128 127.463 C 240.084 84.756,234.486 50.953,212.583 39.626 C 195.909 31.004,188.751 31.715,181.557 42.708 M38.333 155.000 C 31.250 162.083,31.250 337.917,38.333 345.000 C 44.802 351.469,71.865 351.469,78.333 345.000 C 85.417 337.917,85.417 162.083,78.333 155.000 C 75.583 152.250,66.583 150.000,58.333 150.000 C 50.083 150.000,41.083 152.250,38.333 155.000 " stroke="none"></path></g></symbol><symbol viewBox="0 0 57 40" id="ex-youtube"><path fill= "#ff1818" d="M28.537 0C21.938 0 15.326.2 8.715.6 1.702 1 .701 6.5.301 11.9c-.4 5.4-.4 10.8 0 16.2S1.702 39 8.715 39.4c13.123.8 26.347.8 39.57 0 7.012-.4 8.014-5.9 8.414-11.3.4-5.4.4-10.8 0-16.2-.4-5.4-1.402-10.9-8.414-11.3C41.724.2 35.135 0 28.537 0zm-6.098 11l16.329 8.5L22.439 28V11z"></path><path fill="#fff" d="M22.439 11.002l16.3 8.5-16.3 8.5v-17z"></path></symbol><symbol version="1.1" id="ex-cart" x="0px" y="0px" viewBox="0 0 512 512" style="enable-background:new 0 0 512 512;" xml:space="preserve"><g><path d="M394.667,0c-64,0-117.333,53.333-117.333,117.333s53.333,117.333,117.333,117.333S512,181.333,512,117.333S458.667,0,394.667,0z M467.2,83.2l-85.333,85.333c-2.133,2.133-6.4,2.133-8.533,2.133c-2.133,0-6.4,0-8.533-2.133l-42.667-42.667c-4.267-4.267-4.267-10.667,0-14.933s10.667-4.267,14.933,0l34.133,34.133l76.8-76.8c4.267-4.267,10.667-4.267,14.933,0C469.333,70.4,469.333,78.933,467.2,83.2z"/></g><g><circle cx="394.667" cy="458.667" r="53.333"/></g><g><circle cx="181.333" cy="458.667" r="53.333"/></g><g><path d="M471.467,236.8c-2.133,0-6.4,0-10.667,2.133C441.6,249.6,418.133,256,394.667,256C317.867,256,256,194.133,256,117.333c0-6.4-4.267-10.667-10.667-10.667H96L85.333,51.2c-2.133-4.267-6.4-8.533-10.667-8.533h-64C4.267,42.667,0,46.933,0,53.333C0,59.733,4.267,64,10.667,64h55.467l51.2,260.267C125.867,358.4,155.733,384,192,384h245.333c6.4,0,10.667-4.267,10.667-10.667c0-6.4-4.267-10.667-10.667-10.667H192c-17.067,0-34.133-8.533-42.667-23.467L460.8,296.533c4.267,0,8.533-4.267,8.533-8.533l6.4-40.533C475.733,243.2,475.733,238.933,471.467,236.8z"/></g></symbol><symbol viewBox="0 0 268.832 268.832" id="ex-arrow"><g><path d="M265.171,125.577l-80-80c-4.881-4.881-12.797-4.881-17.678,0c-4.882,4.882-4.882,12.796,0,17.678l58.661,58.661H12.5   c-6.903,0-12.5,5.597-12.5,12.5c0,6.902,5.597,12.5,12.5,12.5h213.654l-58.659,58.661c-4.882,4.882-4.882,12.796,0,17.678   c2.44,2.439,5.64,3.661,8.839,3.661s6.398-1.222,8.839-3.661l79.998-80C270.053,138.373,270.053,130.459,265.171,125.577z"/></g></symbol></svg>
</div>
<?php } ?>