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
			<div class="catalogue__search">
				<div id="content" class="row">
					<div class="col-sm-4">
						<div class="catalogue__search-form">
							<div class="product-page__input-box-row">
								<input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_keyword; ?>" id="input-search">
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="catalogue__search-select">
							<div class="select">
								<select name="category_id" class="select" data-placeholder="<?php echo $text_category; ?>">
									<option value="0"><?php echo $text_category; ?></option>
									<?php foreach ($categories as $category_1) { ?>
									<?php if ($category_1['category_id'] == $category_id) { ?>
									<option value="<?php echo $category_1['category_id']; ?>" selected="selected"><?php echo $category_1['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $category_1['category_id']; ?>"><?php echo $category_1['name']; ?></option>
									<?php } ?>
									<?php foreach ($category_1['children'] as $category_2) { ?>
									<?php if ($category_2['category_id'] == $category_id) { ?>
									<option value="<?php echo $category_2['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $category_2['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_2['name']; ?></option>
									<?php } ?>
									<?php foreach ($category_2['children'] as $category_3) { ?>
									<?php if ($category_3['category_id'] == $category_id) { ?>
									<option value="<?php echo $category_3['category_id']; ?>" selected="selected">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
									<?php } else { ?>
									<option value="<?php echo $category_3['category_id']; ?>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $category_3['name']; ?></option>
									<?php } ?>
									<?php } ?>
									<?php } ?>
									<?php } ?>
								</select>
							</div>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="catalogue__search-radio">
							<div class="product-page__radio-box">
								<?php if ($sub_category) { ?>
								<input type="checkbox" name="sub_category" id="sub_category" value="1" checked="checked">
								<?php } else { ?>
								<input type="checkbox" name="sub_category" id="sub_category" value="1">
								<?php } ?>
								<label for="sub_category">
								<?php echo $text_sub_category; ?>															
								</label>
								<?php if ($description) { ?>
								<input type="checkbox" name="description" value="1" id="description" checked="checked">
								<?php } else { ?>
								<input type="checkbox" name="description" value="1" id="description">
								<?php } ?>
								<label for="description">
								<?php echo $entry_description; ?>														
								</label>
							</div>
						</div>
					</div>
					<div class="col-sm-2">
						<input type="button" value="<?php echo $button_search; ?>" id="button-search" class="btn" style="padding:13px 0;width:100%">
					</div>
				</div>
			</div>

 <?php if ($products) { ?>
		<div class="clearfix"></div>
			<div class="catalogue__content catalogue__content--search">
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
<div class="clearfix"></div>
	<br><p><?php echo $text_empty; ?></p>
 <?php } ?>
 
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	</div>	
	<?php echo $content_bottom; ?>
	</div>
	<input type="hidden" id="url" value='<?php echo $url; ?>'>
	<input type="hidden" id="type" value='product/search'>
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
$('#button-search').bind('click', function() {
	url = 'index.php?route=product/search';

	var search = $('#content input[name=\'search\']').prop('value');

	if (search) {
		url += '&search=' + encodeURIComponent(search);
	}

	var category_id = $('#content select[name=\'category_id\']').prop('value');

	if (category_id > 0) {
		url += '&category_id=' + encodeURIComponent(category_id);
	}

	var sub_category = $('#content input[name=\'sub_category\']:checked').prop('value');

	if (sub_category) {
		url += '&sub_category=true';
	}

	var filter_description = $('#content input[name=\'description\']:checked').prop('value');

	if (filter_description) {
		url += '&description=true';
	}

	location = url;
});

$('#content input[name=\'search\']').bind('keydown', function(e) {
	if (e.keyCode == 13) {
		$('#button-search').trigger('click');
	}
});

$('select[name=\'category_id\']').on('change', function() {
	if (this.value == '0') {
		$('input[name=\'sub_category\']').prop('disabled', true);
	} else {
		$('input[name=\'sub_category\']').prop('disabled', false);
	}
});

$('select[name=\'category_id\']').trigger('change');
--></script>
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
