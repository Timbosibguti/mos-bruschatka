<?php echo $header; ?>
<main class="main" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>
	<div id="filialsMap" class="filials-page__map" style="width: 100%; min-height: 540px">
		<div class="container position-relative">
			<div class="col-4 filials-page__balloon">
				<div class="mb-20 h2">Филиалы</div>
				<div class="mb-20">
					<p class="mb-10 text-sm text--light-gray">Выберите Ваш город из списка или на карте</p>
					<div class="custom-select" id="filialsAddress">
						<select style="position: absolute; height: 0; width: 0; overflow: hidden;">
							<?php foreach($store['locations'] as $location) { ?>
							<option value="<?php echo $location['address']; ?>" data-target="#filialLocation<?php echo $location['location_id']; ?>"><?php echo $location['name']; ?></option>
							<?php } ?>
						</select>
					</div>
				</div>
				<?php foreach($store['locations'] as $key => $location) { ?>
				<div class="filials-page__infos js-filials-info" id="filialLocation<?php echo $location['location_id']; ?>" <?php echo ($key > 0) ? 'style="display:none;"' : ''; ?>>
					<p class="text-sm text-color-2">Адрес</p>
					<p class="mb-20"><?php echo $location['address']; ?></p>
					<p class="text-sm text-color-2">Телефон</p>
					<p class="mb-20"><a href="tel:+74994500311"><?php echo $location['phone']; ?></a></p>
					<p class="text-sm text-color-2">График</p>
					<p class="mb-20"><?php echo $location['open']; ?></p>
					<p class="text-sm text-color-2">Email поддержки покупателей</p>
					<p class="mb-20"><a href="mailto:<?php echo $location['email']; ?>"><?php echo $location['email']; ?></a></p>
					<button class="btn btn--inline btn--yellow mb-0 icon-heart js-modal" data-target="#modalCallback">хочу Связаться</button>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>

	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<?php echo $footer; ?>
<script defer="defer">
	var yamps;
	ymaps.ready(filialsMaps);
	function filialsMaps() {
		let filialsMap = new ymaps.Map('filialsMap', {
			center: [56.00, 35.00],
			zoom: 7,
			controls: []
		}, {
			searchControlProvider: 'yandex#search'
		});

		let coords = [
			<?php foreach($store['locations'] as $location) { ?>
				[<?php echo $location['geocode']; ?>],
			<?php } ?>
		];
		
		let myCollection = new ymaps.GeoObjectCollection();
		
		for (let i = 0; i < coords.length; i++) {
			myCollection.add(new ymaps.Placemark(coords[i]));
		}
		
		filialsMap.geoObjects.add(myCollection);
		filialsMap.setBounds(filialsMap.geoObjects.getBounds());
	}
</script>
</body></html>