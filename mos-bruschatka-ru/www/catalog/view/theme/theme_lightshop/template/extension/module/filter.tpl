
<a href="#" class="js-btn-filter catalogue__filter-btn"><?php echo $text_lightshop_filter; ?></a>
<div class="catalogue__filter js-filter-resp">
	<div class="catalogue__filter-top">
		<span class="catalogue__filter-top-title">
			<?php echo $text_lightshop_filter; ?>
		</span>
		<a href="#" class="catalogue__block-hide js-filter-hide">
			<svg class="icon-chevron-bottom">
				<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#chevron-small-left"></use>
			</svg>
		</a>
	</div>
	<div class="catalogue__filter-scroll">

			<input type="hidden" name="min_price_init" value="<?php echo $priceLimits['min_price'] ?>" id="min_price_init">
			<input type="hidden" name="max_price_init" value="<?php echo $priceLimits['max_price'] ?>" id="max_price_init">
			<input type="hidden" name="min_price_current" value="<?php echo $min_price ?>" id="min_price_current">
			<input type="hidden" name="max_price_current" value="<?php echo $max_price ?>" id="max_price_current">
			<input type="hidden" name="filter_category_id" value="<?php echo $category_id ?>" id="filter_category_id">



	
					<div class="catalogue__filter-section js-filter-parent" id="filterblock">
						<div class="catalogue__filter-heading">
							<span class="catalogue__filter-title">
								<?php echo $text_lightshop_filter_price; ?>
							</span>
							<span class="catalogue__filter-arrow js-filter-arrow">
								<svg class="icon-chevron-bottom">
									<use xlink:href="#chevron-small-left"></use>
								</svg>
							</span>
						</div>
						<div class="catalogue__filter-content js-filter-content">
							<div class="price-slider">
								<div class="price-slider__drag-area">
									<div id="slider-range" class="price-slider__drag-area-inner js-price-slider">
										
									</div>
								</div>
								<div class="price-slider__inputs">
									<label class="price-slider__inputs-text" data-for="price-slider-from"><?php echo $text_lightshop_from ?></label>
									<span class="price-slider__inputs-input price-slider__inputs-input--from">
										<span class="js-span-start"><?php echo $min_price_format ?></span>
											<input type="text" name="min_price" class="js-price-slider-input price_limit" id="min_price" data-index="0" value="-1">
										
									</span>
									<label class="price-slider__inputs-text" data-for="price-slider-to"><?php echo $text_lightshop_to ?></label>
									<span class="price-slider__inputs-input">
										<span class="js-span-end"><?php echo $max_price_format ?></span>
											<input type="text" name="max_price" class="js-price-slider-input price_limit" id="max_price" data-index="1" value="-1">
										
									</span>
								</div>
							</div>
						</div>
					</div>

					
	<?php foreach ($filter_groups as $filter_group) { ?>
	<div class="catalogue__filter-section js-filter-parent">
		<div class="catalogue__filter-heading">
			<span class="catalogue__filter-title">
				<?php echo $filter_group['name']; ?>
			</span>
			<span class="catalogue__filter-arrow js-filter-arrow">
				<svg class="icon-chevron-bottom">
					<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#chevron-small-left"></use>
				</svg>
			</span>
		</div>
		<div class="catalogue__filter-content js-filter-content">
			<ul id="filter-group<?php echo $filter_group['filter_group_id']; ?>" class="catalogue__brands">
			<?php foreach ($filter_group['filter'] as $i=> $filter) { ?>
				<li class="catalogue__brands-item">
					<?php if (in_array($filter['filter_id'], $filter_category)) { ?>
					<input type="checkbox" id="filter-<?php echo $filter['filter_id']; ?>-<?php echo $i; ?>" value="<?php echo $filter['filter_id']; ?>" name="filter[]" checked="checked">
					<label for="filter-<?php echo $filter['filter_id']; ?>-<?php echo $i; ?>"><?php echo $filter['name']; ?></label>
					<?php } else { ?>
					<input type="checkbox" id="filter-<?php echo $filter['filter_id']; ?>-<?php echo $i; ?>" value="<?php echo $filter['filter_id']; ?>" name="filter[]">
					<label for="filter-<?php echo $filter['filter_id']; ?>-<?php echo $i; ?>"><?php echo $filter['name']; ?></label>
					<?php } ?>
				</li>
			<?php } ?>
			</ul>
		</div>
	</div>
	<?php } ?>
	<div class="catalogue__filter-button-filter">
		<button type="button" id="button-filter" class="btn btn--transparent btn--sm"><?php echo $text_lightshop_show; ?></button>
		<button type="button" id="resetfilter"  class="btn btn--link btn--sm"><?php echo $text_lightshop_reset; ?></button>
	</div>
	<input type="hidden" name="fix_filter_action" value="<?php echo $action; ?>">
	</div>
</div>