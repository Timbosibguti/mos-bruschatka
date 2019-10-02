<?php echo $header; ?>
<main class="content">
	<div class="delivery-page">
		<div class="delivery-compute">
			<div id="delCompMap" class="delivery-compute__map" style="width: 100%; min-height: 550px">
				<div class="container position-relative">
					<form action="javascript:void(0);" class="delivery-compute__form js-form-callback" data-form-title="Расчет доставки" data-form-type="inline">
						<div class="h2 delivery-compute__h2">Расчет доставки</div>
						<div class="delivery-compute__locations" id="delCompLocs">
							<div class="delivery-compute__locations-before">
								<div class="custom-select mb-10" id="deliveryAddress">
									<select style="position: absolute; height: 0; width: 0; overflow: hidden;">
										<?php foreach($store['locations'] as $key => $location) { ?>
										<option value="<?php echo $location['address']; ?>"><?php echo $location['name']; ?></option>
										<?php } ?>
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
								<span class="d-block">Стоимость доставки* :</span>
								<h3 class="js-delivery-price">от <span class="price-from">10 346</span> до <span class="price-to">10 346</span> ₽</h3>
							</div>
							<div class="delivery-compute__bottom">
								<p class="text--bold delivery-compute__text">* Чтобы получить более точный расчет, заполните форму, и с Вами свяжется наш менеджер</p>
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
						<div class="svg-border svg-border--70 icon-calendar-page-on-day-7 del-info__svg-border"></div>
						<span class="del-info__text">Доставка 7 дней в неделю</span>
					</div>
					<div class="col-6 col-md-3 col-lg-2">
						<div class="svg-border svg-border--70 icon-hourglass del-info__svg-border"></div>
						<span class="del-info__text">Доставка точно в срок</span>
					</div>
					<div class="col-6 col-md-3 col-lg-2">
						<div class="svg-border svg-border--70 icon-manager del-info__svg-border"></div>
						<span class="del-info__text">Персональный менеджер-логист</span>
					</div>
					<div class="col-6 col-md-3 col-lg-2">
						<div class="svg-border svg-border--70 icon-boxes del-info__svg-border"></div>
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
						<img data-src="https://assets.mos-bruschatka.ru/image/catalog/delivery/car-3.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
						<div class="del-step__col">
							<h3 class="del-step__col-h3">Загрузка товара</h3>
							<p class="del-step__text">Товар загружают манипулятором, что исключает возможность повреждения.</p>
						</div>
					</div>
					<div class="col-md-4">
						<img data-src="https://assets.mos-bruschatka.ru/image/catalog/delivery/radar.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
						<div class="del-step__col">
							<h3 class="del-step__col-h3">Отслеживание</h3>
							<p class="del-step__text">В пути. Вы можете в режиме реального времени отслеживать местоположение автомобиля</p>
						</div>
					</div>
					<div class="col-md-4">
						<img data-src="https://assets.mos-bruschatka.ru/image/catalog/delivery/car-4.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-step__img">
						<div class="del-step__col">
							<h3 class="del-step__col-h3">Доставка</h3>
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
						<img data-src="https://assets.mos-bruschatka.ru/image/catalog/delivery/car-1.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-parking__img">
					</div>
					<div class="col-md-6">
						<h3 class="mb-50">Машина с боковой загрузкой. Тонаж 20т</h3>
						<img data-src="https://assets.mos-bruschatka.ru/image/catalog/delivery/car-2.png" src="<?php echo $placeholder_img; ?>" alt="" class="del-parking__img">
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
											<div class="svg-border svg-border--70 icon-calculator-big"></div>
											<span class="del-payment__text">Производим расчет стоимости</span>
										</li>
										<li class="del-payment__list-item">
											<div class="svg-border svg-border--70 icon-payment-method"></div>
											<span class="del-payment__text">Оплата производится в нашем офисе</span>
										</li>
										<li class="del-payment__list-item">
											<div class="svg-border svg-border--70 icon-document-big-blue"></div>
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
											<div class="svg-border svg-border--70 icon-debt-big"></div>
											<span class="del-payment__text">Производим расчет стоимости и отправляем вам счет с реквизитами</span>
										</li>
										<li class="del-payment__list-item">
											<div class="svg-border svg-border--70 icon-wallet"></div>
											<span class="del-payment__text">
												По этим реквизитам вы можете оплатить счет:
												<br /> - С помощью мобильного приложения
												<br /> или
												<br /> - Обратившись в банк и предоставив данные реквизиты.
											</span>
										</li>
										<li class="del-payment__list-item">
											<div class="svg-border svg-border--70 icon-document-big-blue"></div>
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
		<?php echo $map_contact; ?> <!-- custom/components/map_contact.tpl -->
	</div>
