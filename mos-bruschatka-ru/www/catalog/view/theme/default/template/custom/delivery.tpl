<?php echo $header; ?>
<main class="content">
	<div class="delivery-page">
        <div class="delivery-compute">
            <div id="delCompMap" class="delivery-compute__map" style="width: 100%; min-height: 525px">
                <div class="container position-relative">
                    <form action="javascript:void(0);" class="delivery-compute__form js-form-simple" data-form-title="Расчет доставки" data-form-type="inline">
                        <div class="h2 delivery-compute__h2">Расчет доставки</div>
                        <div class="delivery-compute__locations" id="delCompLocs">
                            <div class="delivery-compute__locations-before">
                                <div class="custom-select mb-10" id="deliveryAddress">
                                    <select style="position: absolute; height: 0; width: 0; overflow: hidden;">
                                        <option value="Кутузовский проспект, 36" data-target="#filialsMos">Москва Брусчатка</option>
                                        <option value="Кутузовский проспект, 36" data-target="#filialsMos">Москва Брусчатка</option>
                                        <option value="Сиреневый бульвар, 25" data-target="#filialsSp">Санкт-петерсбург Брусчатка</option>
                                        <option value="Улиция кусинена, 21" data-target="#filialsSo">Сочи Брусчатка</option>
                                    </select>
                                </div>
                                <input type="text" name="destination" placeholder="Адрес доставки или точка на карте" class="input input--fluid input--highlight" id="deliveryDestinationInput" />
                            </div>
                            <div class="delivery-compute__distance">
                                <span class="text-sm">Километраж</span>
                                <span class="text-normal text--bold js-delivery-distance">120,34 км</span>
                            </div>
                            <button type="button" class="mb-0 float-right btn btn--inline btn--disabled js-btn-next" disabled="disabled">Узнать стоимость</button>
                        </div>
                        <div class="delivery-compute__result" id="delCompResult" style="display: none;">
                            <div class="delivery-compute__top">
                                <div class="delivery-compute__distance">
                                    <span class="text-sm">Километраж</span>
                                    <span class="text-normal text--bold js-delivery-distance">120,34 км</span>
                                    <input type="hidden" name="distance" value="" id="deliveryInputDistance" />
                                    <input type="hidden" name="price" value="" id="deliveryInputPrice" />
                                </div>
                                <button type="button" class="btn btn--inline btn--outline-blue js-btn-prev text--blue delivery-compute__btn-float">новый расчет</button>
                            </div>
                            <div class="delivery-compute__middle">
                                <span class="d-block">Стоимость доставки:</span>
                                <h3 class="js-delivery-price">10 346 рублей</h3>
                            </div>
                            <div class="delivery-compute__bottom">
                                <p class="text--bold delivery-compute__text">Чтобы получить более точный расчет, заполните форму, и с Вами свяжется наш менеджер</p>
                                <input type="text" name="name" placeholder="<?php echo $placeholder_name; ?>" class="input input--inline delivery-compute__input">
                                <input type="tel" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline delivery-compute__input js-phone">
                                <button type="submit" class="btn btn--fluid btn--yellow flashed">Оставить заявку</button>
                                <div class="privacy-info privacy-info--white"><?php echo $privacy_info; ?></div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="section del-info">
            <div class="container">
                <div class="row">
                    <div class="col-6 col-md-3 col-lg-2 offset-lg-2">
                        <div class="svg-border del-info__svg-border"><svg height="42" width="42" class="del-info__svg"><use xlink:href="#iconCalendarV2"></use></svg></div>
                        <span class="del-info__text">Доставка 7 дней в неделю</span>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <div class="svg-border del-info__svg-border"><svg height="42" width="42" class="del-info__svg"><use xlink:href="#iconHourglass"></use></svg></div>
                        <span class="del-info__text">Доставка точно в срок</span>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <div class="svg-border del-info__svg-border"><svg height="42" width="42" class="del-info__svg"><use xlink:href="#iconManager"></use></svg></div>
                        <span class="del-info__text">Персональный менеджер-логист</span>
                    </div>
                    <div class="col-6 col-md-3 col-lg-2">
                        <div class="svg-border del-info__svg-border"><svg height="42" width="42" class="del-info__svg"><use xlink:href="#iconBoxes"></use></svg></div>
                        <span class="del-info__text">Услуги по разгрузке товара</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="section section--highlight del-step">
            <div class="container">
                <div class="h2 mb-20">Этапы доставки</div>
                <div class="row">
                    <div class="col-md-4">
                        <img data-src="../image/catalog/delivery/car-3.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
                        <div class="del-step__col">
                            <h3 class="del-step__col-h3">Загрузка товара</h3>
                            <p class="del-step__text">Товар загружают манипулятором, что исключает возможность повреждения.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <img data-src="../image/catalog/delivery/radar.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
                        <div class="del-step__col">
                            <h3 class="del-step__col-h3">Отслеживание</h3>
                            <p class="del-step__text">В пути. Вы можете в режиме реального времени отслеживать местоположение автомобиля</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <img data-src="../image/catalog/delivery/car-4.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
                        <div class="del-step__col">
                            <h3 class="del-step__col-title">Доставка</h3>
                            <p class="del-step__text">Мы привезем товар и разгрузим его в удобном для вас месте. Благодаря манипулятору, разгрузка не займет много времени и весь товар останется целым</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section del-parking">
            <div class="container">
                <div class="h2 mb-20">Наш автопарк</div>
                <div class="row">
                    <div class="col-md-6">
                        <h3 class="mb-50">Машина с манипулятором. Тонаж 20т</h3>
                        <img data-src="../image/catalog/delivery/car-1.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-parking__img">
                    </div>
                    <div class="col-md-6">
                        <h3 class="mb-50">Машина с боковой загрузкой. Тонаж 20т</h3>
                        <img data-src="../image/catalog/delivery/car-2.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-parking__img">
                    </div>
                </div>
            </div>
        </div>
        <div class="section section--highlight del-payment">
            <div class="container">
                <div class="row">
                    <div class="col-md-10 offset-md-1">
                        <div class="h2 mb-30">Способы оплаты</div>
                        <div class="row align-items-stretch">
                            <div class="col-md-6">
                                <div class="del-payment__col-bg">
                                    <h3 class="mb-20">Оплата наличными</h3>
                                    <ul class="del-payment__list">
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42"><use xlink:href="#iconCalculator"></use></svg></div>
                                            <span class="del-payment__text">Производим расчет стоимости</span>
                                        </li>
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42"><use xlink:href="#iconPaymentMethod"></use></svg></div>
                                            <span class="del-payment__text">Оплата производится в нашем офисе</span>
                                        </li>
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42" class="icon-del-payment__document"><use xlink:href="#iconDocument"></use></svg></div>
                                            <span class="del-payment__text">После оплаты вы получаете документы подтверждающие оплату</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="del-payment__col-bg">
                                    <h3 class="mb-20">Безналичная оплата</h3>
                                    <ul class="del-payment__list">
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42"><use xlink:href="#iconDebt"></use></svg></div>
                                            <span class="del-payment__text">Производим расчет стоимости и отправляем вам счет с реквизитами</span>
                                        </li>
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42"><use xlink:href="#iconWallet"></use></svg></div>
                                            <span class="del-payment__text">
                                                По этим реквизитам вы можете оплатить счет:
                                                <br /> - С помощью мобильного приложения
                                                <br /> или
                                                <br /> - Обратившись в банк и предоставив данные реквизиты.
                                            </span>
                                        </li>
                                        <li class="del-payment__list-item">
                                            <div class="svg-border"><svg height="42" width="42" class="icon-del-payment__document"><use xlink:href="#iconDocument"></use></svg></div>
                                            <span class="del-payment__text">Все необходимые документы вы можете получить придя в офис, либо по почте России. Так же вам их направят по электронной почте</span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section del-map">
            <div class="container">
                <div class="row align-items-stretch">
                    <div class="col-md-3">
                        <div class="h2 mb-20">Самовывоз</div>
                        <h3 class="mb-30">Возможен самовывоз</h3>
                        <div class="text-sm text--light-gray">Адрес</div>
                        <p class="mb-20">п. Головково, ул. Строителей, стр. 11 </p>
                        <div class="text-sm text--light-gray">Проезд</div>
                        <p class="mb-20">с Минского или Киевского Шоссе</p>
                        <div class="text-sm text--light-gray">График</div>
                        <p class="mb-50">пн - пт: 09.00 - 18.00<br />сб - вс: 10.00 - 17.00</p>
                        <a href="#jsModalCallback" class="btn btn--inline btn--yellow flashed del-map__btn js-nav-top-link">Оформить</a>
                    </div>
                    <div class="col-md-9">
                        <script defer src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Afc64fb3da4829e3af3b1b5c10a61a99a62743502af11335669db10f62993be8c&amp;width=100%&amp;height=450&amp;lang=ru_RU&amp;scroll=false"></script>
                    </div>
                </div>
            </div>
        </div>
        <div class="section section--highlight">
            <div class="container">
                <div class="row">
                    <div class="col-lg-10 offset-lg-1">
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam suscipit tellus non tortor gravida, vel lobortis augue aliquet. Proin urna nulla, commodo quis viverra sit amet, tincidunt nec turpis. Ut augue massa, convallis ut elementum id, varius in augue. Nunc metus lectus, pulvinar condimentum commodo sed, porta ut ex. Mauris suscipit odio non dui scelerisque semper. Cras at libero odio. In in enim eu risus interdum fringilla.</p>
                    </div>
                </div>
            </div>
        </div>
	</div>
</main>
<?php echo $footer; ?>
</body></html>