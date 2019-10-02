<div class="filials">
	<div class="container container--constraint">
		<div class="h2 text-center mb-35">Наши филиалы</div>
	</div>
	<div class="container--fluid">
		<div id="filialsMap" class="filials-map loading loader--centered" style="width: 100%; height: 100vh;"></div>
	</div>
</div>

<script>
	var yamps;

	ymaps.ready(filialsMap);
	
	function filialsMap() {
		var mapLoaded = false;

		$(window).on('resize load scroll', function() {
			if((window.pageYOffset + $(window).height()) > $('#filialsMap').offset().top) {
				if(!mapLoaded) {
					var filialsMap = new ymaps.Map('filialsMap', {
						center: [55.317442, 39.679964],
						zoom: 6,
						behaviors: ["drag", "dblClickZoom", "rightMouseButtonMagnifier", "multiTouch"],
						controls: []
					}, {
						searchControlProvider: 'yandex#search'
					}),

					collection = new ymaps.GeoObjectCollection(null, {
						preset: 'islands#redCircleIcon'
					}),

					CustomLayoutClass = ymaps.templateLayoutFactory.createClass(
						'<div style="width: 100px; height: 123px;">' +
						'<img src="$[properties.iconContent]" alt="$[properties.shopName]" />' +
						'</div>'
					),

					shops = [
						<?php foreach($locations as $location) { ?>
						{
							address: '<?php echo $location['address']; ?>',
							coords: [<?php echo $location['geocode']; ?>],
							name: '<?php echo $location['name']; ?>',
							telephone: '<?php echo $location['phone']; ?>',
							open: '<?php echo $location['open']; ?>',
							href: '<?php echo $location['href']; ?>',
							image: '<?php echo $location['image']; ?>',
						},
						<?php } ?>
					];

					for(var i = 0; i < shops.length; i++) {
						addPlacemark(shops[i]);
					}

					function addPlacemark(shop) {
						var placemark = new ymaps.Placemark(shop.coords, {
							hintContent: 'Наш филиал в ' + shop.name,
							iconContent: shop.image,
							shopName: shop.name,
							balloonContent: 
							'<p class="text-sm text--light-gray">Адрес: </p>' +
							'<p class="mb-15">' + shop.address + '</p>' +
							'<p class="text-sm text--light-gray">Телфон: </p>' +
							'<p class="mb-15">' + shop.telephone + '</p>' +
							'<p class="text-sm text--light-gray">Время работы: </p>' +
							'<p class="mb-15">' + shop.open + '</p>'
						}, {
							iconLayout: 'default#imageWithContent',
							iconImageHref: '',
							iconImageSize: [100, 123],
							iconImageOffset: [-50, -80],
							balloonPanelMaxMapArea: 0,
							hideIconOnBalloonOpen: false,
							iconContentLayout: CustomLayoutClass
						});

						collection.add(placemark);
					}

					var zoomControl = new ymaps.control.ZoomControl({
						options: {
							size: 'small',
							float: 'none',
							zoomDuration: 600,
							position: {
								top: 25,
								right: 25
							}
						}
					});

					filialsMap.geoObjects.add(collection);
					filialsMap.controls.add(zoomControl);
					filialsMap.setBounds(filialsMap.geoObjects.getBounds());

					mapLoaded = true;
					setTimeout(function() {
						$('#filialsMap').removeClass('loading loader--centered');
					}, 1000);
				}
			}
		})
	}
</script>