	<?php foreach ($product_tabs as $tab => $product_tab) { ?>
	<?php if(empty($products[$tab])){ continue; } ?>
				<div class="catalogue__product card card-outline--gray">
					<?php if($product_tab['description'][$language_id]['name']) { ?>
					<span class="catalogue__product-title">
						<?php echo $product_tab['description'][$language_id]['name']; ?>
					</span>
					<?php } ?>
					<ul class="catalogue__product-list">
				<?php foreach ($products[$tab] as $key => $product) { ?>
						<li class="catalogue__product-list-item blog-right__li card-highlight">		
						<a class="products-list__img js-catalog-products-list-img" href="<?php echo $product['href']; ?>">
							<img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAABAAEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9/KKKKAP/2Q==" data-src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" />
						</a>
						<?php if($product['isnewest']) { ?>
							<span class="label products-list__label label--green"><div class="label-clip"><?php echo $labelsinfo['new']['name'][$language_id]; ?></div></span>
						<?php } ?>
						<?php if($product['special'] && $product['sales']) { ?>
							<span class="label products-list__label label--blue"><div class="label-clip"><?php echo $labelsinfo['sale']['name'][$language_id] . ' ' . $product['discount']; ?></div></span>
						<?php } ?>
							<div class="products-list__caption">
								<div class="row">
								<div class="col-7 blog-right__prod"><a href="<?php echo $product['href']; ?>" class="text--color-1 products-list__name js-catalog-products-list-name"><span><?php echo $product['name']; ?></span></a></div>
								<?php if ($product['special']) { ?>
									<div class="col-5 text-right text--blue">
										<span class="catalogue__price-old catalogue__price-old--sm"><?php echo $product['price']; ?></span>
										<span class="catalogue__price catalogue__price--sm"><?php echo $product['special']; ?></span>
									</div>
								<?php } else { ?>	
									<div class="col-5 text-right text--blue"><span class="catalogue__price catalogue__price--sm">Ð¾Ñ‚ <?php echo $product['price']; ?></span></div>
								<?php } ?>
								<?php if ($product['rating'] !== false) { ?>
									<div class="product-card__rating">
												<?php if ($product['rating']) { ?>
												<div class="product-card__rating-stars" style="width: <?php echo $product['rating'] * 20; ?>px"></div>
												<?php } ?>
									</div>
								<?php } ?>
									<div class="col-5 text-sm text-right">
										<div class="products-list__status status <?php echo $product['quantity'] > 0 ? 'instock' : ''?>">
										<?php if ($product['quantity'] > 0) { ?>
											<?php echo $schema ? '<link itemprop="availability" href="http://schema.org/InStock">' : ''?>
										<?php } else { ?>
											<?php echo $schema ? '<link itemprop="availability" href="http://schema.org/OutOfStock" />' : ''?>
										<?php } ?>
										<?php echo $product['stock']; ?>
										</div>
									</div>
								</div>
							</div>
							<div class="col-6 blog-prod__add">
								<button title="В корзину" class="btn btn--outline-white btn--cart text--medium-bold js-cart-fast-add" value="603">В корзину</button>
							</div>
						</li>
					<?php } ?>			
					</ul>
				</div>
	<?php } ?>