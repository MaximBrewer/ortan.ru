
    <div class="faq__col">
      <div class="review__summary">
      <div class="flex-vc">
        <div class="review__summary__value">
         
        <?= $review_total_all_text; ?>   </div>
        <div class="review__stars review__stars--big">
          <div class="review__stars__bg" style="width: 91.662%"></div>
        </div>
        <div class="review__btn-box">
        <a class="btn review__btn" href="/otzyvy/">ПОСМОТРЕТЬ ОТЗЫВЫ</a>
        </div>
      </div>
      <div class="review__description">
        На основании  оценок
      </div>
      <div class="review__stat">
        <a class="flex-vc" href="/otzyvy/?rating=5">
          <label>
              <input type="checkbox" class="filter__input" autocomplete="off" data-value="5">
            <span class="filter__check"></span>
            
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 100%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_5 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
           
          <?= $review_total_5; ?>     </div>
        </a>

        <a class="flex-vc" href="/otzyvy/?rating=4">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="4">
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 80%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_4 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
           
          <?= $review_total_4; ?>       </div>
        </a>

        <a class="flex-vc" href="/otzyvy/?rating=3">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="3">
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 60%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_3 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
          
          <?= $review_total_3; ?>        </div>
        </a>

        <a class="flex-vc" href="/otzyvy/?rating=2">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="2">
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 40%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_2 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
           
          <?= $review_total_2; ?>     </div>
        </a>

        <a class="flex-vc" href="/otzyvy/?rating=2">
          <label>
            <input type="checkbox" class="filter__input" autocomplete="off" data-value="1">
            <span class="filter__check"></span>
          </label>
          <div class="review__stars">
            <div class="review__stars__bg" style="width: 20%;"></div>
          </div>
          <div class="review__stat__line">
            <div class="review__stat__line__bg" style="width: <?= 100 * $review_total_1 / $review_total_all; ?>%"></div>
          </div>
          <div class="review__stat__value">
           
          <?= $review_total_1; ?>       </div>
        </a>

      </div>
    </div>
    </div>