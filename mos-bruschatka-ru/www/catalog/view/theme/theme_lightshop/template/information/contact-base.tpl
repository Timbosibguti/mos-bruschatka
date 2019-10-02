<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><?php echo $breadcrumb['text']; ?></li>		
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	</div>
	
<?php if ($contact_map) { ?>
	<?php if ($locations) { ?>
	
	<div class="locations-select">
		<div class="container">
		<select id="js-geocode" class="select--squer select--map select" data-placeholder="<?php echo $text_store; ?>">
			<option><?php echo $text_store; ?></option>
			<option value="<?php echo $geocode; ?>" ><?php echo $store; ?></option>
			<?php foreach ($locations as $location) { ?>
			<option value="<?php echo $location['geocode']; ?>"><?php echo $location['name']; ?></option>
			<?php } ?>
		</select>
		</div>
	</div>
	<?php } ?>
<?php } ?>
	
<?php if ($contact_map == 'google_map') { ?>
	<div class="js-map" id="js-map"></div>
<?php } elseif ($contact_map == 'yandex_map') { ?>
	<div class="js-yamap-wrapper">
		<div class="js-yamap" id="js-yamap"></div>
	</div>
<?php } else { ?>
	<div class="disabled-map">
			<div class="popup-simple__inner">
				 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<h3><?php echo $text_contact; ?></h3>
					<input name="name" id="input-name" type="text" placeholder="* <?php echo $entry_name; ?>" value="<?php echo $name; ?>">
              <?php if ($error_name) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_name; ?></div>
              <?php } ?>
					<input name="email" id="input-email" type="text" placeholder="* <?php echo $entry_email; ?>" value="<?php echo $email; ?>">
              <?php if ($error_email) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_email; ?></div>
              <?php } ?>
					<textarea rows="5" name="enquiry" id="input-enquiry" placeholder="* <?php echo $entry_enquiry; ?>"><?php echo $enquiry; ?></textarea>
              <?php if ($error_enquiry) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_enquiry; ?></div>
              <?php } ?>
					<?php echo $captcha; ?>
					<button type="submit" id="contact_send" class="btn"><?php echo $button_submit; ?></button>
				<?php if ($text_lightshop_pdata) { ?>
					<div class="popup-simple__inner-personal-data"><?php echo $text_lightshop_pdata; ?></div>
				<?php } ?>
				</form>			
			</div>
	</div>
<?php } ?>

<div <?php echo $schema ? 'itemscope itemtype="http://schema.org/Organization"' : ''?> class="contacts">
<?php echo $schema ? '<meta itemprop="name" content="' . $store . '">' : ''?>
	<div class="container">
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">	
		<div class="contacts__info">
			<div class="contacts__info-inner">
				<div <?php echo $schema ? 'itemprop="address" itemscope itemtype="http://schema.org/PostalAddress"' : ''?> class="contacts__info-item">
					<span class="contacts__info-icon">
						<svg class="icon-location-pin">
							<use xlink:href="#location-pin"></use>
						</svg>
					</span>
					<address <?php echo $schema ? 'itemprop="streetAddress"' : ''?> class="contacts__address">
						<?php echo $address; ?>
					</address>
				</div>
				<?php if ($phone_1 || $phone_2) { ?>
				<div class="contacts__info-item">
					<span class="contacts__info-icon">
						<svg class="icon-phone">
							<use xlink:href="#phone"></use>
						</svg>
					</span>
					<div class="contacts__numbers">
					<?php if ($phone_1) { ?>
						<a <?php echo $schema ? 'itemprop="telephone" ' : ''; echo 'href="tel:' . preg_replace('/[^0-9]/', '', $phone_1) . '" rel="nofollow"';?> class="contacts__numbers-item">
							<?php echo $phone_1; ?>
						</a>
					<?php } ?>
					<?php if ($phone_2) { ?>
						<a <?php echo $schema ? 'itemprop="telephone" ' : ''; echo 'href="tel:' . preg_replace('/[^0-9]/', '', $phone_2) . '" rel="nofollow"';?> class="contacts__numbers-item">
							<?php echo $phone_2; ?>
						</a>
					<?php } ?>
					</div>
				</div>
				<?php } ?>
				<?php if ($shop_email) { ?>
				<div class="contacts__info-item">
					<span class="contacts__info-icon">
						<svg class="icon-mail">
							<use xlink:href="#mail"></use>
						</svg>
					</span>
					<div class="contacts__info-text">
						<span class="contacts__info-title">
							<?php echo $text_lightshop_support; ?>
						</span>
						<a href="mailto:<?php echo $shop_email; ?>" class="contacts__mail">
							<span <?php echo $schema ? 'itemprop="email"' : ''?>><?php echo $shop_email; ?></span>
						</a>
					</div>
				</div>
				<?php } ?>
			</div>
		</div>

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
		
