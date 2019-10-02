<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="section">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumb d-none">
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
				<div class="blog">
				  <div class="row">
					<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
					<div class="col-sm-<?php echo $col; ?>">
					<?php if($catblogmod) { ?>
					<a href="#sidebar-navigation" class="js-popup-call sidebar-mobile-btn" style="width: 100%;margin: 20px 0 40px;">Категории</a>
					<?php } ?>
						<div class="reviews-list clearfix">
							<div class="row">
								<?php $s = 1; ?>
								<?php foreach ($blogs as $blog) { ?>
									<?php if($s == 4) { ?>
									<div class="col-md-8 col-sm-8 col-xs-6">
									<?php }else{ ?>
									<div class="col-md-4 col-sm-4 col-xs-6">
									<?php } ?>
										<div class="reviews-list__item">
											<?php if (!empty($blog['blogcat'])) { ?>
												<a class="reviews-list__item-btn-view " href="<?php echo $blog['blogcat']['href']; ?>">
													<?php echo $blog['blogcat']['name']; ?>
												</a>
											<?php } ?>
											<a href="<?php echo $blog['href']; ?>">
											<div class="reviews-list__item-img" style="background-image: url(<?php echo $blog['image']; ?>)">
												<div class="icons-block">
													<div class="looks">
														<span class="icon eye-icon">
															<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M10,4.4C3.439,4.4,0,9.232,0,10c0,0.766,3.439,5.6,10,5.6c6.56,0,10-4.834,10-5.6C20,9.232,16.56,4.4,10,4.4z M10,14.307  c-2.455,0-4.445-1.928-4.445-4.307c0-2.379,1.99-4.309,4.445-4.309c2.455,0,4.444,1.93,4.444,4.309  C14.444,12.379,12.455,14.307,10,14.307z M10,10c-0.407-0.447,0.663-2.154,0-2.154c-1.228,0-2.223,0.965-2.223,2.154  c0,1.189,0.995,2.154,2.223,2.154c1.227,0,2.223-0.965,2.223-2.154C12.223,9.453,10.346,10.379,10,10z"/></svg>
														</span>
														<?php echo $blog['viewed']; ?>
													</div>
													<?php if ($blog['commenrtsenable']) { ?>
													<div class="comments">
														<span class="icon typing-icon">
															<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M16,4H4C2.899,4,2,4.9,2,6v7c0,1.1,0.899,2,2,2h4l4,3v-3h4c1.1,0,2-0.9,2-2V6C18,4.9,17.1,4,16,4z M6,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C7.1,10.107,6.607,10.6,6,10.6z M10,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C11.1,10.107,10.607,10.6,10,10.6z M14,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C15.1,10.107,14.607,10.6,14,10.6z"/></svg>
														</span>
														<?php echo $blog['commentcount']; ?>
													</div>
													<?php } ?>
												</div>
											</div>
											</a>
											<div class="reviews-list__item-date">
												<?php echo $blog['date_added']; ?>
											</div>
											<div class="reviews-list__item-text">
												<a href="<?php echo $blog['href']; ?>">
													<?php echo $blog['title']; ?>
												</a>
											</div>
										</div>
									</div>
									<?php $s++; ?>
								<?php } ?>
							</div>
						</div>
						<?php if ($pagination) { ?>
						<div class="catalogue__content-bottom">
							<div class="catalogue__pagination" style="padding-top: 0;">
								<?php echo $pagination; ?>
							</div>
						</div>
						<?php } ?>	
						<?php if (isset($category_description)) { ?>
						<div class="cat-blog-inner">

								<?php echo $category_description; ?> 

						</div>
						<?php } ?>		
					</div>
					<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
				</div>
			</div>
		<?php echo $content_bottom ? '<div class="row"><div class="col-sm-12">' . $content_bottom . '</div></div>' : ''?>
	</div>
</main>
<?php echo $footer; ?></body></html>
