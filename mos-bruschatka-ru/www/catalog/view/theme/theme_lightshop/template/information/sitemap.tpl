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
			<div class="row">
				<div class="col-sm-6">
					<ul>
						<?php foreach ($categories as $category_1) { ?>
						<li><a href="<?php echo $category_1['href']; ?>"><?php echo $category_1['name']; ?></a>
							<?php if ($category_1['children']) { ?>
							<ul>
								<?php foreach ($category_1['children'] as $category_2) { ?>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $category_2['href']; ?>"><?php echo $category_2['name']; ?></a>
									<?php if ($category_2['children']) { ?>
									<ul>
										<?php foreach ($category_2['children'] as $category_3) { ?>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<?php echo $category_3['href']; ?>"><?php echo $category_3['name']; ?></a></li>
										<?php } ?>
									</ul>
									<?php } ?>
								</li>
								<?php } ?>
							</ul>
							<?php } ?>
						</li>
						<?php } ?>
					</ul>
				</div>
				<div class="col-sm-6">
					<ul>
						<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
						<li><a href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
							<ul>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $address; ?>"><?php echo $text_address; ?></a></li>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $history; ?>"><?php echo $text_history; ?></a></li>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $download; ?>"><?php echo $text_download; ?></a></li>
							</ul>
						</li>
						<li><a href="<?php echo $cart; ?>"><?php echo $text_cart; ?></a></li>
						<li><a href="<?php echo $checkout; ?>"><?php echo $text_checkout; ?></a></li>
						<li><a href="<?php echo $search; ?>"><?php echo $text_search; ?></a></li>
						<li><?php echo $text_information; ?>
							<ul>
								<?php foreach ($informations as $information) { ?>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
								<?php } ?>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
							</ul>
						</li>
						<li><?php echo $text_lightshop_news; ?>
							<ul>
								<?php foreach ($newss as $news) { ?>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $news['href']; ?>"><?php echo $news['title']; ?></a></li>
								<?php } ?>
							</ul>
						</li>
						<?php if(!empty($blogcategories)) { ?>
						<li><?php echo $text_lightshop_blogs; ?>
							<ul>
								<?php foreach ($blogcategories as $blogcategory) { ?>
								<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $blogcategory['href']; ?>"><?php echo $blogcategory['name']; ?></a>
									<ul>
										<?php foreach ($blogcategory['subblogs'] as $subblog) { ?>
											<li>&nbsp;&nbsp;&nbsp;<a href="<?php echo $subblog['href']; ?>"><?php echo $subblog['title']; ?></a>
										<?php } ?>
									</ul>
								</li>
								<?php } ?>
							</ul>
						</li>
						<?php } ?>
					</ul>
				</div>
			</div>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>