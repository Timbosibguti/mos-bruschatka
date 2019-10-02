<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
	<main <?php echo $schema ? 'itemscope itemtype="http://schema.org/Product"' : ''?> class="section-sm">
		<div class="container">
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
		</div><!-- container -->

		<?php echo $content_top ? $content_top : '' ?>

		<div class="container">
			<div class="grid">
				<?php echo $column_left ? '<aside class="aside">' . $column_left . '</aside>' : ''?>
				<section class="main-section">
					<div class="product-page">
						<form action="javascript:void(0);" method="post" id="buyProduct" class="row">
							<div class="col-8 product-page__col-left">
								<h1 <?php echo $schema ? 'itemprop="name"' : ''?> class="product-page__name-media"><?php echo $heading_title; ?></h1>
								<div class="product-page__img js-control__img">
									<div class="product-card__labels">
										<?php if(array_key_exists('new', $tags)) { ?>
											<p class="product-card__label new">Новинка!</p>
										<?php } ?>
										<?php if(array_key_exists('action', $tags)) { ?>
											<p class="product-card__label action">Акция!</p>
										<?php } ?>
										<?php if(array_key_exists('hit', $tags)) { ?>
											<p class="product-card__label hit">Хит!</p>
										<?php } ?>
										<?php if($special) { ?>
											<p class="product-card__label discount">Скидка <?php echo (int)$special; ?>%</p>
										<?php } ?>
									</div>
									<div class="product-page__preview">
										<a href="<?php echo $thumb; ?>" onclick="return false;" class="cloud-zoom" id="cloudZoom">
											<img data-src="<?php echo $thumb; ?>" src="<?php echo $placeholder_img; ?>" alt="<?php echo $heading_title; ?>" />
										</a>
									</div>
								</div>
								<?php echo $additional; ?>

								<?php if ($description || $review_status || isset($customTabs['tab'])) { ?>
								<div class="product-info">
									<div class="tabs tabs--center">
										<div class="tabs__nav">
											<ul class="tabs__list">
												<?php if($description) { ?>
													<li class="tabs__list-item">
														<a href="#tabDescription" class="tabs__link js-tab-btn"><?php echo $tab_description; ?></a>
													</li>
												<?php } ?>
												
												<?php if($review_status) { ?>
												<li class="tabs__list-item">
													<a href="#tabReview" class="tabs__link js-tab-btn"><?php echo $tab_review; ?></a>
												</li>
												<?php } ?>
												
												<?php if (isset($customTabs['tab'])) { ?>
													<?php foreach ($customTabs['tab'] as $key => $tab) { ?>
													<li class="tabs__list-item">
														<a href="#tabCustom<?php echo $key; ?>" class="tabs__link js-tab-btn default"><?php echo $tab['title']; ?></a>
													</li>
													<?php } ?>
												<?php } ?>
											</ul>
										</div>

										<?php if ($description) { ?>
											<div class="tab" id="tabDescription">
												<div class="tabs__content js-tab-inner">
													<div class="editor" >
														<?php echo $description; ?>
													</div>
													<?php if (!$typeOptAtt) { ?>
													<div class="product-info__table">
														<?php foreach ($attribute_groups as $attribute_group) { ?>
															<?php foreach (array_chunk($attribute_group['attribute'], ceil(count($attribute_group['attribute']) / 2)) as $attribute_group['attribute']) { ?>
																<div class="product-info__col">
																	<dl class="product-info__list">
																		<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
																			<dt class="product-info__list-term"><?php echo $attribute['name']; ?></dt>
																			<dd class="product-info__list-desc"><?php echo $attribute['text']; ?></dd>
																		<?php } ?>
																	</dl>
																</div>
															<?php } ?>
														<?php } ?>
													</div>
													<?php } else { ?>
													<div class="table-responsive">
														<table class="table table-bordered table-sm">
															<?php foreach ($attribute_groups as $attribute_group) { ?>
															<tbody>
																<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
																<tr><td><?php echo $attribute['name']; ?></td><td><?php echo $attribute['text']; ?></td></tr>
																<?php } ?>
															</tbody>
															<?php } ?>
														</table>
													</div>
												<?php } ?>
												</div>
											</div>
										<?php } ?>
										<?php if (isset($customTabs['tab'])) { ?>
											<?php foreach ($customTabs['tab'] as $key => $tab) { ?>
											<div class="tab default" id="tabCustom<?php echo $key; ?>">
												<div class="tabs-content__inner">
													<div class="editor">
														<?php echo html_entity_decode($tab['description'], ENT_QUOTES, 'UTF-8'); ?>
													</div>
												</div>
											</div>
											<?php } ?>
										<?php } ?>
										<?php if ($review_status) { ?>
											<div class="tab" id="tabReview">
												<div class="product-info__feedback tabs-content__inner  js-tab-inner">
												<div class="reviews" id="review">
													<?php echo $product_reviews; ?>
												</div>
												<div class="text-right"><button type="button" class="btn btn--inline btn--gray"><?php echo $text_lightshop_products_review; ?></button></div>
												</div>
											</div>
										<?php } ?>
									</div>
								</div>
								<?php } ?>

								<?php if ($products) { ?>
								<div class="recomend">
									<div class="h3 recomend__title"><?php echo $text_related; ?></div>
									<div class="recomend-slider js-recomend-slider">
										<?php foreach($products as $product) { ?>
										<div class="recomend-slider__item">
											<?php require( DIR_TEMPLATE . 'theme_lightshop/template/product/products.tpl' ); ?>
										</div>
										<?php } ?>
									</div>
								</div>
								<?php } ?>

								<?php if (isset($customTabs['popup'])) { ?>
									<?php foreach ($customTabs['popup'] as $key => $popup) { ?>
										<div class="popup-simple" id="custom-popup-<?php echo $key; ?>">
											<div class="popup-simple__inner">
												<form>
													<h3><?php echo $popup['title'] ; ?></h3>
													<div class="popup-simple__inner-text"><?php echo html_entity_decode($popup['description'], ENT_QUOTES, 'UTF-8') ; ?></div>
												</form>
											</div>
										</div>
									<?php } ?>
								<?php } ?>
							</div><!-- col-12 col-md-7 -->

							<div class="col-4 product-page__col-right js-control__col-right" id="product">
								<div class="product-page__options js-control__media">
									<h1 <?php echo $schema ? 'itemprop="name"' : ''?> class="product-page__name"><?php echo $heading_title; ?></h1>

									<div class="product-page__row">
										<div <?php echo $schema && $rating ? 'itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating"' : ''?> class="product-page__rating-block">
											<?php if ($schema && $rating) { ?>
											<meta itemprop="ratingValue" content="<?php echo $rating; ?>">
											<meta itemprop="reviewCount" content="<?php echo preg_replace('/[^0-9]/', '', $reviews); ?>">
											<meta itemprop="bestRating" content="5">
											<meta itemprop="worstRating" content="1">
											<?php } ?>
											<?php if ($review_status) { ?>
											<div class="product-card__rating">
												<?php if ($product['rating']) { ?>
												<div class="product-card__rating-stars" style="width: <?php echo $product['rating'] * 20; ?>px"></div>
												<?php } ?>
											</div>
											<?php } ?>
										</div>
										<span class="product-card__status text-sm <?php echo $quantity > 0 ? 'instock' : ''?>">
										<?php if ($quantity > 0) { ?>
											<?php echo $schema ? '<link itemprop="availability" href="http://schema.org/InStock">' : ''?>
										<?php } else { ?>
											<?php echo $schema ? '<link itemprop="availability" href="http://schema.org/OutOfStock" />' : ''?>
										<?php } ?>
											<?php echo $stock; ?>
										</span>
									</div>

									<?php if ($options) { ?>
										<?php $t = 1;// $mode = 1; ?>
										<?php foreach ($options as $i=> $option) { ?>
											<?php if (!$option['required']) { continue; } ?>
											<?php if ($t%2 != 0 || $optMode) { ?>

										<div class="product-page__actions <?php echo (count($option['product_option_value']) < 2) ? 'hidden' : '' ; ?>"  >
											<?php } ?>
											<?php if ($option['type'] == 'select') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<div class="select">
													<select  name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="select" data-placeholder="<?php echo $text_select; ?>">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach ($option['product_option_value'] as $option_value) { ?>
														<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
														<?php if ($option_value['price']) { ?>
														\<?php echo $option_value['price_prefix']; ?> <?php echo $option_value['price']; ?>
														<?php } ?>
														</option>
														<?php } ?>
													</select>
												</div>
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'radio') { ?>

												<?php if($option['name'] === 'Цвет') { ?>

												<div class="product-page__input-box">
													<div class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></div><span class="text--light-gray js-content-color" style="margin-left: 15px;"></span>
													<div id="input-option<?php echo $option['product_option_id']; ?>">
													<?php foreach ($option['product_option_value'] as $option_value) { ?>
														<?php if ($option_value['image']) { ?>
														<div class="radiobox-colors__list-item option-value-id-<?php echo $option_value['option_value_id']; ?>">
															<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio" id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
															<label title="<?php echo $option_value['name']; ?>" for="close-type-<?php echo $option_value['product_option_value_id']; ?>" class="label--color label--color-<?php echo $option_value['product_option_value_id']; ?> js-cloud-zoom-image-big">
																<a href="<?php echo $option_value['image']; ?>" rel="gallerySwitchOnMouseOver: true, popupWin:'<?php echo $option_value['image']; ?>', useZoom: 'cloudZoom', smallImage: '<?php echo $option_value['image']; ?>'" class="cloud-zoom-gallery"></a>
															</label>
														</div>
														<?php } else { ?>
														<div class="product-page__radio-box option-value-id-<?php echo $option_value['option_value_id']; ?>">
															<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio"  id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
															<label for="close-type-<?php echo $option_value['product_option_value_id']; ?>">
															<?php echo $option_value['name']; ?>
															<?php if ($option_value['price']) { ?>
															\ <?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>
															<?php } ?>
															</label>
														</div>
														<?php } ?>
													<?php } ?>
													</div>
												</div>
												<?php } else { ?>
													<div class="product-page__input-box">
														<div class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><div class="product-page__input-box-description">' . $option['description'] . '</div>' : '') ?></div>
														<div id="input-option<?php echo $option['product_option_id']; ?>">
															<?php foreach ($option['product_option_value'] as $option_value) { ?>
															<?php if ($option_value['image']) { ?>
															<div class="radiobox-colors__list-item option-value-id-<?php echo $option_value['option_value_id']; ?>">
																<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio" id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
																<label title="<?php echo $option_value['name']; ?>" for="close-type-<?php echo $option_value['product_option_value_id']; ?>" class="label--img label--img-<?php echo $option_value['product_option_value_id']; ?>">
																	<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $option_value['image']; ?>" alt="" /><?php echo $option_value['name']; ?>
																</label>
															</div>
															<?php } else { ?>
															<div class="product-page__radio-box option-value-id-<?php echo $option_value['option_value_id']; ?>">
																<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio"  id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
																<label for="close-type-<?php echo $option_value['product_option_value_id']; ?>">
																<?php echo $option_value['name']; ?>
																<?php if ($option_value['price']) { ?>
																\ <?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>
																<?php } ?>
																</label>
															</div>
															<?php } ?>
														<?php } ?>
														</div>
													</div>
												<?php } ?>
											<?php } ?>
											<?php if ($option['type'] == 'checkbox') { ?>
											<div class="product-page__input-box">
												<div class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></div>
												<div id="input-option<?php echo $option['product_option_id']; ?>">
												<?php foreach ($option['product_option_value'] as $option_value) { ?>
													<?php if ($option_value['image']) { ?>
													<div class="radiobox-colors__list-item option-value-id-<?php echo $option_value['option_value_id']; ?>">
														<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio" id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
														<label title="<?php echo $option_value['name']; ?>" for="close-type-<?php echo $option_value['product_option_value_id']; ?>" class="label--img label--img-<?php echo $option_value['product_option_value_id']; ?>"></label>
													</div>
													<?php } else { ?>
													<div class="product-page__radio-box option-value-id-<?php echo $option_value['option_value_id']; ?>">
														<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio" id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
														<label for="close-type-<?php echo $option_value['product_option_value_id']; ?>">
														<?php echo $option_value['name']; ?>
														<?php if ($option_value['price']) { ?>
														\ <?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>
														<?php } ?>
														</label>
													</div>
													<?php } ?>
												<?php } ?>
												</div>
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'text') { ?>
											<div class="product-page__input-box">
												<div class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></div>
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>">
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'textarea') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['value']; ?></textarea>
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'file') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" class="btn btn--transparent btn--sm"><?php echo $button_upload; ?></button>
												<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'date') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="date">
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'datetime') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="datetime">
											</div>
											<?php } ?>
											<?php if ($option['type'] == 'time') { ?>
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $option['name']; ?><?php echo ($option['description'] ? '<span class="icon-question-mark">?</span><span class="product-page__input-box-description">' . $option['description'] . '</span>' : '') ?></span>
												<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="time">
											</div>
											<?php } ?>
											<?php if ($optMode) { ?>
										</div>
											<?php }elseif($t%2 == 0){ ?>
										</div>
											<?php } ?>
										<?php $t++; ?>
										<?php } ?>
										<?php if ($t%2 == 0 && !$optMode) { ?>
										</div>
										<?php } ?>
									<?php } ?>

									<div <?php echo $schema ? 'itemprop="offers" itemscope itemtype="http://schema.org/Offer"' : ''?> class="product-page__actions product-page__actions--bordered products-qty-info">
										<?php if ($price) { ?>
										<div class="product-page__prices js-product-page-prices">
										<?php if (!$special) { ?>
											<div <?php echo $schema ? 'itemprop="price"' : ''?> content="<?php echo $price_schema; ?>" class="product-page__price js-product-page-price"><?php echo $price; ?></div>
										<?php } else { ?>
											<span class="product-page__price product-page__price--old">
												<?php echo $price; ?>
											</span>
											<span class="product-page__price product-page__price--new">
												<span <?php echo $schema ? 'itemprop="price"' : ''?> content="<?php echo $special_schema; ?>"></span><?php echo $special; ?><span <?php echo $schema ? 'itemprop="priceCurrency"' : ''?> content="<?php echo $currency; ?>"></span>
											</span>
										<?php } ?>
										<?php if ($points) { ?>
											<span class="product-page__points-price"><?php echo $text_lightshop_points; ?> <?php echo $points; ?></span>
										<?php } ?>
										</div>
										<?php } ?>
										<div class="product-page__action">
											<input type="hidden" name="product_id" value="<?php echo $product_id; ?>">
											<button type="submit" class="mb-10 btn btn--spacing btn--yellow btn--cart">Добавить в корзину</button>
											<?php if ($buy_click['status']) { ?>
											<button type="button" data-target="#modalCallback" class="product-page__action-link js-modal"><?php echo $text_lightshop_buy_click; ?></button>
											<?php } ?>
										</div>

									</div>


									<?php if (isset($customTabs['popup'])) { ?>
										<div class="product-page__actions product-page__actions--popup">
											<?php foreach ($customTabs['popup'] as $key => $popup) { ?>
												<a href="#custom-popup-<?php echo $key; ?>" class="product-page__actions-link--dashed js-fancy-popup"><?php echo $popup['title'] ; ?></a>
											<?php } ?>
										</div>
									<?php } ?>

									<?php if ($recurrings) { ?>
										<div class="product-page__actions">
											<div class="product-page__input-box">
												<span class="product-page__input-box-title"><?php echo $text_payment_recurring; ?></span>
												<div class="select">
													<select name="recurring_id" class="select" data-placeholder="<?php echo $text_select; ?>">
														<option value=""><?php echo $text_select; ?></option>
														<?php foreach ($recurrings as $recurring) { ?>
														<option value="<?php echo $recurring['recurring_id']; ?>"><?php echo $recurring['name']; ?></option>
														<?php } ?>
													</select>
												</div>
												<div class="help-block" id="recurring-description"></div>
											</div>
										</div>
									<?php } ?>
									
									<?php if ($soc_share_prod) { ?>
										<div class="product-page__actions product-page__actions--share-code">
											<?php if ($soc_share_code) { ?>
												<?php echo $soc_share_code; ?>
											<?php } else { ?>
												<script src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-4dc053ae406c06af" async="async"></script>
												<div class="addthis_inline_share_toolbox"></div>
											<?php } ?>
										</div>
									<?php } ?>
								</div>

								<?php echo isset($column_right) ? $column_right : '' ?>

							</div><!-- col-12 col-md-5 -->
						</form><!-- row -->
					</div>
				</section>
			</div><!-- grid -->
		</div><!-- container -->

		<?php echo $content_bottom ? $content_bottom : '' ?>
	</main>
<?php echo $footer; ?>
</body></html>
