<?php
    $privacy_info = $this->load->controller('common/privacy_info');
    $placeholder_phone = $this->language->get('placeholder_phone');
?>
<div class="advantages--normal">
<section class="section section--highlight advantages" id="advantages">
    <div class="container container--constraint">
        <div class="row no-gutters">
            <div class="advantages__col">
                <div class="h2 advantages__h2">Цены от  производителя  на любой объем  заказа</div>
                <p class="advantages__text">Мы работаем напрямую с крупнейшими заводами на особых условиях, а также сами являемся производителями - благодаря этому наши клиенты экономят до 15% на приобретении плитки.</p>
                <p class="advantages__text">Трудно в это поверить? Не верьте! Просто оставьте заявку на расчет стоимости заказа и убедитесь лично.</p>
                <form class="advantages-form js-form-callback" data-form-title="Рассчитать стоимость">
                    <input type="text" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline js-phone">
                    <button type="submit" class="btn btn--inline btn--yellow flashed">Рассчитать стоимость</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
            <div class="advantages__col dn767">
                <img src="" data-src="https://assets.mos-bruschatka.ru/image/catalog/advantages/adv-first.png" height="473" width="473" alt="" class="advantages__col-img">
            </div>
        </div>
        <div class="row no-gutters">
            <div class="advantages__col dn767">
                <img src="" data-src="https://assets.mos-bruschatka.ru/image/catalog/advantages/macbook.png" height="473" width="473" alt="" class="advantages__col-img">
            </div>
            <div class="advantages__col">
                <div class="h2 advantages__h2">Ассортимент,  которому  нет равных</div>
                <p class="advantages__text">В нашем каталоге 2500+ моделей тротуарной плитки. Все, что нужно для создания идеального ландшафта, вы найдете в одном месте - существенная экономия вашего времени. Информативная интернет-площадка поможет в выборе нужного товара и оплате счета.</p>
                <a href="catalogue" class="btn btn--inline btn--yellow mrt20">перейти в каталог</a>
            </div>
        </div>
        <div class="row no-gutters">
            <div class="advantages__col">
                <div class="h2 advantages__h2">Готовый ландшафт одним звонком</div>
                <p class="advantages__text">Любой, кто сталкивался с тротуарной плиткой, скажет вам, что ее долговечность на 50% зависит от качества укладки. Все наши укладчики с опытом работы не менее 6 лет. Даем гарантию на качество работ - 5 лет.</p>
                <form class="advantages-form js-form-callback" data-form-title="Рассчитать стоимость">
                    <input type="text" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline js-phone">
                    <button type="submit" class="btn btn--inline btn--yellow flashed">Рассчитать стоимость</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
            <div class="advantages__col dn767">
                <img src="" data-src="https://assets.mos-bruschatka.ru/image/catalog/advantages/adv-3.png" height="473" width="473" alt="" class="advantages__col-img">
            </div>
        </div>
        <div class="row no-gutters">
            <div class="advantages__col dn767">
                <img src="" data-src="https://assets.mos-bruschatka.ru/image/catalog/advantages/adv-4.png" height="473" width="473" alt="" class="advantages__col-img">
            </div>
            <div class="advantages__col">
                <div class="h2 advantages__h2">Качество, подтвержденное долговечностью</div>
                <p class="advantages__text">Гарантия на хорошую тротуарную плитку должна быть не менее 30-ти лет - мы гарантируем до 50-ти лет беспроблемной эксплуатации в любых условиях. Большего вам не предложит никто!<br>Все гарантийные обязательства прописаны в договоре.</p>
                <form class="advantages-form js-form-callback" data-form-title="adv3">
                    <input type="text" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline js-phone">
                    <button type="submit" class="btn btn--inline btn--yellow flashed">Проконсультировать</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
        </div>
        <div class="row no-gutters">
            <div class="advantages__col">
                <div class="h2 advantages__h2">Не верьте на слово - потрогайте руками!</div>
                <p class="advantages__text">Предоставляем возможность убедиться в качестве перед покупкой. В нашем офисе вы сможете осмотреть образцы любого товара из каталога, а те, которые вас заинтересуют, взять с собой. Можете устроить испытания тротуарной плитке или наглядно убедиться в том, что она подходит к вашему дизайну.</p>
                <form class="advantages-form js-form-callback" data-form-title="Получиь образцы">
                    <input type="text" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline js-phone">
                    <button type="submit" class="btn btn--inline btn--yellow flashed">Получить образцы</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
            <div class="advantages__col dn767">
                <img src="" data-src="https://assets.mos-bruschatka.ru/image/catalog/advantages/adv-5.png" height="473" width="473" alt="" class="advantages__col-img">
            </div>
        </div>
    </div>
</section>
</div>