</main>
<?php echo $footer; ?>
<script defer="defer">
	var ymaps;
	ymaps.ready(deliveryMaps);
	function deliveryMaps() {
		var destinationSuggestView = new ymaps.SuggestView('deliveryDestinationInput');
		var delCompMap = new ymaps.Map('delCompMap', {
			center: [55.76, 37.00],
			zoom: 15,
			behaviors: ["drag", "dblClickZoom", "rightMouseButtonMagnifier", "multiTouch"],
			controls: []
		}, {
			searchControlProvider: 'yandex#search'
		});

		// Создадим панель маршрутизации.
		var routePanelControl = new ymaps.control.RoutePanel({
			options: {
				visible: false
			}
		});

		var zoomControl = new ymaps.control.ZoomControl({
			options: {
				size: 'small',
				float: 'none',
				position: {
					top: 200,
					right: 15
				}
			}
		});

		// Пользователь сможет построить только автомобильный маршрут.
		routePanelControl.routePanel.options.set({
			types: {auto: true}
		});

		delCompMap.controls.add(routePanelControl).add(zoomControl);

		$(document).on('click', '#deliveryAddress', function() {
			let selected = $(this).find('option:selected').val();

			routePanelControl.routePanel.state.set({
				from: selected,
			});

			routeDetail();
		});

		$('#deliveryAddress').trigger('click');

		// Слушаем клик на карте.
		delCompMap.events.add('click', function (e) {
			let coords = e.get('coords');
			getAddress(coords);
		});

		// Определяем адрес по координатам (обратное геокодирование).
		function getAddress(coords) {
			ymaps.geocode(coords).then(function (res) {
				let firstGeoObject = res.geoObjects.get(0).properties.get('name');
				$('#deliveryDestinationInput').val(firstGeoObject).trigger('change');
			});
		}

		$(document).on('click input blur change', '#deliveryDestinationInput', function() {
			let self = $(this);
			setTimeout(function() {
				routePanelControl.routePanel.state.set({
					to: self.val()
				});

				routeDetail();
			}, 1000);
		});

		// Получим ссылку на маршрут.
		function routeDetail() {
			routePanelControl.routePanel.getRouteAsync().then(function (route) {

				// Зададим максимально допустимое число маршрутов, возвращаемых мультимаршрутизатором.
				route.model.setParams({results: 1}, true);

				// Повесим обработчик на событие построения маршрута.
				route.model.events.add('requestsuccess', function () {

					let activeRoute = route.getActiveRoute();
					if (activeRoute) {
						// Получим протяженность маршрута.
						let routeObj = route.getActiveRoute().properties.get("distance"),
							length = new Intl.NumberFormat('ru-RU').format(routeObj.value),
							lengthKm = new Intl.NumberFormat('ru-RU').format(routeObj.value / 1000),
							priceFrom = routeObj.value / 10,
							priceTo = priceFrom * 1.3,

						// Вычислим стоимость доставки.
						// Создадим макет содержимого балуна маршрута.
							balloonContentLayout = ymaps.templateLayoutFactory.createClass(
								'<span>Расстояние: ' + routeObj.text + '.</span><br/>');
						// Зададим этот макет для содержимого балуна.
						route.options.set('routeBalloonContentLayout', balloonContentLayout);
						// Откроем балун.
						activeRoute.balloon.open();
						$('.js-delivery-distance').html(lengthKm + ' км');
						$('.js-delivery-price > .price-from').html(formatPrice(priceFrom));
						$('.js-delivery-price > .price-to').html(formatPrice(priceTo));
						$('#deliveryInputDistance').val(lengthKm + ' км');
						$('#deliveryInputPrice').val(priceFrom);

						// Check if input are not empty
						$('#delCompLocs .js-btn-next').removeAttr('disabled').switchClass('btn--disabled', 'btn--blue');
					} else {
						$('.js-delivery-distance').html('0,00 км');
						$('.js-delivery-price > span').html(0);
						$('#deliveryInputDistance').val('0,00 км');
						$('#deliveryInputPrice').val(0);
						$('#delCompLocs .js-btn-next').attr('disabled', 'disabled').switchClass('btn--blue', 'btn--disabled');
					}
				});
			});
		}

		function formatPrice(price) {
			return Intl.NumberFormat('ru-RU', {maximumFractionDigits: 0}).format(price);
		}
	}
</script>
</body></html>
