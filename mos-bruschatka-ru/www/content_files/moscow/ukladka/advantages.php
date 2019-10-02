<?php
    $privacy_info = $this->load->controller('common/privacy_info');
    $placeholder_phone = $this->language->get('placeholder_phone');
    $placeholder_name = $this->language->get('placeholder_name');
?>
<div class="section ukladka-features">
    <div class="container">
        <div class="row">
            <div class="col-6 col-md-3 col-lg-2 offset-lg-2">
                <div class="svg-border svg-border--50 icon-design-tool ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Бесплатный выезд и замер</h3>
                <span class="ukladka-features__text">Быстро и точно рассчитаем смету на объекте</span>
            </div>
            <div class="col-6 col-md-3 col-lg-2">
                <div class="svg-border svg-border--50 icon-screwdriver ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Под ключ</h3>
                <span class="ukladka-features__text">Дизайн-макет, материалы, доставка, укладка</span>
            </div>
            <div class="col-6 col-md-3 col-lg-2">
                <div class="svg-border svg-border--50 icon-certificate ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Гарантия качества</h3>
                <span class="ukladka-features__text">Работаем по договору. Срок гарантии - 1 год</span>
            </div>
            <div class="col-6 col-md-3 col-lg-2">
                <div class="svg-border svg-border--50 icon-accounting ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Фиксированная смета</h3>
                <span class="ukladka-features__text">Вы не переплачиваете ни рублем больше изначальной сметы</span>
            </div>
        </div>
    </div>
</div>

<div class="section ukladka-adv">
    <div class="container container--constraint position-relative">
        <div class="h2 ukladka-adv__h2">Сделаем ваш участок уютным на самых выгодных условиях</div>
        <div class="row">
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-screwdriver-big ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Под ключ</div>
                <p class="ukladka-adv__text">Все, что от вас требуется - согласовать дизайн-макет и подписать договор. Никаких забот - сами доставим материалы и выполним работы на высшем уровне.</p>
            </div>
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-worker-big ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Опытные мастера</div>
                <p class="ukladka-adv__text">Вы можете быть уверенны, что укладывать плитку на вашем участке будут лучшие из спецов - квалификация наших сотрудников подтверждена документально.</p>
            </div>
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-document-big ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Гарантия</div>
                <p class="ukladka-adv__text">Ваша плитка будет служить долго - мы даем официальную гарантию на качество материала (до 50 лет) и укладку (1 год)</p>
            </div>
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-save-money ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Экономия</div>
                <p class="ukladka-adv__text">Пусть вас не смущает низкая цена: Мосбрусчатка - официальный партнер 6-ти заводов производителей. Вы платите меньше, но не за счет качества.</p>
            </div>
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-stock ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Ассортимент</div>
                <p class="ukladka-adv__text">Вы выбираете плитку из более 2500 вариантов нашего каталога. Найдутся даже редкие экземпляры для изысканных дизайн-макетов.</p>
            </div>
            <div class="col-sm-6 ukladka-adv__card">
                <div class="svg-border svg-border--70 icon-clock ukladka-adv__icon"></div>
                <div class="h3 ukladka-adv__card-title">Всегда вовремя</div>
                <p class="ukladka-adv__text">Сроки реализации проекта прописаны в договоре. И мы всегда их соблюдаем. Не успеем к назначенной дате - сделаем скидку за каждый день просрочки.</p>
            </div>
        </div>

        <div class="inline-info">
            <button type="button" class="btn btn--spacing btn--yellow inline-info__btn icon-download js-modal" data-target="#modalDownloadCatalog">скачать прайс-лист</button>
            <p class="inline-info__description">Скачать полную PDF версию каталога со всеми ценами </p>
        </div>

    </div>
</div>

<div class="section-big ukladka-consultation js-load-bg" data-src="https://assets.mos-bruschatka.ru/image/catalog/banners/consultation-bg.jpg">
    <div class="container">
        <div class="row">
            <div class="col-sm-9 col-md-6">
                <div class="mb-50 h2 text--white">Сэкономьте время и деньги: проконсультируйтесь <span class="whitespace-nowrap">и закрепите за собой</span> <span class="whitespace-nowrap">скидку 5% от сметы!</span></div>
                <ul class="ukladka-consultation-questions__list">
                    <li class="ukladka-consultation-questions__list-item">Какие варианты плитки подойдут для моего участка?</li>
                    <li class="ukladka-consultation-questions__list-item">В какую цену обойдется уют на моем участке?</li>
                    <li class="ukladka-consultation-questions__list-item">В какой срок Вы реализуете мой проект?</li>
                    <li class="ukladka-consultation-questions__list-item">Нужен ли мне дизайн-макет?</li>
                </ul>
                <p class="mb-20">После консультации у вас не останется этих вопросов!</p>
                <button class="btn btn--spacing btn--yellow icon-phone js-modal" data-target="#modalCallback">Проконсультироваться сейчас</button>
            </div>
        </div>
    </div>