<?php if ($contact_map) { ?>
<div style="display:none;"><a href="#contact-form"  id="contact_popup" class="btn btn--transparent js-fancy-popup"><?php echo $text_contact; ?></a></div>		
		<div class="popup-simple" id="contact-form">
			<div class="popup-simple__inner">
				 <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
					<h3><?php echo $text_contact; ?></h3>
					<input name="name" id="input-name" type="text" placeholder="* <?php echo $entry_name; ?>" value="<?php echo $name; ?>">
              <?php if ($error_name) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_name; ?></div>
              <?php } ?>
					<input name="email" id="input-email" type="text" placeholder="* <?php echo $entry_email; ?>" value="<?php echo $email; ?>">
              <?php if ($error_email) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_email; ?></div>
              <?php } ?>
					<textarea rows="5" name="enquiry" id="input-enquiry" placeholder="* <?php echo $entry_enquiry; ?>"><?php echo $enquiry; ?></textarea>
              <?php if ($error_enquiry) { ?>
              <div class="popup-simple__inner-error-text"><?php echo $error_enquiry; ?></div>
              <?php } ?>
					<?php echo $captcha; ?>
					<button type="submit" id="contact_send" class="btn"><?php echo $button_submit; ?></button>
				<?php if ($text_lightshop_pdata) { ?>
					<div class="popup-simple__inner-personal-data"><?php echo $text_lightshop_pdata; ?></div>
				<?php } ?>
				</form>			
			</div>
		</div>
<?php } ?>		
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>			
	</div>
</div>

	<div class="container">
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?>

