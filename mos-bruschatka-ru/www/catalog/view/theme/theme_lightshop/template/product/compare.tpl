<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
		<?php echo $content_top; ?>
			<div class="breadcrumb">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
				<?php if($i == 0) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>>🏡</span></a></li>
				<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a data-href="#categories-popup<?php echo $i; ?>" class="js-popup-call-hover-off breadload" data-id="<?php echo $breadcrumb['cat_id']; ?>" data-i="<?php echo $i; ?>" href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
				<?php } else { ?>
					<li class="breadcrumb__list-item"><?php echo $breadcrumb['text']; ?></li>
				<?php } ?>
			<?php } ?>
			</ul>
		</div>
		<h1 class="content__title"><?php echo $heading_title; ?></h1>
			
		<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
		<?php if ($products) { ?>
			<div class="comparison">
				<div class="comparison__head">
					<div class="row clearfix">
						<div class="col-md-4 left_side brr-none">
						</div>
						<div class="col-md-8 right_side">
							<!-- slider-wrap -->
							<div class="slider-wrap">
								<div class="slick-prev2" type="button"><?php echo $text_prev2; ?></div>
								<div class="slider-for1">
								
								<?php foreach ($products as $product) { ?>
									<div class="ares-slider__item">
										<div class="product">
											<a class="cart__close-btn" href="<?php echo $product['remove']; ?>" title="<?php echo $button_remove; ?>">
												<svg class="icon-cross">
													<use xlink:href="#cross">
												</svg>
											</a>
											<div class="product__img-block">
											<?php if ($product['thumb']) { ?>
											<a href="<?php echo $product['href']; ?>">
												<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
											</a>
											<?php } ?>
											</div>
											<div class="product__name">
												<a href="<?php echo $product['href']; ?>" class="link--brown"><?php echo $product['name']; ?></a>
											</div>
											<div class="product__price">
											<?php if ($product['price']) { ?>
											<?php if (!$product['special']) { ?>
											<span class="catalogue__price"><?php echo $product['price']; ?></span> 
											<?php } else { ?>
											<span class="catalogue__price-old"><?php echo $product['price']; ?></span> 
											<span class="catalogue__price"><?php echo $product['special']; ?></span> 
											<?php } ?>
											<?php } ?>
											</div>
											<a class="btn btn--transparent catalogue__btn-cart" onclick="cart.add('<?php echo $product['product_id']; ?>', '<?php echo $product['minimum']; ?>');">
												<span class="catalogue__btn-cart-plus"> + </span>
												<svg class="icon-cart">
													<use xlink:href="#shopping-cart">
												</svg>
											</a>
										</div>
									</div>
									<?php } ?>

								</div>
								<div class="slick-next2" type="button"><?php echo $text_next2; ?></div>
							</div>
							<!-- /slider-wrap -->
						</div>
					</div>
				</div>
				<div class="comparison__cont">
					<div class="row clearfix">
						<div class="col-md-4 left_side">
							<div class="table-wrap">
								<div class="column">
									<div class="cell"><p><?php echo $text_model; ?></p></div>
								</div>
								<div class="column">
									<div class="cell"><p><?php echo $text_manufacturer; ?></p></div>
								</div>
								<div class="column">
									<div class="cell"><p><?php echo $text_availability; ?></p></div>
								</div>
								<?php if ($review_status) { ?>
								<div class="column">
									<div class="cell"><p><?php echo $text_rating; ?></p></div>
								</div>
								<?php } ?>
								<div class="column">
									<div class="cell"><p><?php echo $text_weight; ?></p></div>
								</div>
								<div class="column">
									<div class="cell"><p><?php echo $text_dimension; ?></p></div>
								</div>
								
								<?php foreach ($attribute_groups as $i=> $attribute_group) { ?>
								<div class="column column--attribute-group-name">
									<div class="cell">
										<div class="filter-panel"><div class="text"><span class="icon active"></span><p><?php echo $attribute_group['name']; ?></p></div></div>
									</div>
								</div>
								<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
								<div class="column fill-left">
									<div class="cell"><p><?php echo $attribute['name']; ?></p></div>
								</div>
								<?php } ?>
								<?php } ?>
							</div>
						</div>
						<div class="col-md-8 right_side">
							<!-- slider-wrap -->
							<div class="slider-wrap">
								<div class="slider-nav1">
								
								<?php foreach ($products as $product) { ?>
									<div class="nav-el">
										<div class="table-wrap">
											<div class="column">
												<div class="cell"><p><?php echo $product['model']; ?></p></div>
											</div>
											<div class="column">
												<div class="cell"><p><?php echo $product['manufacturer']; ?></p></div>
											</div>
											<div class="column">
												<div class="cell"><p><?php echo $product['availability']; ?></p></div>
											</div>
											<?php if ($review_status) { ?>
											<div class="column">
												<div class="cell"><p><?php echo $product['rating']; ?>/5. <?php echo $product['reviews']; ?></p></div>
											</div>
											<?php } ?>
											<div class="column">
												<div class="cell"><p><?php echo $product['weight']; ?></p></div>
											</div>
											<div class="column">
												<div class="cell"><p><?php echo $product['length']; ?> x <?php echo $product['width']; ?> x <?php echo $product['height']; ?></p></div>
											</div>
											
											<?php foreach ($attribute_groups as $attribute_group) { ?>
											<div class="column hd-mob">
												<div class="cell"><p>&nbsp;</p></div>
											</div>
											<?php foreach ($attribute_group['attribute'] as $key => $attribute) { ?>
											<?php if (isset($product['attribute'][$key])) { ?>
											<div class="column">
												<div class="cell"><p><?php echo $product['attribute'][$key]; ?></p></div>
											</div>
											<?php } else { ?>
											<div class="column">
												<div class="cell"><p>&nbsp;</p></div>
											</div>
											<?php } ?>
											<?php } ?>
											<?php } ?>
										</div>
									</div>
								<?php } ?>

								</div>
							</div>
							<!-- /slider-wrap -->
						</div>
						</div>
					</div>
				</div>
				
			<?php } else { ?>
			<p><?php echo $text_empty; ?></p>
			<a href="<?php echo $continue; ?>" class="btn"><?php echo $button_continue; ?></a>
			<?php } ?>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>

<?php echo $footer; ?>
<script>
function comparison_slider () {
	$('.slider-for1').slick({
		slidesToShow: <?php echo $compare_total < 4 ? $compare_total : 3 ?>,
		slidesToScroll: 1,
		autoplay: false,
		dots: false,
		infinite: false,
		arrows: true,
		asNavFor: '.slider-nav1',
		responsive: [
			{
				breakpoint: 767,
				settings: {
					slidesToShow: <?php echo $compare_total < 2 ? $compare_total : 2 ?>
				}
			}
		]
	});
	$('.slider-nav1').slick({
		slidesToShow: <?php echo $compare_total < 4 ? $compare_total : 3 ?>,
		slidesToScroll: 1,
		asNavFor: '.slider-for1',
		dots: false,
		infinite: false,
		arrows: true,
		focusOnSelect: true,
		responsive: [
			{
				breakpoint: 767,
				settings: {
					slidesToShow: <?php echo $compare_total < 2 ? $compare_total : 2 ?>
				}
			}
		]
	});
	compSliderArrows();
	$('.slider-for1').on('breakpoint', function(event, slick){
		compSliderArrows();
	});
	$('.slider-nav1').on('breakpoint', function(event, slick){
		compSliderArrows();
	});
}

$(document).on('ready', function() {
	comparison_slider();
});
</script>
</body></html>
