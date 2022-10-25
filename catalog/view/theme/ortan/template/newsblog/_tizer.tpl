 <a href="<?php echo $article['href']; ?>">
     <div>
         <div class="blog__item__top">
             <div class="blog__item__author"><?php echo $article['author']; ?></div>
             <div class="blog__item__date"><?php echo $article['date']; ?></div>
         </div>
         <h4 class="blog__item__title"><?php echo $article['name']; ?></h4>
         <div class="blog__item__img">
             <?php if ($article['thumb']) : ?>
                 <img src="<?php echo $article['thumb']; ?>" alt="">
             <?php else : ?>
                 <div class="blog__item__img__empty">
                     <div>
                         <img src="/catalog/view/theme/ortan/assets/images/blog/blog-logo.svg" alt="">
                         <span>Нет изображения</span>
                     </div>
                 </div>
             <?php endif; ?>
         </div>
         <div class="blog__item__desc"><?php echo $article['preview']; ?></div>
     </div>
     <div class="blog__item__bottom">
         <span class="blog__item__reviews"><?php echo $article['viewed']; ?></span>
         <span class="blog__item__comments"><?php echo $article['comments']; ?></span>
         <div class="blog__item__bottom__right">
             <button class="blog__item__btn" type="button">Подробнее</button>
         </div>
     </div>
 </a>