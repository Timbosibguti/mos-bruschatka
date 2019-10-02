<?php if ($view == '1') { ?>
	<?php foreach ($product_tabs as $tab => $product_tab) { ?>
	<?php if(empty($products[$tab])){ continue; } ?>
		<div class="recomend">
			<div class="container">
				<h2><?php echo $product_tab['description'][$language_id]['name']; ; ?></h2>
				<div class="recomend-slider js-recom-slider">
				<?php foreach ($products[$tab] as $key => $product) { ?>
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
	
	
<?php } elseif ($view == '2') { ?>
<!-- ? -->
<?php } else { ?>
		<!-- catalog -->

		<div class="catalog-min">
			<div class="container js-tabs-box">
				<div class="tabs tabs--light">
				  <ul class="tabs__list">
					<?php $t = 0; ?>
				  	<?php foreach ($product_tabs as $tab => $product_tab) { ?>
					  <?php if(!empty($products[$tab])){ ?>
						<li class="tabs__list-item js-tab <?php if(!$t) { ?> active <?php } ?>">
							<a href="#tab-data-<?php echo $tab; ?>" class="tabs__link">
								<?php echo isset($product_tab['description'][$language_id]['name']) ? $product_tab['description'][$language_id]['name'] : ''; ?>
							</a>
						</li>
						<?php $t++; ?>
					   <?php } ?>
						
				  	<?php } ?>
				  </ul>
				</div>
				<div class="catalog-min__tabs-content">
					<div class="catalog-min__tabs-container">
						<?php $y = 0; ?>
					  <?php foreach ($product_tabs as $tab => $product_tab) { ?>
						<?php if(empty($products[$tab])){ continue; } ?>
						<div class="tabs-content js-tab-content <?php if(!$y) { ?> active <?php } ?>">
						  
						  <?php for ($t = 0; $t < ceil(count($products[$tab]) / 3); $t++) { ?>						    
							  <div class="catalog-min__row">
								<?php $y_min = $t*3; $y_max = ($t+1)*3; ?>
								<?php for ($i=$y_min; $i < $y_max; $i++) { ?>
								<?php if (isset($products[$tab][$i])) { ?>
								<?php  $product = $products[$tab][$i]; ?>							
								<div class="product product--min">
									<?php if($product['isnewest']) { ?>
										<div class="label"><?php echo $labelsinfo['new']['name'][$language_id]; ?></div>
									<?php } ?>
									<?php if($product['special'] && $product['sales']) { ?>
										<div class="label label--red"><?php echo $labelsinfo['sale']['name'][$language_id] . ' ' . $product['discount']; ?></div>
									<?php } ?>
									<div class="product__img">
										<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt=""></a>										
									</div>
									<div class="product__descr">
										<?php if ($product['rating'] !== false) { ?>
										<div class="product__rating">
										  <div class="product__rating-fill" style="width: <?php echo 20*$product['rating']; ?>%;"></div>
										</div>
										<?php } ?>
										<a href="<?php echo $product['href']; ?>" class="link--brown"><?php echo $product['name']; ?></a>
										<div class="clearfix"></div>
									<?php if ($product['special']) { ?>
										<span class="catalogue__price-old catalogue__price-old--sm"><?php echo $product['price']; ?></span>
										<span class="catalogue__price catalogue__price--sm"><?php echo $product['special']; ?></span>
									<?php } else { ?>	
										<span class="catalogue__price catalogue__price--sm"><?php echo $product['price']; ?></span>
									<?php } ?>	
									</div>
								</div>
							   <?php } ?>
							   <?php } ?> 
							
							  </div>							
							
						  <?php } ?>
							
						</div>
					<?php $y++; ?>
					  <?php } ?>
					</div>	
				</div>	
			</div>
		</div>
<?php } ?>