</div>

<div class="section ukladka-potency">
    <div class="container">
        <div class="h2 mb-30">МосБрусчатка: мы — надежны, вы — спокойны</div>
        <div class="ukladka-potency__list">
            <div class="ukladka-potency__list-item">
                <div class="svg-border svg-border--50 icon-employees ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Лучший персонал</h3>
                <span class="ukladka-features__text">Мы отбираем мастеров по строгим критериям. Регулярно проводим аттестации и профподготовку. Все работники - славяне.</span>
            </div>
            <div class="ukladka-potency__list-item">
                <div class="svg-border svg-border--50 icon-enlarge ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">У нас нет границ</h3>
                <span class="ukladka-features__text">Выполняем заказы площадью от 10 м<sup>2</sup> до бесконечности. Даже если вам нужна укладка плитки на аэродроме - сделаем!</span>
            </div>
            <div class="ukladka-potency__list-item">
                <div class="svg-border svg-border--50 icon-document ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Выполняем обязательства</h3>
                <span class="ukladka-features__text">Работаем по официальному договору. Неполадки, возникшие по нашей вине устраняем быстро и за свой счет.</span>
            </div>
            <div class="ukladka-potency__list-item">
                <div class="svg-border svg-border--50 icon-analytics ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Честная статистика</h3>
                <span class="ukladka-features__text">За все время работы всего 0,01% гарантийных случаев. Ни в одной компании нет 100% результата - нашей статистикой можно гордиться.</span>
            </div>
            <div class="ukladka-potency__list-item">
                <div class="svg-border svg-border--50 icon-partner ukladka-features__svg-border"></div>
                <h3 class="ukladka-features__title">Солидные партнеры</h3>
                <span class="ukladka-features__text">Мы сотрудничаем с 5-ю крупными заводами- поставщиками. Благодаря этому, оказываем услуги по цене ниже рыночной.</span>
            </div>
        </div>
    </div>
</div>

<div class="section section--highlight ukladka-schema">
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-md-7 col-lg-8">
                <div class="size6of7">
                    <div class="mb-50 h2">Прозрачная и надежная схема работы</div>
                    <ul class="ukladka-schema__list">
                        <li class="ukladka-schema__list-item">Оставляете заявку на сайте</li>
                        <li class="ukladka-schema__list-item">Предварительная консультация по телефону</li>
                        <li class="ukladka-schema__list-item">Выезд на объект, составляем смету</li>
                        <li class="ukladka-schema__list-item">Заключаем договор</li>
                        <li class="ukladka-schema__list-item">Разрабатываем <span class="whitespace-nowrap">дизайн-макет</span></li>
                        <li class="ukladka-schema__list-item">Завозим материалы и укладываем плитку</li>
                    </ul>
                </div>
            </div>
            <div class="col-xs-12 col-md-4 col-lg-3">
                <form action="javascript:void(0);" class="ukladka-service__form js-form-callback" data-form-title="Закажите услугу под ключ">
                    <h3 class="mb-50">Закажите услугу<br />"под ключ"</h3>
                    <input type="text" name="<?php echo $placeholder_name; ?>" placeholder="<?php echo $placeholder_name; ?>" class="input input--inline input--highlight">
                    <input type="tel" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline input--highlight">
                    <button type="submit" class="btn btn--inline btn--yellow flashed">оставить заявку</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="section ukladka-reduction">
    <div class="container">
        <div class="text-center">
            <div class="mb-5 h2">МосБрусчатка — экономия, которая</div>
            <div class="mb-50 h2">не сказывается на качестве!</div>
            <h3 class="mb-30">Выберите свою скидку</h3>
        </div>
        <div class="row">
            <div class="col-sm-4">
                <div class="ukladka-reduction__card">
                    <div class="ukladka-reduction__card-percent">5<span>%</span></div>
                    <h3 class="mb-30">Оставьте заявку <span class="whitespace-nowrap">на сайте и получите</span> скидку 5%</h3>
                    <button class="btn btn--fluid btn--outline-black js-modal" data-target="#modalCallback">оставить заявку</button>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="ukladka-reduction__card">
                    <div class="ukladka-reduction__card-percent">3<span>%</span></div>
                    <h3 class="mb-30">При повторном обращении вы получаете скидку 3%</h3>
                    <button class="btn btn--fluid btn--outline-black js-modal" data-target="#modalCallback">получить скидку</button>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="ukladka-reduction__card">
                    <div class="ukladka-reduction__card-percent">2<span>%</span></div>
                    <h3 class="mb-30">Порекомендуйте нас знакомым и получите 2% от суммы их заказа</h3>
                    <button class="btn btn--fluid btn--outline-black js-modal" data-target="#modalCallback">порекомендовать</button>
                </div>
            </div>
        </div><!-- row -->
    </div><!-- container -->
</div>
