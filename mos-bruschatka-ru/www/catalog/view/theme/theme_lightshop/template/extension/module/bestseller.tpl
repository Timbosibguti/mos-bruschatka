<?php if ($products) { ?>
		<div class="recomend recomend--bestseller">
			<div class="container">
				<h2><?php echo $heading_title; ?></h2>
				<div class="recomend-slider js-recom-slider">
				<?php foreach ($products as $product) { ?>
					<div class="recomend-slider__item product product--min">
									<?php if($product['isnewest']) { ?>
										<div class="label"><?php echo $labelsinfo['new']['name'][$language_id]; ?></div>
									<?php } ?>
									<?php if($product['special'] && $product['sales']) { ?>
										<div class="label label--red"><?php echo $labelsinfo['sale']['name'][$language_id] . ' ' . $product['discount']; ?></div>
									<?php } ?>
						<div class="product__img">
							<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"></a>
						</div>
						<div class="product__descr">
							<?php if ($product['rating'] !== false) { ?>
							<div class="product__rating product__rating--sm">
								<div class="product__rating-fill" style="width: <?php echo 20*$product['rating']; ?>%;">
								</div>
							</div>
							<?php } ?>
							<a href="<?php echo $product['href']; ?>" class="product__descr-link link--brown"><span><?php echo $product['name']; ?></span></a>
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
					<?php } ?>			
				</div>
				
			</div>
		</div>
<?php } ?>		

