<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><?php echo $breadcrumb['text']; ?></li>	
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
			<div class="editor">
				<?php echo $description; ?>
			</div>
			<?php if ($products) { ?>
			<div class="recomend">
					<h2><?php echo $text_related; ?></h2>
					<div class="recomend-slider js-recom-slider">
						<?php foreach ($products as $product) { ?>
						<div class="recomend-slider__item product product--min">
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
			<?php } ?>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>