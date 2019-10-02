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
	<div class="catalogue">
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">	
		
<?php if ($products) { ?>
			<div class="catalogue__content">
				<div class="catalogue__content-top">
					<div class="catalogue__sort">
						<?php if ($category_sorts) { ?>
						<div class="catalogue__sort-sorts">
							<span class="select select--squer select--transparent">
								<select data-placeholder="<?php echo $text_sort; ?>" class="select select--transparent"  onchange="location = this.value;">
								<option><?php echo $text_sort; ?></option>
									<?php foreach ($sorts as $sorts) { ?>
										<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
										<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $text_sort; ?> <?php echo $sorts['text']; ?></option>
										<?php } else { ?>
										<option value="<?php echo $sorts['href']; ?>"><?php echo $text_sort; ?> <?php echo $sorts['text']; ?></option>
										<?php } ?>
									<?php } ?>
								
								</select>
							</span>
						</div>
						<?php } ?>
						<?php if ($category_limits) { ?>
						<div class="catalogue__sort-limits">
							<span class="select select--squer select--transparent">
								<select data-placeholder="<?php echo $text_limit; ?>" class="select select--transparent"  onchange="location = this.value;">
								<option><?php echo $text_limit; ?></option>
								<?php foreach ($limits as $limits) { ?>
								<?php if ($limits['value'] == $limit) { ?>
								<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $text_limit; ?> <?php echo $limits['text']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $limits['href']; ?>"><?php echo $text_limit; ?> <?php echo $limits['text']; ?></option>
								<?php } ?>
								<?php } ?>
								</select>
							</span>
						</div>
						<?php } ?>
					</div>
					<div class="catalogue__product-view">
						<div class="product-view">
							<ul class="product-view__list js-drop-select-drop">
								<li class="product-view__list-item active js-list-select js-select-lists" data-columns="main">
									<a href="#" class="product-view__link">
										<svg class="icon-tile-three">
											<use xlink:href="#tile-three"></use>
										</svg>
									</a>
								</li>
								<li class="product-view__list-item  js-list-select js-select-table" data-columns="table">
									<a href="#" class="product-view__link">
										<svg class="icon-table">
											<use xlink:href="#table"></use>
										</svg>
									</a>
								</li>
								<li class="product-view__list-item  js-list-select js-select-full-list" data-columns="list"> 
									<a href="#" class="product-view__link">
										<svg class="icon-tile-wide">
											<use xlink:href="#tile-wide"></use>
										</svg>
									</a>
								</li>
								<li class="product-view__list-item js-list-select js-select-four-items product-view__list-item--hide-mobile" data-columns="main-four">
									<a href="#" class="product-view__link">
										<svg class="icon-tile-four">
											<use xlink:href="#tile-four"></use>
										</svg>
									</a>
								</li>
								<li class="product-view__list-item js-list-select js-select-five-items product-view__list-item--hide-mobile" data-columns="main-five">
									<a href="#" class="product-view__link">
										<svg class="icon-tile-five">
											<use xlink:href="#tile-five"></use>
										</svg>
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
				<!-- CATALOGUE CONTENT (LISTS)-->
				<div  id="mainContainer" class="catalogue__content-lists">
					<?php require( DIR_APPLICATION.'view/theme/theme_lightshop/template/product/category_'.$view.'.tpl' ); ?>

					<!-- CATALOGUE LISTS END-->
				</div>
				<!-- CATALOGUE CONTENT (LISTS) END-->
				
				<!-- CATALOGUE PAGINATION-->
				<div class="catalogue__content-bottom">
					<div class="catalogue__pagination">
						<?php echo $pagination; ?>
					</div>
				</div>
				<!-- CATALOGUE PAGINATION END-->
			</div>
<?php } else { ?>
	<p><?php echo $text_empty; ?></p>
	<div class="checkout__button-box">
	<a href="<?php echo $continue; ?>" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#arrow-long-right"></use></svg></a>
	</div>
 <?php } ?>
 
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	</div>	
	<?php echo $content_bottom; ?>
	</div>
	<input type="hidden" id="popuptype" value="special">
	<input type="hidden" id="type" value='product/special'>
	<input type="hidden" id="url" value='<?php echo $url; ?>'>
	<div id="popupprod" class="catalogue__product-detail js-tabs-box js-product-view"></div>
	
</main>
		<?php if ($buy_click['status']) { ?>
		<div class="popup-simple" id="popup-buy-click">
			<div class="popup-simple__inner" >
				<form>
				<h3><?php echo $text_lightshop_buy_click; ?></h3>
					<?php require( DIR_TEMPLATE . 'theme_lightshop/template/product/buyclick_form.tpl' ); ?>
					<button type="button" class="btn js-btn-add-cart-fast-popup quickbuy-send"><?php echo $button_fastorder_sendorder; ?></button>
					<input name="quantity"  value="" id="cat_qty" type="hidden">
					<input name="product_id" value="" id="cat_prod_id" type="hidden">
					<input name="redirect"  value="1" class="fast-redirect" type="hidden">
					<?php if ($text_lightshop_pdata) { ?>
					<div class="popup-simple__inner-personal-data"><?php echo $text_lightshop_pdata; ?></div>
					<?php } ?>
				</form>
			</div>	
		</div>
		<?php } ?>

<?php echo $footer; ?>
<script type="text/javascript"><!--
$(document).on('ready', function() {
	var view = '<?php echo $viewLayer; ?>';
	if(window.innerWidth < 767) {
		view = '<?php echo $viewLayerM; ?>';
		$('.js-lists').removeClass('catalogue__products-list--four');
		$('.js-lists').removeClass('catalogue__products-list--five');
	}else{
		var v  = '<?php echo $viewSub; ?>';
		$('.js-lists').removeClass('catalogue__products-list--four');
		$('.js-lists').removeClass('catalogue__products-list--five');
		if(v != ''){
			$('.js-lists').addClass('active ' + v);
		}		
	}
	
	if (localStorage.getItem('display')) {
//		view = localStorage.getItem('display');
	}

	$(".product-view__list-item").removeClass('active'); 
	$(".product-view__list-item").each(function(indx, element){
		if($(element).attr('data-columns') == view){
			$(element).addClass('active');
		}		
	});
	$('.product-view__list .active').insertBefore($(".product-view__list-item").first());	
});
//--></script>
</body></html>
