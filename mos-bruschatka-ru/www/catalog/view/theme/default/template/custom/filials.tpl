<?php echo $header; ?>
<main class="main" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>

	<div id="filialsMap" class="filials-map" style="width: 100%; min-height: 540px">
		<div class="container position-relative">
			<div class="col-4 filials-map__balloon">
				<div class="mb-20 h2">Филиалы</div>
				<div class="mb-20">
					<p class="mb-10 text-sm text--light-gray">Выберите Ваш город из списка или на карте</p>
					<div class="custom-select" id="filialsAddress">
						<select style="position: absolute; height: 0; width: 0; overflow: hidden;">
							<option value="Кутузовский проспект, 36" data-target="#filialsMos">Москва Брусчатка</option>
							<option value="Кутузовский проспект, 36" data-target="#filialsMos">Москва Брусчатка</option>
							<option value="Сиреневый бульвар, 25" data-target="#filialsSp">Санкт-петерсбург Брусчатка</option>
							<option value="Улиция кусинена, 21" data-target="#filialsSo">Сочи Брусчатка</option>
						</select>
					</div>
				</div>
				<div class="filials-info js-filials-info" id="filialsMos">
					<p class="text-sm text-color-2">Адрес</p>
					<p class="mb-20">Кутузовский проспект, 36, 2-ой этаж, помещение 2</p>
					<p class="text-sm text-color-2">Телефон</p>
					<p class="mb-20"><a href="tel:+74994500311">+7 (499) 450-03-11</a></p>
					<p class="text-sm text-color-2">График</p>
					<p class="mb-20">пн - пт: 9 - 20 сб<br />вс: 10 -17</p>
					<p class="text-sm text-color-2">Email поддержки покупателей</p>
					<p class="mb-20"><a href="mailto:mos.bruschatka@yandex.ru">mos.bruschatka@yandex.ru</a></p>
					<button class="btn btn--inline btn--yellow mb-0 js-modal" data-target="#jsModalCallback">хочу Связаться</button>
				</div>
				<div class="filials-info js-filials-info" id="filialsSp" style="display: none;">
					<p class="text-sm text-color-2">Адрес</p>
					<p class="mb-20">Сиреневый бульвар, 25</p>
					<p class="text-sm text-color-2">Телефон</p>
					<p class="mb-20"><a href="tel:+74994500311">+7 (499) 450-03-11</a></p>
					<p class="text-sm text-color-2">График</p>
					<p class="mb-20">пн - пт: 9 - 20 сб<br />вс: 10 -17</p>
					<p class="text-sm text-color-2">Email поддержки покупателей</p>
					<p class="mb-20"><a href="mailto:mos.bruschatka@yandex.ru">mos.bruschatka@yandex.ru</a></p>
					<button class="btn btn--inline btn--yellow mb-0 js-modal" data-target="#jsModalCallback">хочу Связаться</button>
				</div>
				<div class="filials-info js-filials-info" id="filialsSo" data-target="so" style="display: none;">
					<p class="text-sm text-color-2">Адрес</p>
					<p class="mb-20">Улиция кусинена, 21</p>
					<p class="text-sm text-color-2">Телефон</p>
					<p class="mb-20"><a href="tel:+74994500311">+7 (499) 450-03-11</a></p>
					<p class="text-sm text-color-2">График</p>
					<p class="mb-20">пн - пт: 9 - 20 сб<br />вс: 10 -17</p>
					<p class="text-sm text-color-2">Email поддержки покупателей</p>
					<p class="mb-20"><a href="mailto:mos.bruschatka@yandex.ru">mos.bruschatka@yandex.ru</a></p>
					<button class="btn btn--inline btn--yellow mb-0 js-modal" data-target="#jsModalCallback">хочу Связаться</button>
				</div>
			</div>
		</div>
	</div>

	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<?php echo $footer; ?>
</body></html>