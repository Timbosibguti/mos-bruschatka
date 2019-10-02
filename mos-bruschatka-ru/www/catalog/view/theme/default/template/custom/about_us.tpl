<?php echo $header; ?>
<main class="container--rd">
	<?php echo $about_company; ?> <!-- custom/components/about_company.tpl -->

	<?php echo $assortiment; ?> <!-- custom/components/assortiment.tpl -->

	<?php echo $more_about; ?> <!-- custom/components/more_about.tpl -->

	<?php echo $teams; ?> <!-- custom/components/teams.tpl -->

	<?php echo $examples; ?> <!-- custom/components/examples.tpl -->

	<?php echo $documents; ?> <!-- custom/components/documents.tpl -->
</main>

<?php echo $content_bottom; ?>
<div class="map">
	<div class="container">
		<div class="row">
			<div class="col-12 col-md-4">
				<div class="h2 map__h2">Нужны образцы?</div>
				<h3 class="map__h3">Приходите к нам в офис</h3>
				<div class="text-sm text--color-4">Адрес</div>
				<p>п. Головково, ул. Строителей, стр. 11 </p>
				<div class="text-sm text--color-4">Проезд</div>
				<p>с Минского или Киевского Шоссе</p>
				<div class="text-sm text--color-4">График</div>
				<p>пн - пт: 09.00 - 18.00<br />сб - вс: 10.00 - 17.00</p>

				<a href="javascript:void(0);" class="text--color-1 text-sm text--bold map__modal">как нас найти ?</a>
				<br />
				<a href="javascript:void(0);" class="text--blue text-sm text--bold map__modal">юридическая информация</a>

				<div class="map__form">
					<input type="text" name="phone" placeholder="Ваш телефон:" class="input input--inline input--gray js-phone">
					<button type="submit" class="btn btn--inline btn--yellow flashed js-no-form-submit">ОТПРАВИТЬ</button>
					<p class="privacy-info">Отправляя форму Вы соглашаетесь<br>с политикой конфиденциальности</p>
				</div>
			</div>
			<div class="col-12 col-md-8">
				<script type="text/javascript" charset="utf-8" async src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3A0e479aa7ff7558d64152d643291dbe4153629ff501989673f8069e71616e585e&amp;width=100%&amp;height=100%&amp;lang=uk_UA&amp;scroll=true"></script>
			</div>
		</div>
	</div>
</div>
<?php echo $footer; ?></body></html>