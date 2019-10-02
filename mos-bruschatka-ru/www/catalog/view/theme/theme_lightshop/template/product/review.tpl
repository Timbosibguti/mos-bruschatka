<?php if ($reviews) { ?>
<?php foreach ($reviews as $review) { ?>
<div <?php echo $schema ? 'itemprop="review" itemscope itemtype="http://schema.org/Review"' : ''?> class="product-info__feedback-item">
	<div class="product-info__feedback-img float-left">
		<svg class="svg-border svg-border--50 icon-user">
			<use xlink:href="#iconProfil"></use>
		</svg>
	</div>
	<div class="product-info__feedback-title">
		<span <?php echo $schema ? 'itemprop="author"' : ''?> class="product-info__feedback-author"><?php echo $review['author']; ?></span>

		<span class="product-page__rating-block">
			<?php if ($review['rating']) { ?>
			<div class="product-page__rating">
				<?php if ($review['rating']) { ?>
				<div class="product-page__rating-stars" style="width: <?php echo $review['rating'] * 20; ?>px"></div>
				<?php } ?>
			</div>
			<?php } ?>
		</span>
		
		<span class="product-info__feedback-time float-right" <?php echo $schema ? 'itemprop="datePublished"' : ''?> content="<?php echo $review['date_added_schema']; ?>">
			<svg class="icon-calendar" height="10" width="10">
				<use xlink:href="#calendar"></use>
			</svg>
			<?php echo $review['date_added']; ?>
		</span>
	</div>
	<p <?php echo $schema ? 'itemprop="description"' : ''?>class="product-info__feedback-text"><?php echo $review['text']; ?></p>
</div>
<?php } ?>
<?php echo $pagination; ?>
<?php } else { ?>
<p><?php echo $text_no_reviews; ?></p><br />
<?php } ?>