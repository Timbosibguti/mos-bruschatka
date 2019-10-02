<?php echo $header; ?>

<!--MAIN CONTENT CATALOGUE-->
<main <?php echo $schema ? 'itemscope itemtype="http://schema.org/Product"' : ''?> class="main--catalogue" id="wrapper">
	<div class="container">
		<div class="tabs__nav nav-category">
			<ul class="tabs__list">
			<?php foreach ($subCategories as $subCategory) { ?>
				<li class="tabs__list-item">
					<a href="<?php echo $subCategory['href']; ?>"
					   class="tabs__link js-ajax-nav-category-link <?php echo (strpos($subCategory['href'], $_SERVER['REQUEST_URI']) !== false) ? 'active' : ''; ?>">
						<?php echo $subCategory['name']; ?>
					</a>
				</li>
			<?php } ?>
			</ul>
		</div>
	</div>

<?php if ($content_top) { ?>
	<div class="container">
	<?php echo $content_top; ?>
	</div>
<?php } ?>

<?php if ($schema) { ?>
	<!-- Microdata -->
	<div itemtype="http://schema.org/AggregateOffer" itemscope="" itemprop="offers">
		<meta content="<?php echo $product_total; ?>" itemprop="offerCount"> <!-- Number of goods -->
		<meta content="<?php echo (int)$maxPrice; ?>" itemprop="highPrice"> <!-- The highest price for a product -->
		<meta content="<?php echo (int)$minPrice; ?>" itemprop="lowPrice"> <!-- The lowest price for the goods -->
		<meta content="<?php echo $currency; ?>" itemprop="priceCurrency"> <!-- Currency -->
	</div>
<?php } ?>

	<div class="catalogue" id="catalogue">

		<div class="container">
			<?php if (isset($heading_title)) { ?>
				<h1 class="main-title"><?php echo $heading_title; ?></h1>
			<?php } ?>

			<div class="row">
				<?php echo $column_left ? $column_left : ''?>
				<section class="col">
					<?php echo $column_right ? $column_right : ''?>
					
					<div class="catalogue__content js-catalogue-content">
						<div class="catalogue__content-top js-catalogue-content-top">
							<?php if ($category_sorts) { ?>
							<div class="catalogue__sort">
								<div class="catalogue__sort-options">
									<span class="catalogue__sort-label">Сортировать: </span>
									<?php foreach ($sorts as $sort) { ?>
										<a href="<?php echo $sort['href']; ?>" title="-" class="catalogue__sort-link js-catalog-sort"><?php echo $sort['text']; ?><i class="icon icon--arrow-down"></i></a>
									<?php } ?>
								</div>
							</div>
							<?php } ?>
						</div>

						<div  id="mainContainer" class="catalogue__content-lists">
						<!-- CATALOGUE LISTS-->
						<div  class="catalogue__products-lists js-lists <?php echo $viewSub; ?> active">
							<div class="row">
								<?php foreach($products as $product) { ?>
								<div class="col-6 col-md-4 catalogue__products-list-item">
									<?php require( DIR_TEMPLATE . 'theme_lightshop/template/product/products.tpl' ); ?>
								</div>
								<?php } ?>
							</div>
						</div>
						<!-- CATALOGUE LISTS END-->
						</div>

						<!-- CATALOGUE PAGINATION-->
						<div class="catalogue__content-bottom">
							<div class="catalogue__pagination">
								<?php echo $pagination; ?>
							</div>
							<input type="hidden" id="path_id" value='<?php echo $path; ?>'>
							<input type="hidden" id="url" value='<?php echo $url; ?>'>
						</div>
						<!-- CATALOGUE PAGINATION END-->
					</div>
				</section>
			</div><!-- grid -->
			<?php if ((!$categories || $category_categories == 0)){ ?>
			<div class="catalogue__more-about">
				<h2 class="category__title" style="display: none;"><?php echo $heading_title; ?></h2>
				<?php if ($description) { ?>					
					<div class="catalogue__description" id="jsCatDesc">
						<div class="editor"><?php echo $description; ?></div>
					</div>	
					<div class="text-center">
						<button type="button" class="btn-rounded" id="jsCatDescFullHeight"><i class="icon icon--arrow-down-obtuse"></i></button>
					</div>
				<?php } ?>
			</div>
			<?php } ?>
		</div><!-- container end -->
	<?php echo $content_bottom; ?>
	</div><!-- catalogue end -->

<input type="hidden" id="path" value='<?php echo $path; ?>'>
<input type="hidden" id="cat_url" value='<?php echo $cat_url; ?>'>
<input type="hidden" id="currencydata" value='<?php echo $currencydata; ?>'>
</main>
<?php echo $footer; ?>

<script type="text/javascript">

    (function($){
        $.fn.livePrice = function (productId, parameters, callback) {
            jQuery.post($.fn.liveopencart_LivePrice().params.request_url + '&product_id=' + productId, parameters)
				.success(function (json){
					callback(json);
				});
        };

        $('body').on('click', '.product-card__colors .input-radio', function () {
            let productCard = $(this).closest('.product-card');
            let productImage = productCard.find('.product-card__img img');

            let imageByColorUrl = $(this).data('image');
            if (imageByColorUrl) {
                productImage.attr('src', imageByColorUrl);
			} else {
                productImage.attr('src', productCard.data('image'));
			}

            let params = productCard.data('params');
            params[$(this).attr('name')] = $(this).val();
			productCard.data('params', params);

            $.fn.livePrice(productCard.data('product-id'), params, function (response) {
                let parsedResponse = jQuery('<div/>').html(response.htmls.html);

                parsedResponse.find('.text--yellow').remove();

                productCard.find('.product-card__price').html(
                    'от ' + parsedResponse.find('h2').html()
				);
                productCard.find('.product-card__price--old').html(
                    'от ' + parsedResponse.find('.product-page__price').html()
				);
            });
        });

    })(jQuery);

</script>

</body></html>
