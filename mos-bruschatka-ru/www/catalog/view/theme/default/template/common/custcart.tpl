			<div class="cart-sidebar">
					<div class="cart-sidebar__title"><h3><?php echo $text_custcart; ?></h3><a href="<?php echo $cart; ?>"><?php echo $text_lightshop_edit_cart; ?></a></div>
					<?php if ($products || $vouchers) { ?>
						<ul class="cart__list">
						   <?php foreach ($products as $product) { ?>
							<li class="cart__list-item">
								<div class="cart__img">
									<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"></a>
								</div>
								<div class="cart__descr">
									<span class="cart__article"><?php echo $product['model']; ?></span>
									<a href="<?php echo $product['href']; ?>" class="cart__model"><?php echo $product['name']; ?></a>
									<span class="cart__price"><?php echo $product['total']; ?></span>
									<span class="cart__count"><?php echo $product['quantity']; ?> <?php echo $text_lightshop_cart_quantity; ?></span>
									<?php if ($product['option']) { ?>
									<?php foreach ($product['option'] as $option) { ?>
									<span class="cart__count"><?php echo $option['name']; ?> <?php echo $option['value']; ?></span>
									<?php } ?>
									<?php } ?>
									<?php if ($product['recurring']) { ?>
									<span class="cart__count"><?php echo $text_recurring; ?> <?php echo $product['recurring']; ?></span>
									<?php } ?>
								</div>
							</li>
       						   <?php } ?>
							   <?php foreach ($vouchers as $voucher) { ?>
							<li class="cart__list-item">
								<div class="cart__descr">
									<span class="cart__model"><?php echo $voucher['description']; ?></span>
									<span class="cart__price"><?php echo $voucher['amount']; ?></span>
									<span class="cart__count">1 <?php echo $text_lightshop_cart_quantity; ?></span>
								</div>
							</li>
							   <?php } ?>
						</ul>
					<div class="cart-sidebar__bottom">
						<?php foreach ($totals as $total) { ?>
							<?php if ($total['code'] == 'total') { ?>
								<span class="cart-sidebar__total"><?php echo $total['title']; ?> <span><?php echo $total['text']; ?></span></span>
							<?php }else{ ?>						
								<span class="cart-sidebar__info"><?php echo $total['title']; ?> <span><?php echo $total['text']; ?></span></span>
							<?php } ?>
						<?php } ?>

						<?php } else { ?>
						<span class="cart-sidebar__info"><?php echo $text_empty; ?></span>
						<?php } ?>
					</div>
			</div>
