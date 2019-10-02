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
	<div class="news">
		<ul class="news__list">
        <?php foreach ($newss as $news) { ?>
            <li class="news__list-item">
				<a class="news__link" href="<?php echo $news['href']; ?>">
					<span class="news__date">
						<?php echo $news['date_added']; ?>
					</span>
					<span class="news__title">		
						<span class="news__title-inner"><?php echo $news['title']; ?></span>
					</span>
					<span class="news__text">
						<?php echo $news['description']; ?>
					</span>					
				</a>
			</li>
        <?php } ?>
		</ul>
	</div>
				<div class="catalogue__content-bottom">
					<div class="catalogue__pagination">
						<?php echo $pagination; ?>
					</div>
				</div>
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>

