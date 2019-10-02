<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumb">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
				<?php if($i == 0) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>>🏡</span></a></li>
				<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a data-href="#categories-popup<?php echo $i; ?>" class="js-popup-call-hover-off breadload" data-id="<?php echo $breadcrumb['cat_id']; ?>" data-i="<?php echo $i; ?>" href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
				<?php } else { ?>
					<li class="breadcrumb__list-item"><?php echo $breadcrumb['text']; ?></li>
				<?php } ?>
			<?php } ?>
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
		<?php if ($categories) { ?>
		<div class="brand">
			<ul class="brand__list">
			<?php foreach ($categories as $category) { ?>
				<?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
					<?php foreach ($manufacturers as $manufacturer) { ?>
						<li class="brand__list-item">
							<span class="brand__item-wrap">
								<span class="brand__item-img">
									<a href="<?php echo $manufacturer['href']; ?>" class="brand__link">
										<img src="<?php echo $manufacturer['thumb']; ?>" alt="<?php echo $manufacturer['name']; ?>" title="<?php echo $manufacturer['name']; ?>">
									</a>
								</span>
							</span>
						</li>
						<?php } ?>
				<?php } ?>
			<?php } ?>
			</ul>
		</div>
		<?php } else { ?>
			<p><?php echo $text_empty; ?></p>
			<a href="<?php echo $continue; ?>" class="btn"><?php echo $button_continue; ?></a>
		<?php } ?>

		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>
