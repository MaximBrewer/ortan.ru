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

<section class="authorization authorization_profile">
  <div class="authorization__container container">
    <h1 class="authorization__heading innerHeading">мой профиль</h1>
    <div class="authorization_prof">
      <div class="authorization__forms">

        <form action="#" class="authForm profile__part  active">
          <div class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">личные данные</p>
            <p class="authForm__input">
              <label for="authForm__name" class="authForm__label">ФИО<span class="authForm__requireStar">*</span></label>
              <input id="authForm__name" placeholder="Александров Александр Александрович" name="name" type="text" class="input">
              <span class="authForm__error">Имя не найдено</span>
            </p>
            <p class="authForm__input">
              <label for="authForm__tel" class="authForm__label">Телефон<span class="authForm__requireStar">*</span></label>
              <input id="authForm__tel" placeholder="8 800 200 50 00" name="phone" type="text" class="input">
              <span class="authForm__error">Неверный номер</span>
            </p>
            <p class="authForm__input">
              <label for="authForm__email" class="authForm__label">E-mail<span class="authForm__requireStar">*</span></label>
              <input id="authForm__email" placeholder="александр89@gmail,com" name="phone" type="text" class="input">
              <span class="authForm__error">E-mail не найден</span>
            </p>
            <button class="authForm__submit btn btn_red">сохранить изменения</button>
          </div>
        </form>

        <form id="address" action="#" class="authForm profile__part">
          <div class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">адрес доставки</p>
            <p class="authForm__input">
              <label for="authForm__region" class="authForm__label">Регион <span class="authForm__requireStar">*</span></label>
              <input id="authForm__region" placeholder="Московская область" name="region" type="text" class="input">
              <span class="authForm__error">Не выбран регион </span>
            </p>
            <p class="authForm__input">
              <label for="authForm__city" class="authForm__label">Город<span class="authForm__requireStar">*</span></label>
              <input id="authForm__city" placeholder="Москва" name="city" type="text" class="input">
              <span class="authForm__error">Не выбран город</span>
            </p>
            <p class="authForm__input">
              <label for="authForm__address" class="authForm__label">Адрес (улица, дом, квартра, код / домофон)<span class="authForm__requireStar">*</span></label>
              <input id="authForm__address" placeholder="Власова, 13, 24, 132" name="address" type="text" class="input">
              <span class="authForm__error">Не указан адрес</span>
            </p>
            <button class="authForm__submit btn btn_red">сохранить изменения</button>
          </div>
        </form>

        <div class="history profile__part">
          <ul class="history__list">
            <li class="history__item history__item_head">
              <span class="history__name history__name_top">Номер заказа</span>
              <span class="history__name history__name_top">Кол-во товара</span>
              <span class="history__name history__name_top">Статус заказа</span>
              <span class="history__name history__name_top">Итого</span>
              <span class="history__name history__name_top">Добавлено</span>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00001 </span>
              <span class="history__name history__name_data">2 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">62 348 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00064 </span>
              <span class="history__name history__name_data">1 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">1 174 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00097 </span>
              <span class="history__name history__name_data">1 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">374 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00121 </span>
              <span class="history__name history__name_data">2 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">628 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00221 </span>
              <span class="history__name history__name_data">2 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">31 174 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00287 </span>
              <span class="history__name history__name_data">3 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">62 348 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00376 </span>
              <span class="history__name history__name_data">7 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">31 174 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00835 </span>
              <span class="history__name history__name_data">1 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">3 174 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00896 </span>
              <span class="history__name history__name_data">1 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">31 174 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
            <li class="history__item history__item_info">
              <span class="history__name history__name_data"># 00959 </span>
              <span class="history__name history__name_data">2 шт.</span>
              <span class="history__name history__name_data">Завершен</span>
              <span class="history__name history__name_data">6 348 ₽</span>
              <span class="history__name history__name_data">05.02.2021</span>
              <a href="#" class="history__name history__name_data">Подробнее</a>
            </li>
          </ul>
          <div class="goodsin__pagination">
            <svg class="goodsin__arrow goodsin__arrow_prev" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M0.252064 6.2802C0.252322 6.28045 0.252537 6.28076 0.252839 6.28101L4.74324 10.7498C5.07964 11.0845 5.62376 11.0833 5.95861 10.7468C6.29342 10.4104 6.29214 9.86632 5.95573 9.53151L2.94087 6.53126L21.1406 6.53126C21.6153 6.53126 22 6.14652 22 5.67189C22 5.19726 21.6153 4.81252 21.1406 4.81252L2.94092 4.81252L5.95569 1.81227C6.29209 1.47746 6.29338 0.933351 5.95857 0.59695C5.62372 0.260462 5.07956 0.259303 4.7432 0.594028L0.252795 5.06277C0.252537 5.06302 0.252322 5.06332 0.25202 5.06358C-0.0845523 5.39951 -0.0834785 5.94538 0.252064 6.2802Z" fill="#323031" />
            </svg>
            <ul class="goodsin__pages">
              <li class="goodsin__page active">1</li>
              <li class="goodsin__page"><a href="#">2</a></li>
              <li class="goodsin__page"><a href="#">3</a></li>
              <li class="goodsin__page"><a href="#">4</a></li>
              <li class="goodsin__page"><a href="#">5</a></li>
            </ul>
            <svg class="goodsin__arrow goodsin__arrow_next" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M21.7479 4.7198C21.7477 4.71954 21.7475 4.71924 21.7472 4.71899L17.2568 0.250247C16.9204 -0.0845221 16.3762 -0.0832763 16.0414 0.253168C15.7066 0.58957 15.7079 1.13368 16.0443 1.46849L19.0591 4.46874L0.859375 4.46874C0.384742 4.46874 0 4.85348 0 5.32811C0 5.80274 0.384742 6.18748 0.859375 6.18748L19.0591 6.18748L16.0443 9.18772C15.7079 9.52254 15.7066 10.0666 16.0414 10.403C16.3763 10.7395 16.9204 10.7407 17.2568 10.406L21.7472 5.93723C21.7475 5.93697 21.7477 5.93667 21.748 5.93642C22.0846 5.60049 22.0835 5.05461 21.7479 4.7198Z" fill="#323031" />
            </svg>
          </div>
        </div>

        <div class="favorites catalog__goods goodsin profile__part">
          <ul class="goodsin__list">
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
            <li class="goodsin__wrapper">
              <div class="goodsin__inem productin">
                <div class="goodsin__close">
                  <img src="assets/images/icon-close.svg" alt="remove from like">
                </div>
                <a href="product-single.html" class="product__imgWrapper">
                  <img src="assets/images/bestseller1.png" alt="product image" class="product__img">
                  <div class="product__openFancy btn btn_red"></div>
                </a>
                <div class="product__info">
                  <span class="product__price">31 174 ₽</span>
                  <span class="product__has">В наличии</span>
                </div>
                <span class="product__oldPrice">45 990 ₽</span>
                <a href="#" class="product__nameBox" title="<?php echo $product['name']; ?>">
                  <h4 class="product__name">Шлем для мотоцикла</h4>
                  <span class="pruduct__about">Shark Drak (черный-золотой)</span>
                </a>
                <button class="pruduct__add btn">ДОБАВИТЬ В КОРЗИНУ</button>
              </div>
            </li>
          </ul>
          <div class="goodsin__pagination">
            <svg class="goodsin__arrow goodsin__arrow_prev" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M0.252064 6.2802C0.252322 6.28045 0.252537 6.28076 0.252839 6.28101L4.74324 10.7498C5.07964 11.0845 5.62376 11.0833 5.95861 10.7468C6.29342 10.4104 6.29214 9.86632 5.95573 9.53151L2.94087 6.53126L21.1406 6.53126C21.6153 6.53126 22 6.14652 22 5.67189C22 5.19726 21.6153 4.81252 21.1406 4.81252L2.94092 4.81252L5.95569 1.81227C6.29209 1.47746 6.29338 0.933351 5.95857 0.59695C5.62372 0.260462 5.07956 0.259303 4.7432 0.594028L0.252795 5.06277C0.252537 5.06302 0.252322 5.06332 0.25202 5.06358C-0.0845523 5.39951 -0.0834785 5.94538 0.252064 6.2802Z" fill="#323031" />
            </svg>
            <ul class="goodsin__pages">
              <li class="goodsin__page active">1</li>
              <li class="goodsin__page"><a href="#">2</a></li>
              <li class="goodsin__page"><a href="#">3</a></li>
              <li class="goodsin__page"><a href="#">4</a></li>
              <li class="goodsin__page"><a href="#">5</a></li>
            </ul>
            <svg class="goodsin__arrow goodsin__arrow_next" width="22" height="11" viewBox="0 0 22 11" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M21.7479 4.7198C21.7477 4.71954 21.7475 4.71924 21.7472 4.71899L17.2568 0.250247C16.9204 -0.0845221 16.3762 -0.0832763 16.0414 0.253168C15.7066 0.58957 15.7079 1.13368 16.0443 1.46849L19.0591 4.46874L0.859375 4.46874C0.384742 4.46874 0 4.85348 0 5.32811C0 5.80274 0.384742 6.18748 0.859375 6.18748L19.0591 6.18748L16.0443 9.18772C15.7079 9.52254 15.7066 10.0666 16.0414 10.403C16.3763 10.7395 16.9204 10.7407 17.2568 10.406L21.7472 5.93723C21.7475 5.93697 21.7477 5.93667 21.748 5.93642C22.0846 5.60049 22.0835 5.05461 21.7479 4.7198Z" fill="#323031" />
            </svg>
          </div>
        </div>

        <form action="#" class="authForm profile__part">
          <div class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">изменить пароль</p>
            <p class="authForm__input">
              <label for="authForm__password" class="authForm__label">Пароль <span class="authForm__requireStar">*</span></label>
              <input id="authForm__password" placeholder="Московская область" name="password" type="password" class="input">
              <span class="authForm__error">Неверный пароль</span>
            </p>
            <p class="authForm__input">
              <label for="authForm__doublePassword" class="authForm__label">Пароль<span class="authForm__requireStar">*</span></label>
              <input id="authForm__doublePassword" placeholder="Москва" name="doublePassword" type="password" class="input">
              <span class="authForm__error">Пароли не совпадают</span>
            </p>
            <button class="authForm__submit btn btn_red">сохранить изменения</button>
          </div>
        </form>

        <form action="#" class="authForm profile__part">
          <div class="authForm__wrapper authForm__wrapper_bg">
            <p class="authForm__head">Выйти из профиля?</p>

            <button class="authForm__submit btn btn_red">Выйти</button>
          </div>
        </form>

      </div>

      <div class="authForm__menu">
        <div class="authForm__userMenu">
          <svg id="Layer_1" enable-background="new 0 0 24 24" height="30" viewBox="0 0 24 24" width="30" xmlns="http://www.w3.org/2000/svg">
            <g>
              <path d="m9 10c-2.757 0-5-2.243-5-5s2.243-5 5-5 5 2.243 5 5-2.243 5-5 5zm0-9c-2.206 0-4 1.794-4 4s1.794 4 4 4 4-1.794 4-4-1.794-4-4-4z" />
            </g>
            <g>
              <path d="m8.5 21h-8c-.276 0-.5-.224-.5-.5v-4c0-2.481 2.019-4.5 4.5-4.5h6c.276 0 .5.224.5.5s-.224.5-.5.5h-6c-1.93 0-3.5 1.57-3.5 3.5v3.5h7.5c.276 0 .5.224.5.5s-.224.5-.5.5z" />
            </g>
            <g>
              <g>
                <path d="m17 20c-1.378 0-2.5-1.122-2.5-2.5s1.122-2.5 2.5-2.5 2.5 1.122 2.5 2.5-1.122 2.5-2.5 2.5zm0-4c-.827 0-1.5.673-1.5 1.5s.673 1.5 1.5 1.5 1.5-.673 1.5-1.5-.673-1.5-1.5-1.5z" />
              </g>
              <g>
                <path d="m17.797 24h-1.595c-.516 0-.944-.387-.995-.901l-.127-1.271c-.303-.135-.592-.303-.865-.503l-1.168.527c-.469.214-1.02.035-1.277-.412l-.797-1.381c-.258-.447-.136-1.011.282-1.312l1.029-.74c-.02-.155-.034-.327-.034-.507s.014-.353.034-.507l-1.029-.74c-.418-.301-.54-.865-.282-1.312l.797-1.381c.258-.447.806-.624 1.277-.412l1.168.527c.273-.2.562-.368.865-.503l.127-1.271c.051-.513.479-.9.995-.9h1.595c.516 0 .944.387.995.901l.127 1.271c.304.135.593.304.865.503l1.168-.527c.471-.211 1.02-.034 1.277.412l.797 1.381c.258.447.136 1.011-.282 1.312l-1.029.74c.02.155.034.327.034.507s-.014.353-.034.507l1.029.74c.418.301.54.865.282 1.312l-.796 1.38c-.258.446-.805.625-1.277.412l-1.168-.527c-.273.2-.562.368-.865.503l-.128 1.272c-.051.513-.479.9-.995.9zm-3.512-3.755c.115 0 .229.04.321.117.339.284.714.501 1.113.647.18.066.307.229.326.42l.158 1.571h1.595l.157-1.571c.019-.191.146-.354.326-.42.399-.146.774-.364 1.113-.647.148-.123.352-.151.526-.072l1.444.652.797-1.381-1.278-.918c-.156-.112-.233-.304-.201-.493.037-.211.067-.426.067-.648s-.03-.437-.067-.648c-.033-.189.045-.38.201-.493l1.278-.918-.797-1.381-1.444.651c-.175.079-.379.051-.527-.072-.338-.284-.712-.501-1.113-.647-.18-.066-.307-.229-.326-.42l-.157-1.574h-1.595l-.157 1.571c-.019.191-.146.354-.326.42-.399.146-.774.364-1.113.647-.147.123-.351.152-.526.072l-1.444-.652-.797 1.381 1.278.918c.156.112.233.304.201.493-.037.211-.067.426-.067.648s.03.437.067.648c.033.189-.045.38-.201.493l-1.278.918.797 1.381 1.444-.651c.066-.028.135-.042.205-.042z" />
              </g>
            </g>
          </svg>
        </div>
        <?php echo $column_right; ?></div>
      </div>
    </div>
  </div>
</section>

<div class="container">
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <h2><?php echo $text_my_account; ?></h2>
      <ul class="list-unstyled">
        <li><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
        <li><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
        <li><a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
        <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
      </ul>
      <?php if ($credit_cards) { ?>
      <h2><?php echo $text_credit_card; ?></h2>
      <ul class="list-unstyled">
        <?php foreach ($credit_cards as $credit_card) { ?>
        <li><a href="<?php echo $credit_card['href']; ?>"><?php echo $credit_card['name']; ?></a></li>
        <?php } ?>
      </ul>
      <?php } ?>
      <h2><?php echo $text_my_orders; ?></h2>
      <ul class="list-unstyled">
        <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
        <li><a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
        <?php if ($reward) { ?>
        <li><a href="<?php echo $reward; ?>"><?php echo $text_reward; ?></a></li>
        <?php } ?>
        <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
        <li><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
        <li><a href="<?php echo $recurring; ?>"><?php echo $text_recurring; ?></a></li>
      </ul>
      <h2><?php echo $text_my_newsletter; ?></h2>
      <ul class="list-unstyled">
        <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
      </ul>
      <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>