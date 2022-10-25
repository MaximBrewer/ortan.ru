<div class="search__wrapper" id="search">
  <form action="/" method="GET" class="header__search search">
    <input type="hidden" name="route" value="product/search" />
    <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>" class="search__input">
    <button class="search__btn btn btn_red">ПОИСК</button>
  </form>
</div>