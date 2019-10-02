<script type="text/javascript"><!--
	// 2017/08/22

	var poip_product_custom = function(){
		poip_product_default.call(this);
	}
	poip_product_custom.prototype = Object.create(poip_product_default.prototype);
	poip_product_custom.prototype.constructor = poip_product_custom;
	
	poip_product_custom.prototype.custom_init = function(){
		
	}
	
	// << ITS OWN FUNCTIONS
	// >> ITS OWN FUNCTIONS
	
	// << ADDITIONAL FUNCTIONS
	// without replacing or stopping original script execution, just addition

	// >> ADDITIONAL FUNCTIONS 
	
	// << REPLACING FUNCTIONS
	// to be called from standard function, to work instead of standard algorithm (prefixes replace_ and if_)

	
	poip_product_custom.prototype.replace_setVisibleImages = function(images, counter) {
		var this_object = this;
		
		if (!counter) counter = 1;
		if (counter == 100) {
			this_object.set_visible_images_timer_id = false;
			return;
		}
		
		// main image slider
		var carousel_selector = '.js-preview-img';
		var $carousel_elem = $(carousel_selector);
		
		// additional images slider
		var carousel_selector_additional = '.js-preview-slider';
		var $carousel_elem_additional = $(carousel_selector_additional);
	
		if ( $carousel_elem.length && $carousel_elem_additional.length ) {
		
			// for thumbs
			if ( !$('#poip_images').length ) {
				var added_imgs = [];
				$carousel_elem.before('<div id="poip_images" style="display:none;"></div>');
				$carousel_elem.find('a').each(function(){
					$('#poip_images').append( $(this).clone().removeClass('js-fancy-img') );
				});
			}
			
			if ( !$('#poip_images_additional').length ) {
				$carousel_elem_additional.before('<div id="poip_images_additional" style="display:none;"></div>');
				$carousel_elem_additional.find('img').each(function(){
					$('#poip_images_additional').append( $(this).clone() );
				});
			}
			
			if ( this_object.set_visible_images_first_call ) {
				if ( !$carousel_elem.is('.slick-initialized') || !$carousel_elem_additional.is('.slick-initialized')	|| document.readyState != "complete" ) {
					this_object.set_visible_images_timer_id = setTimeout(function(){ this_object.replace_setVisibleImages(images, counter+1); } , 100);
					return;
				}
				this_object.set_visible_images_first_call = false;
			} else {
				var current_imgs = [];
				$carousel_elem.find('a').each( function(){
					current_imgs.push($(this).attr('href')); // push all elements, even if image is duplicated
				});
				
				if ( current_imgs.toString() == images.toString() ) {
					this_object.set_visible_images_timer_id = false;
					return; // nothing to change
				}
			}
			
			var elems_cnt = $carousel_elem.find('a').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				$carousel_elem.slick('slickRemove',0);
			}
			
			var elems_cnt = $carousel_elem_additional.find('img').length;
			for (var i = 1; i<=elems_cnt; i++ ) {
				$carousel_elem_additional.slick('slickRemove',0);
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				var poip_img_elem = $('#poip_images a[href="'+images[i]+'"]:first');
				
				if ( poip_img_elem.length && $.inArray(poip_img_elem.attr('href'), shown_imgs) == -1 ) {
					//carousel_elem.slick('addSlide', ''+this_object.getElementOuterHTML($(this))+'' );
					$carousel_elem.slick('slickAdd', '<div class="product-page__img-slider-item">'+this_object.getElementOuterHTML(poip_img_elem.clone().addClass('js-fancy-img'))+'</div>' );
					shown_imgs.push( $(this).attr('href') );
				}
			}
			
			var shown_imgs = [];
			for (var i in images) {
				if ( !images.hasOwnProperty(i) ) continue;
			
				var poip_img = this_object.getImageBySrc(images[i], 'popup');
				if ( poip_img ) {
					var poip_img_elem = $('#poip_images_additional img[src="'+poip_img.thumb+'"]:first');
					
					if ( poip_img_elem.length && $.inArray(poip_img_elem.attr('src'), shown_imgs) == -1 ) {
						$carousel_elem_additional.slick('slickAdd', '<div class="product-page__preview-slider-item">'+this_object.getElementOuterHTML(poip_img_elem)+'</div>' );
						shown_imgs.push( $(this).attr('src') );
					}
				}
			}
			
			fancyImg();
			
			if (poip_settings['img_hover']) {
				$carousel_elem_additional.find('img').mouseover(function(){
					this_object.eventAdditionalImageMouseover(this);
				}); 
			}
			
			$carousel_elem.find('a').click(function(e){
				e.preventDefault();
			});
			
		}
		this_object.set_visible_images_timer_id = false;
	}
	
	poip_product_custom.prototype.if_eventAdditionalImageMouseover = function(img_elem) {
		var this_object = this;
		
		//img_elem.click();
		
		var $slick_img_parent = $(img_elem).parent();
		
		setTimeout(function(){
			if ( $slick_img_parent.length ) {
				$('.js-preview-img').slick('slickGoTo', $slick_img_parent.attr('data-slick-index'));
			}
		}, 10);
		
		return true;
	}

	poip_product_custom.prototype.if_updateZoomImage = function(img_click) {
		var this_object = this;
		
		/*
		this_object.elevateZoomDirectChange(img_click, 0, $('.product-main-image img:first'), 'popup');
		
		return;
		console.debug('if_updateZoomImage');
		
		
		var poip_img = this_object.getImageBySrc(img_click, 'popup');
		// additional slider switch
		var slick_img_parent = $('.js-preview-slider img[src="'+poip_img.thumb+'"]').parent();
		
		setTimeout(function(){
			if ( slick_img_parent.length && slick_img_parent.index() >= 0 ) {
				$('.js-preview-slider').slick('slickGoTo', slick_img_parent.index());
			}
		}, 10);
		
		*/
		
		return true;
	}
	
	
	poip_product_custom.prototype.if_refreshPopupImagesBody = function() {
		return true;
	}
	
	
	// >> REPLACING FUNCTIONS	

	var poip_product = new poip_product_custom();

//--></script>