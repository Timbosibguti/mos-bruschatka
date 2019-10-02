<?php echo $header; ?>
<main class="container--rd" id="wrapper">
    <div class="text-center confirmation-page__content-top">
        <div class="container">
            <div class="h2 confirmation-page__h2">Спасибо! Ваш заказ успешно оформлен!</div>
            <h3>Мы уже работаем над Вашим заказом. В ближайшее время с Вами свяжется нам менеджер, чтобы уточнить все детали Вашего заказа. </h3>
        </div>
    </div>

    <div class="section section--highlight newsletters">
        <div class="container">
            <div class="d-md-flex justify-content-between">
                <div class="newsletters__col">
                    <h3 class="newsletters__h3">Подпишись на нас в социальных  сетях</h3>
                    <?php  if(isset($social_navs)) { ?>			  
                    <div class="contacts__social">
                        <span class="contacts__social-title">
                            <?php echo $text_lightshop_con_soc; ?>
                        </span>
                        <ul class="social contacts__social-list">
                            <?php  foreach ($social_navs as $key => $social_nav) { ?>
                            <li class="social__item">
                                <a href="<?php echo $social_nav['link']; ?>" target="<?php echo $social_nav['attr']; ?>" class="social__link">
                                    <svg class="icon-fb icon-fb--lg">
                                        <use xlink:href="#<?php echo strtolower($social_links[$social_nav['settype']]); ?>"></use>
                                    </svg>
                                </a>
                            </li>
                            <?php } ?>
                        </ul>
                    </div>
                    <?php } ?>
                </div>
                <div class="newsletters__col">
                    <h3 class="newsletters__h3">Оформи подписку на наши новости</h3>
                    <form action="javascript:void(0);" class="d-flex newsletters__form">
                        <input type="email" name="email" placeholder="<?php echo $placeholder_email; ?>" class="input">
                        <div class="d-inline">
                            <button type="button" class="btn btn--yellow">подписаться на новости</button>
                            <div class="privacy-info">Отправляя форму Вы соглашаетесь с <a href="javascript:void(0);">политикой конфиденциальности</a></div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</main>

<?php echo $footer; ?>
</body></html>