

	<div class="container">
	<h2 class="content__title"><?php echo $heading_title; if ($weight) { echo ' (' . $weight . ')'; }; ?></h2>
		<div class="cart">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="cartcontent">	 
			<div class="cart__products">
				<table class="cart__table">
				<?php foreach ($products as $product) { ?>
					<tr class="cart__table-row">
					<?php if ($product['thumb']) { ?>
						<td class="cart__table-photo">
							<a href="<?php echo $product['href']; ?>" class="cart__photo">
								<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>">
							</a>
						</td>
					<?php } ?>	
						<td <?php if (!$product['thumb']) { ?>colspan="2"<?php } ?>	 class="cart__table-name">
								<a href="<?php echo $product['href']; ?>" class="cart__product-name">
									<?php echo $product['name']; ?>
								</a>
								<?php if (!$product['stock']) { ?>
								***
								<?php } ?>
						</td>
						<td class="cart__table-discount">
							<span class="cart__discount">
								<?php echo $product['model']; ?><br>
								
								<?php if ($product['option']) { ?>
									<?php foreach ($product['option'] as $option) { ?>					 
										<?php echo $option['name']; ?>: <?php echo $option['value']; ?><br>
									<?php } ?>
								<?php } ?>
							  
								<?php if ($product['reward']) { ?>
									<?php echo $product['reward']; ?><br>
								<?php } ?>
								
								<?php if ($product['recurring']) { ?>
									<?php echo $text_recurring_item; ?> <?php echo $product['recurring']; ?><br>
								<?php } ?>	
							</span>
						</td>
						<td class="cart__table-price">
							<span class="catalogue__price catalogue__price--md catalogue__price--think" title="<?php echo $column_price; ?>">
								<?php echo $product['price']; ?>
							</span>
						</td>					
						<td class="cart__table-spinner">
							<div class="spinner-wrap">
								<input name="quantity[<?php echo $product['cart_id']; ?>]" type="text" class="spinner" value='<?php echo $product['quantity']; ?>' placeholder="<?php echo $product['quantity']; ?>">
							</div>
						</td>

						<td class="cart__table-price-total">
							<span class="catalogue__price catalogue__price--md catalogue__price--total" title="<?php echo $column_total; ?>">
								<?php echo $product['total']; ?>
							</span>
						</td>
						<td class="cart__table-delete">
							<a onclick="cart.remove('<?php echo $product['cart_id']; ?>');" class="cart__delete" title="<?php echo $button_remove; ?>">
								<svg class="icon-cross">
									<use xlink:href="#cross"></use>
								</svg>
							</a>
						</td>
					</tr>
					<?php } ?>
				</table>
			</div>
			</form>
			
			<div class="cart__meta">	  
				<div class="cart__sum">
				<?php foreach ($totals as $i=> $total) { ?>
					<?php if($i + 1 < count($totals)) { ?>
						<span class="cart__sum-text">
							<?php echo $total['title']; ?>:
							<span class="cart__sum-text-price">
								<?php echo $total['text']; ?>
							</span>
						</span><br>			
					<?php } else { ?>
						<span class="cart__sum-text">
							<?php echo $total['title']; ?>:
							<span class="cart__sum-price">
								<?php echo $total['text']; ?>
							</span>
						</span><br>				
					<?php }?>
				<?php } ?>				
				</div>
			</div>
			<div class="cart__buttons">
				<div class="cart__buttons-left">
					<a href="<?php echo $continue; ?>" class="btn btn--transparent">
						<?php echo $button_shopping; ?>
					</a>
				</div>
				<div class="cart__buttons-right">
					<a href="<?php echo $checkout; ?>" class="btn"><?php echo $button_checkout; ?></a>
				</div>
			</div>
		</div>
	</div>

