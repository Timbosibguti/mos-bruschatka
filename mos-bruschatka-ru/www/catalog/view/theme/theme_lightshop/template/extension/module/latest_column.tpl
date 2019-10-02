<?php if ($products) { ?>
				<div class="catalogue__product">
					<span class="catalogue__product-title">
						<?php echo $heading_title; ?>
					</span>
					<ul class="catalogue__product-list">
					<?php foreach ($products as $product) { ?>
						<li class="catalogue__product-list-item">		
							<a class="catalogue__product-list-link" href="<?php echo $product['href']; ?>">
								<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>">
							</a>
							<div class="catalogue__product-list-item-desc">
							
									<?php if($product['isnewest']) { ?>
										<div class="label"><?php echo $labelsinfo['new']['name'][$language_id]; ?></div>
									<?php } ?>
									<?php if($product['special'] && $product['sales']) { ?>
										<div class="label label--red"><?php echo $labelsinfo['sale']['name'][$language_id] . ' ' . $product['discount']; ?></div>
									<?php } ?>
									
								<a class="link--brown" href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></span></a>
							</a>
								<div class="catalogue__product-list-item-price">
								<?php if ($product['price']) { ?>
									<?php if ($product['special']) { ?>
									<span class="product__price-old">
										<?php echo $product['price']; ?>
									</span>
									<span class="product__price">
										<?php echo $product['special']; ?>
									</span>
									<?php } else { ?>
									<span class="product__price"><?php echo $product['price']; ?></span>
									<?php } ?>							
								
								<?php } ?>
								</div>
							</div>
						</li>
					<?php } ?>
					</ul>
				</div>
<?php } ?>		

