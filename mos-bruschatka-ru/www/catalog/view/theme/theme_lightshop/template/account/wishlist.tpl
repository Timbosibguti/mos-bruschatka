<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<div class="alerts">
<?php if ($success) { ?>
	<div class="alert alert--green">
		<span class="alert__text">
			<?php echo $success; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
</div>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span><?php echo $breadcrumb['text']; ?></span></li>		
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
			<div id="sidebar-mob-btn"></div>
			<?php if ($products) { ?>
					<table class="catalogue__table active">
					<?php foreach ($products as $product) { ?>
						<tr class="catalogue__table-row">
							<td class="catalogue__table-photo">
								<a href="<?php echo $product['href']; ?>" class="catalogue__photo-link">
									<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>">
								</a>
							</td>
							<td class="catalogue__table-name">
								<?php if ($product['rating'] !== false) { ?>
								<div class="catalogue__product-rating">
									<div class="product__rating">										
										<div class="product__rating-fill" style="width: <?php echo $product['rating']*20; ?>%;">											
										</div>
									</div>
								</div>
								<?php } ?>	
								<a href="<?php echo $product['href']; ?>" class="catalogue__product-name">
									<?php echo $product['name']; ?>
								</a>
							</td>
							<td class="catalogue__table-price">
							<?php if ($product['price']) { ?>
							<?php if ($product['special']) { ?>
								<span class="catalogue__price-old">
									<?php echo $product['price']; ?>
								</span>
								<span class="catalogue__price catalogue__price--md">
									<?php echo $product['special']; ?>
								</span>
							<?php } else { ?>	
								<span class="catalogue__price catalogue__price--md">
									<?php echo $product['price']; ?>
								</span>
							<?php } ?>	
							<?php } ?>	
							</td>
							<td class="catalogue__table-btn" style="position: relative;">
								<a class="catalogue__table-action-link" href="<?php echo $product['remove']; ?>">
									<span class="catalogue__table-action-icon">
									<svg class="icon-cross">
										<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#cross"></use>
									</svg>
									</span>
								</a>
								<a class="btn btn--transparent catalogue__btn-cart" data-for="<?php echo $product['product_id']; ?>" title="<?php echo $button_cart; ?>" >
									<span class="catalogue__btn-cart-plus"> + </span>
									<svg class="icon-cart">
										<use xlink:href="#shopping-cart"></use>
									</svg>
								</a>
							</td>
							<td class="catalogue__table-spinner">
								<div class="spinner-wrap">
									<input type="text" class="spinner" value='<?php echo $product['minimum']; ?>' placeholder="<?php echo $product['minimum']; ?>">
								</div>
							</td>
							<td class="catalogue__table-action">
								<span class="catalogue__table-action-item">
									<a class="catalogue__table-action-link" href="<?php echo $product['remove']; ?>">
										<span class="catalogue__table-action-icon">
										<svg class="icon-cross">
											<use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#cross"></use>
										</svg>
										</span>
										<span class="catalogue__table-action-text">
											<?php echo $button_remove; ?>
										</span>
									</a>
								</span>
								<span class="catalogue__table-action-item">
									<a class="catalogue__table-action-link" onclick="compare.add('<?php echo $product['product_id']; ?>');">
										<span class="catalogue__table-action-icon">
											<svg class="icon-add-to-list">
												<use xlink:href="#add-to-list"></use>
											</svg>
										</span>
										<span class="catalogue__table-action-text">
											<?php echo $button_compare; ?>
										</span>
									</a>
								</span>
							</td>
						</tr>
					<?php } ?>
					</table>
					<p>&nbsp;</p>
			<?php } else { ?>
			<p><?php echo $text_empty; ?></p>
			<?php } ?>
			  	<div class="checkout__button-box">
					<a href="<?php echo $continue; ?>" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></a>
				</div>
		</div>
		<?php echo ($column_right && $islogged) ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>