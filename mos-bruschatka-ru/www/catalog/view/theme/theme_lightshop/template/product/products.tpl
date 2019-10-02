<div class="product-card" data-image="<?php echo $product['thumb']; ?>" data-product-id="<?php echo $product['product_id']; ?>" data-params="<?php echo htmlspecialchars(json_encode($product['options']), ENT_QUOTES, 'UTF-8'); ?>">
	<div class="product-card__labels">
		<?php if(in_array('new', $product['tags'])) { ?>
			<p class="product-card__label new">Новинка!</p>
		<?php } ?>
		<?php if(in_array('action', $product['tags'])) { ?>
			<p class="product-card__label action">Акция!</p>
		<?php } ?>
		<?php if(in_array('hit', $product['tags'])) { ?>
			<p class="product-card__label hit">Хит!</p>
		<?php } ?>
		<?php if($product['special']) { ?>
			<p class="product-card__label discount">Скидка <?php echo (int)$product['special']; ?>%</p>
		<?php } ?>
	</div>
	<a class="product-card__img js-product-card-img" href="<?php echo $product['href']; ?>">
		<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
	</a>

	<div class="product-card__infos">

		<?php if (isset($product['colors'])) { ?>
		<div class="product-card__colors">
			<?php foreach ($product['colors'] as $option_value) { ?>
				<div class="radiobox-colors__list-item option-value-id-<?php echo $option_value['option_value_id']; ?>">
					<input type="radio" name="option[<?php echo $option_value['option_id']; ?>]" data-image="<?php echo $option_value['image']; ?>"
						   value="<?php echo $option_value['product_option_value_id']; ?>" class="input-radio" id="close-type-<?php echo $option_value['product_option_value_id']; ?>">
					<label title="<?php echo $option_value['name']; ?>" for="close-type-<?php echo $option_value['product_option_value_id']; ?>"
						   class="label--color label--color-<?php echo $option_value['product_option_value_id']; ?>"></label>
				</div>
			<?php } ?>
		</div>
		<?php } ?>

		<h5 class="mb-5"><a href="<?php echo $product['href']; ?>" class="product-card__name"> <?php echo $product['name']; ?> </a></h5>
		<div class="product-card__prices">
			<?php if ($product['special']) { ?>
				<span class="product-card__price product-card__price--old">от <?php echo (int)(100 * preg_replace('/[^0-9]/', '', $product['price']) / (100 - $product['special'])); ?> ₽</span>
				<span class="product-card__price product-card__price--new"> <?php echo $product['price']; ?> </span>
			<?php } else { ?>
				<span class="product-card__price">от <?php echo $product['price']; ?></span>
			<?php } ?>
		</div>
		<div class="row no-gutters">
			<div class="col-sm-6 product-left">
				<div class="product-card__rating">
					<?php if ($product['rating']) { ?>
					<div class="product-card__rating-stars" style="width: <?php echo $product['rating'] * 16; ?>px"></div>
					<?php } ?>
				</div>
			</div>
			<div class="col-sm-6 text-sm text-right product-right">
				<div class="product-card__status <?php echo (isset($product['quantity']) && ($product['quantity'] > 0)) ? 'instock' : '' ?>">
				<?php if (isset($product['quantity']) && ($product['quantity'] > 0)) { ?>
					<?php echo isset($schema) && $schema ? '<link itemprop="availability" href="http://schema.org/InStock">' : ''?>
				<?php } else { ?>
					<?php echo isset($schema) && $schema ? '<link itemprop="availability" href="http://schema.org/OutOfStock" />' : ''?>
				<?php } ?>
				<?php echo isset($product['stock']) ? $product['stock'] : ''; ?>
				</div>
			</div>
		</div>
	</div>

	<div class="product-card__btns">
		<div class="row no-gutters">
			<div class="col-6">
				<button title="<?php echo $button_cart; ?>" class="btn btn--outline-white btn--cart text--medium-bold product-btn js-cart-fast-add" value="<?php echo $product['product_id']; ?>">В корзину</button>
			</div>
			<div class="col-6">
				<a href="<?php echo $product['href']; ?>" class="btn btn--fluid btn--outline-gray">
					<?php echo $button_view; ?>
				</a>
			</div>
		</div>
	</div>

</div>