<?php if ($contact_map == 'google_map') { ?>

 <!-- Goggle Map :: Start -->
<script>

 jQuery.getScript('https://maps.googleapis.com/maps/api/js?key=<?php echo $api_key; ?>&sensor=false&extension=.js', function (){
	
	function LightshopMarker(latlng, map, args) {
		this.latlng = latlng;	
		this.args = args;	
		this.setMap(map);	
		//fancyPopUp();
	}

	LightshopMarker.prototype = new google.maps.OverlayView();

	LightshopMarker.prototype.draw = function() {
		var self = this;
		var div = this.div;
		
		if (!div) {
			div = this.div = document.createElement('div');
			div.className = 'contacts__marker';
			div.style.position = 'absolute';
			div.style.cursor = 'default';
			div.innerHTML = self.args.m_html;
			if (typeof(self.args.marker_id) !== 'undefined') {
				div.dataset.marker_id = self.args.marker_id;
			}
			var panes = this.getPanes();
			panes.overlayImage.appendChild(div);


		}

		var point = this.getProjection().fromLatLngToDivPixel(this.latlng);

		if (point) {
		div.style.left = (point.x ) + 'px';
		div.style.top = (point.y ) + 'px';
		}
		fancyImg();
		fancyPopUp();
	};

	google.maps.Map.prototype.LightshopCenterOffset= function(latlng, offsetX, offsetY) {
		var map = this;
		var ov = new google.maps.OverlayView(); 
		ov.onAdd = function() { 
			var proj = this.getProjection(); 
			var aPoint = proj.fromLatLngToContainerPixel(latlng);
			aPoint.x = aPoint.x+offsetX;
			aPoint.y = aPoint.y+offsetY;
			map.setCenter(proj.fromContainerPixelToLatLng(aPoint));
		}
		ov.draw = function() {}; 
		ov.setMap(this); 
	};

	var map;

	function initialize() {
		 	map = new google.maps.Map(document.getElementById('js-map'), {
				zoom: <?php echo $zoom; ?>,
				zoomControl: <?php echo $zoom_control ? 'true' : 'false' ?>,
				disableDoubleClickZoom: true,
				mapTypeControl: false,
				scaleControl: false,
				scrollwheel: false,
				panControl: false,
				streetViewControl: false,
				draggable : true,
				center: new google.maps.LatLng(<?php echo $geocode; ?>),
			});
			
			map.LightshopCenterOffset(new google.maps.LatLng(<?php echo $geocode; ?>), 143, 200);

			var overlay = new LightshopMarker(
				new google.maps.LatLng(<?php echo $geocode; ?>), 
				map,
				{
					//marker_id: 'id-0',
					m_html: '<span class="contacts__marker-location"></span>' + 
							'<div class="contacts__marker-inner">' +
							'<span class="contacts__marker-close"></span>' +
'<div class="contacts__marker-item"><div class="contacts__marker-adress"><span class="contacts__marker-icon"><svg class="icon-location-pin"><use xlink:href="#location-pin"></use></svg><?php echo str_replace(array("\r", "\n"), '', $address); ?></span></div></div>' +
<?php if ($open) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-open"><?php echo str_replace(array("\r", "\n"), '', $open); ?></div></div>' +
<?php } ?>
'<div class="contacts__marker-item"><div class="contacts__marker-telephone"><?php echo $telephone; ?></div></div>' +
<?php if ($fax) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-fax"><?php echo $fax; ?></div></div>' +
<?php } ?>
<?php if ($image) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-img"><a class="js-fancy-img" href="<?php echo $image; ?>"><img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>"></a></div></div>' +
<?php } ?>
<?php if ($comment) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-comment"><?php echo str_replace(array("\r", "\n"), '', $comment); ?></div></div>' +
<?php } ?>
'<div class="contacts__marker-btn"><a href="#contact-form" class="btn btn--transparent js-fancy-popup"><?php echo $text_contact; ?></a></div>' +
'</div>'
				}
			);
			
<?php if ($locations) { ?>
<?php foreach ($locations as $location) { ?>
			var overlay = new LightshopMarker(
				new google.maps.LatLng(<?php echo $location['geocode']; ?>), 
				map,
				{
					//marker_id: 'id-<?php echo $location['location_id']; ?>',
					m_html: '<span class="contacts__marker-location"></span>' + 
						'<div class="contacts__marker-inner">' +
							'<span class="contacts__marker-close"></span>' +
'<div class="contacts__marker-item"><div class="contacts__marker-adress"><span class="contacts__marker-icon"><svg class="icon-location-pin"><use xlink:href="#location-pin"></use></svg><?php echo str_replace(array("\r", "\n"), '', $location['address']); ?></span></div></div>' +
<?php if ($location['open']) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-open"><?php echo str_replace(array("\r", "\n"), '', $location['open']); ?></div></div>' +
<?php } ?>
'<div class="contacts__marker-item"><div class="contacts__marker-telephone"><?php echo $location['telephone']; ?></div></div>' +
<?php if ($location['fax']) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-fax"><?php echo $location['fax']; ?></div></div>' +
<?php } ?>
<?php if ($location['image']) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-img"><a class="js-fancy-img" href="<?php echo $location['image']; ?>"><img src="<?php echo $location['image']; ?>" alt="<?php echo $location['name']; ?>" title="<?php echo $location['name']; ?>"></a></div></div>' +
<?php } ?>
<?php if ($location['comment']) { ?>
'<div class="contacts__marker-item"><div class="contacts__marker-comment"><?php echo str_replace(array("\r", "\n"), '', $location['comment']); ?></div></div>' +
<?php } ?>
'<div class="contacts__marker-btn"><a href="#contact-form" class="btn btn--transparent js-fancy-popup"><?php echo $text_contact; ?></a></div>' +
'</div>'
				}
			);
