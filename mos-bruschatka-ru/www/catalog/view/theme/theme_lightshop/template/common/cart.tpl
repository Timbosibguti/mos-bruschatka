<div class="header-cart" id="headerCart">
<?php if ($products || $vouchers) { ?>
	<div class="table-responsive">
		<table class="table table-sm">
			<thead class="text-center">
				<tr>
					<th scope="col">&#8470;</th>
					<th scope="col">Продукт</th>
					<th scope="col">Удалить</th>
				</tr>
			</thead>
			<tbody>
			<?php foreach ($products as $key => $product) { ?>
				<tr>
					<th scope="col" style="padding-top: 45px;"><?php echo $key + 1; ?></td>
					<td>
						
						<table class="table table-sm table-borderless">
							<tr>
								<th rowspan ="4" class="text-center" style="width: 200px;"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"></a></th>
							</tr>
							<tr>
								<td><a href="<?php echo $product['href']; ?>" class="header-cart__model"><?php echo $product['name']; ?></a></td>
							</tr>
							<tr>
								<td>
									<?php echo $product['quantity']; ?>шт.
								</td>
							</tr>
							<tr>
								<td><?php echo $product['total']; ?></td>
								<?php echo $product['manufacturer']; ?>
							</tr>
						</table>
					</td>
					<td>
						<div class="header-cart__remove">
							<button type="button" title="<?php echo $button_remove; ?>" class="icon-garbage-16 header-cart__remove-btn js-cart-remove" value="<?php echo $product['cart_id']; ?>"></button>
						</div>
					</td>
				</tr>
			<?php } ?>
			<?php foreach ($vouchers as $key => $voucher) { ?>
				<tr>
					<th scope="col"><?php echo $key + 1; ?></td>
					<td>
						<div class="header-cart__descr">
							<span class="header-cart__model"><?php echo $voucher['description']; ?></span>
							<span class="header-cart__price"><?php echo $voucher['amount']; ?></span>
							<span class="header-cart__count">1 <?php echo $text_lightshop_header-cart_quantity; ?></span>
						</div>
						<div class="header-cart__close">
							<a href="#<?php echo $voucher['key']; ?>;" title="<?php echo $button_remove; ?>" class="header-cart__close-btn js-voucher-remove"><svg class="icon-cross"><use xlink:href="#cross"></use></svg></a>
						</div>
					</td>
					<td>
						<div class="header-cart__close">
							<a href="#<?php echo $product['header-cart_id']; ?>;" title="<?php echo $button_remove; ?>" class="header-cart__close-btn js-header-cart-remove"><svg class="icon-cross" height="20" width="20"><use xlink:href="#cross"></use></svg></a>
						</div>
					</td>
				</tr>
			<?php } ?>
			</tbody>
		</table>
	</div>

	<div class="header-cart-popup__btn">
		<div class="text--bold header-cart-popup__prices">
			<?php foreach ($totals as $total) { ?>
			<span class="header-cart-popup__total"><?php echo $total['title']; ?> <span><?php echo $total['text']; ?></span></span>
			<?php } ?>
		</div>
		<a href="<?php echo $cart; ?>" class="btn btn--inline btn--yellow"><?php echo $text_cart; ?></a>
		<a href="<?php echo $checkout; ?>" class="btn btn--inline btn--yellow" style="display: none;"><?php echo $text_checkout; ?></a>
		<?php if (isset($buy_click['status']) && $buy_click['status']) { ?>
		<a href="javascript:void(0);" class="btn btn--inline btn--yellow"  style="display: none;"><?php echo $text_lightshop_fast_order; ?></a>
		<?php } ?>
	</div>
<?php } else { ?>
	<span class="header-cart-popup__discount"><?php echo $text_empty; ?></span>
<?php } ?>
</div>