<?php } ?>
<?php } ?>

	}

	google.maps.event.addDomListener(window, 'load', initialize);

	jQuery(document).on('change','#js-geocode',function() {
		var latlng = jQuery(this).val().split(','),
			newlat = 1*latlng[0],
			newlng = 1*latlng[1];
			
			map.LightshopCenterOffset(new google.maps.LatLng(newlat, newlng), 143, 200);


			$('.contacts__marker').removeClass('is-hide');

	});
});

$(document).on('ready', function() {
	var $errors = $('#contact-form .popup-simple__inner-error-text') ;
	if($errors.length){
		$("#contact_popup").trigger('click');
	}
});


$(document).on('click', '.contacts__marker-close', function(event) {
	event.preventDefault();
	$(this).closest('.contacts__marker').addClass('is-hide');
});


$(document).on('click', '.contacts__marker-location', function(event) {
	event.preventDefault();
	$(this).closest('.contacts__marker').removeClass('is-hide');
});

</script>

 <!-- Goggle Map :: End -->

<?php } elseif ($contact_map == 'yandex_map') { ?>

<!-- Yandex Map :: Start -->

<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU"></script>
<script>


	var myPlacemark = [];

	ymaps.ready(function () {


		var myMap = new ymaps.Map('js-yamap', {
	            center: [<?php echo $geocode; ?>],
	            zoom: <?php echo $zoom; ?>,
	            controls: []
	        }, {
	            searchControlProvider: 'yandex#search'
	        }),

	    	// Создание макета балуна
	        MyBalloonLayout = ymaps.templateLayoutFactory.createClass(
            	'<div class="contacts__marker">' +
	                '<span class="contacts__marker-arrow"></span>' +
	                '<div class="contacts__marker-inner">' +
	                	'<span class="contacts__marker-close"></span>' +
	                	'$[[options.contentLayout observeSize minWidth=220 maxWidth=220 maxHeight=500]]' +
	                '</div>' +
                '</div>', {
                /**
                 * Строит экземпляр макета на основе шаблона и добавляет его в родительский HTML-элемент.
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/layout.templateBased.Base.xml#build
                 * @function
                 * @name build
                 */
                build: function () {
                    this.constructor.superclass.build.call(this);

                    this._$element = $('.contacts__marker', this.getParentElement());

                    this.applyElementOffset();

                    this._$element.find('.contacts__marker-close')
                        .on('click', $.proxy(this.onCloseClick, this));
                },

                /**
                 * Удаляет содержимое макета из DOM.
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/layout.templateBased.Base.xml#clear
                 * @function
                 * @name clear
                 */
                clear: function () {
                    this._$element.find('.contacts__marker-close')
                        .off('click');

                    this.constructor.superclass.clear.call(this);
                },

                /**
                 * Метод будет вызван системой шаблонов АПИ при изменении размеров вложенного макета.
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/IBalloonLayout.xml#event-userclose
                 * @function
                 * @name onSublayoutSizeChange
                 */
                onSublayoutSizeChange: function () {
                    MyBalloonLayout.superclass.onSublayoutSizeChange.apply(this, arguments);

                    if(!this._isElement(this._$element)) {
                        return;
                    }

                    this.applyElementOffset();

                    this.events.fire('shapechange');
                },

                /**
                 * Сдвигаем балун, чтобы "хвостик" указывал на точку привязки.
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/IBalloonLayout.xml#event-userclose
                 * @function
                 * @name applyElementOffset
                 */
                applyElementOffset: function () {
                    // this._$element.css({
                    //     left: -(this._$element[0].offsetWidth / 2),
                    //     top: -(this._$element[0].offsetHeight + this._$element.find('.contacts__marker-arrow')[0].offsetHeight)
                    // });
                },

                /**
                 * Закрывает балун при клике на крестик, кидая событие "userclose" на макете.
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/IBalloonLayout.xml#event-userclose
                 * @function
                 * @name onCloseClick
                 */
                onCloseClick: function (e) {
                    e.preventDefault();

                    this.events.fire('userclose');
                },

                /**
                 * Используется для автопозиционирования (balloonAutoPan).
                 * @see https://api.yandex.ru/maps/doc/jsapi/2.1/ref/reference/ILayout.xml#getClientBounds
                 * @function
                 * @name getClientBounds
                 * @returns {Number[][]} Координаты левого верхнего и правого нижнего углов шаблона относительно точки привязки.
                 */
                getShape: function () {
                    if(!this._isElement(this._$element)) {
                        return MyBalloonLayout.superclass.getShape.call(this);
                    }

                    var position = this._$element.position();

                    return new ymaps.shape.Rectangle(new ymaps.geometry.pixel.Rectangle([
                        [position.left, position.top], [
                            position.left + this._$element[0].offsetWidth,
                            position.top + this._$element[0].offsetHeight - 40
                        ]
                    ]));
                },

                /**
                 * Проверяем наличие элемента (в ИЕ и Опере его еще может не быть).
                 * @function
                 * @private
                 * @name _isElement
                 * @param {jQuery} [element] Элемент.
                 * @returns {Boolean} Флаг наличия.
                 */
                _isElement: function (element) {
                    return element && element[0] && element.find('.contacts__marker-arrow')[0];
                }
            }),

	    	// Создание вложенного макета содержимого балуна.
	        MyBalloonContentLayout = ymaps.templateLayoutFactory.createClass(
	            '$[properties.balloonContent]'
	        );

	    
		// myMap.controls.add('zoomControl');
		myMap.behaviors.disable('scrollZoom'); 
		
<?php if ($zoom_control) { ?>
		myMap.controls.add('zoomControl', {
		    float: 'none',
		    size: 'small',
		    position: {
		        right: 20,
		        bottom: 120
		    }
		});
<?php } ?>


		// Создание метки с пользовательским макетом балуна.
        myPlacemark[0] = new ymaps.Placemark([<?php echo $geocode; ?>], {
            balloonContent: 
            	'<div class="contacts__marker-item">' +
            		'<div class="contacts__marker-adress">' +
            			'<span class="contacts__marker-icon">' +
            				'<svg class="icon-location-pin">' +
            					'<use xlink:href="#location-pin"></use>' +
            				'</svg>' +
            				'<?php echo str_replace(array("\r", "\n"), '', $address); ?>' +
            			'</span>' +
            		'</div>' + 
            	'</div>' +
				<?php if ($open) { ?>
				'<div class="contacts__marker-item">' +
					'<div class="contacts__marker-open"><?php echo str_replace(array("\r", "\n"), '', $open); ?></div>' +
				'</div>' +
				<?php } ?>
				'<div class="contacts__marker-item">' +
					'<div class="contacts__marker-telephone"><?php echo $telephone; ?></div>'+
				'</div>' +
				<?php if ($fax) { ?>
				'<div class="contacts__marker-item">' +
					'<div class="contacts__marker-fax"><?php echo $fax; ?></div>'+
				'</div>' +
				<?php } ?>
				<?php if ($image) { ?>
				'<div class="contacts__marker-item">' +
					'<div class="contacts__marker-img">' +
						'<a href="<?php echo $image; ?>" class="js-fancy-img">' +
							'<img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>">' +
						'</a>' +
					'</div>' +
				'</div>' +
				<?php } ?>
				<?php if ($comment) { ?>
				'<div class="contacts__marker-item">' +
					'<div class="contacts__marker-comment">' +
						'<?php echo str_replace(array("\r", "\n"), '', $comment); ?>' +
					'</div>' +
				'</div>' +
				<?php } ?>
				'<div class="contacts__marker-btn">' +
					'<a href="#contact-form" class="btn btn--transparent js-fancy-popup"><?php echo $text_contact; ?></a>' +
				'</div>'
        }, {
            balloonShadow: false,
            balloonLayout: MyBalloonLayout,
            balloonContentLayout: MyBalloonContentLayout,
            balloonPanelMaxMapArea: 0,
            hideIconOnBalloonOpen: false,
            balloonOffset: [40, -40],
            balloonAutoPan: false
        });


		myMap.geoObjects.add(myPlacemark[0]);
		myPlacemark[0].balloon.open();


		// Создание других меток если из больше одной с пользовательским макетом балуна.

		// Добавляем метки с id в Массив
		$i = 1;

		<?php if ($locations) { ?>
			<?php foreach ($locations as $location) { ?>

				var id = $i++;

				// Создание метки с пользовательским макетом балуна.
		        myPlacemark[id] = new ymaps.Placemark([<?php echo $location['geocode']; ?>], {
		            balloonContent: 
		            	'<div class="contacts__marker-item">' +
		            		'<div class="contacts__marker-adress">' +
		            			'<span class="contacts__marker-icon">' +
		            				'<svg class="icon-location-pin">' +
		            					'<use xlink:href="#location-pin"></use>' +
		            				'</svg>' +
		            				'<?php echo str_replace(array("\r", "\n"), '', $location["address"]); ?>' +
		            			'</span>' +
		            		'</div>' + 
		            	'</div>' +
						<?php if ($location['open']) { ?>
						'<div class="contacts__marker-item">' +
							'<div class="contacts__marker-open"><?php echo str_replace(array("\r", "\n"), '', $open); ?></div>' +
						'</div>' +
						<?php } ?>
						'<div class="contacts__marker-item">' +
							'<div class="contacts__marker-telephone"><?php echo $location["telephone"]; ?></div>'+
						'</div>' +
						<?php if ($location['fax']) { ?>
						'<div class="contacts__marker-item">' +
							'<div class="contacts__marker-fax"><?php echo $location["fax"]; ?></div>'+
						'</div>' +
						<?php } ?>
						<?php if ($location['image']) { ?>
						'<div class="contacts__marker-item">' +
							'<div class="contacts__marker-img">' +
								'<a href="<?php echo $image; ?>" class="js-fancy-img">' +
									'<img src="<?php echo $image; ?>" alt="<?php echo $store; ?>" title="<?php echo $store; ?>">' +
								'</a>' +
							'</div>' +
						'</div>' +
						<?php } ?>
						<?php if ($location['comment']) { ?>
						'<div class="contacts__marker-item">' +
							'<div class="contacts__marker-comment">' +
								'<?php echo str_replace(array("\r", "\n"), '', $location["comment"]); ?>' +
							'</div>' +
						'</div>' +
						<?php } ?>
						'<div class="contacts__marker-btn">' +
							'<a href="#contact-form" class="btn btn--transparent js-fancy-popup"><?php echo $text_contact; ?></a>' +
						'</div>'
		        }, {
		            balloonShadow: false,
		            balloonLayout: MyBalloonLayout,
		            balloonContentLayout: MyBalloonContentLayout,
		            balloonPanelMaxMapArea: 0,
		            hideIconOnBalloonOpen: false,
		            balloonOffset: [40, -40],
		            balloonAutoPan: false
		        });

				myMap.geoObjects.add(myPlacemark[id]);
				

			<?php } ?>
		<?php } ?>




		myMap.geoObjects.events.add([
			'balloonopen'
			], function (e) {
			var geoObject = e.get('target');
			myMap.panTo(geoObject.geometry.getCoordinates(), {
				delay: 0
			});
		});

	
		$(document).on('change','#js-geocode', function(e) {

			var latlng = $(this).val().split(','),
				index  = $(this).find(':selected').index() - 1;

			myMap.panTo([latlng], {
			    flying: false,
			    safe: false,
			    duration: 700
			}).then(function(){
				

				setTimeout(function() {

					myPlacemark[index].balloon.open();

				}, 350);



			});


		});


		$(document).on('click', '.js-fancy-popup', function(event) {

			event.preventDefault();

			var id = $(this).attr('href');

			$.fancybox.open({
				src  : id,
				type : 'inline',
				slideClass : 'popup-simple--fancybox', 
				autoFocus : false,
				touch: false,
				btnTpl : {
					smallBtn   : '<button data-fancybox-close class="popup-simple__close" title="{{CLOSE}}">x</button>'
				}
				
			});

		});	



		$(document).on('ready', function() {
			var $errors = $('#contact-form .popup-simple__inner-error-text') ;
			if($errors.length){
				console.log($errors.length);
				$("#contact_popup").trigger('click');
			}
		});


	});


</script>
 <!-- Yandex Map :: End -->
 
<?php } ?>

</body></html>