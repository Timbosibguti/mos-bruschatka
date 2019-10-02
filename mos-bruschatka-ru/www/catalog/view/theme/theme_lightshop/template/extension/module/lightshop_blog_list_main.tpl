<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="section" id="wrapper">

	<?php echo $content_top ? $content_top : ''; ?>

	<div class="container">
		<h1 class="h1-blog">Блог</h1>
		<div class="blog">
			<div class="grid">
			<?php echo $column_left ? '<aside class="aside aside-left">' . $column_left . '</aside>' : ''?>
			<div class="col-sm-8 blog__left">
				<div class="reviews-list">
					<div class="row align-items-stretch">
						<?php $s = 1; ?>
						<?php foreach ($blogs as $blog) { ?>
							<?php if($s == 4) { ?>
							<div class="col-md-8 col-sm-8 col-6">
								<div class="reviews-list__item reviews-list__item-overlay card-link--no-bg text--white">
									<div class="reviews-list__item-img">
										<img data-src="<?php echo $blog['image']; ?>" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAABAAEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9/KKKKAP/2Q==" alt="<?php echo $blog['blogcat']['name']; ?>" />
									</div>
									<div class="reviews-list__item-overlay-bg">
										<?php if (!empty($blog['blogcat'])) { ?>
										<a class="reviews-list__item-btn-view text-sm" href="<?php echo $blog['blogcat']['href']; ?>" data-category="<?php echo $blog['blogcat']['name']; ?>">
											<?php echo $blog['blogcat']['name']; ?>
										</a>
										<?php } ?>
										<p class="text--white" style="margin-left: 15px;">Читать <strong>15 минут</strong></p>
										<a href="<?php echo $blog['href']; ?>" class="h3 text--white reviews-list__item-name">
											<?php echo $blog['title']; ?>
										</a>
										<div class="row no-gutters justify-content-between">
											<div class="reviews-list__item-info">
												<span class="reviews-list__item-views"><?php echo $blog['viewed']; ?> <i class="fa fa-eye" aria-hidden="true"></i></span>
												<span class="reviews-list__item-chat"><i class="fa fa-commenting" aria-hidden="true"></i> <?php echo $blog['commentcount']; ?></span>
												<span class="reviews-list__item-date"><?php echo $blog['date_added']; ?>г.</span>
											</div>
											<div class="reviews-list__item-share text-uppercase text-sm">
												<span class="reviews-list__item-share-btn"><i class="fa fa-heart-o" aria-hidden="true"></i> в избранное</span>
												<span class="reviews-list__item-share-btn"><i class="fa fa-share-alt" aria-hidden="true"></i> Поделиться</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<?php }else{ ?>
							<div class="col-md-4 col-sm-4 col-6">
								<div class="reviews-list__item card card-link">
									<a href="<?php echo $blog['href']; ?>">
									<div class="reviews-list__item-img">
										<img data-src="<?php echo $blog['image']; ?>" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAABAAEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9/KKKKAP/2Q==" alt="<?php echo $blog['blogcat']['name']; ?>" />
										<p class="text--white reviews-list__item-time">Читать <strong>15 минут</strong></p>
									</div>
									</a>
									<?php if (!empty($blog['blogcat'])) { ?>
									<a class="reviews-list__item-btn-view text-sm" href="<?php echo $blog['blogcat']['href']; ?>" data-category="<?php echo $blog['blogcat']['name']; ?>">
										<?php echo $blog['blogcat']['name']; ?>
									</a>
									<?php } ?>
									<a href="<?php echo $blog['href']; ?>" class="reviews-list__item-name">
										<?php echo $blog['title']; ?>
									</a>
									<div class="reviews-list__item-info text--color-4">
										<span class="reviews-list__item-views"><?php echo $blog['viewed']; ?> <i class="fa fa-eye" aria-hidden="true"></i></span>
										<span class="reviews-list__item-chat"><i class="fa fa-commenting" aria-hidden="true"></i> <?php echo $blog['commentcount']; ?></span>
										<span class="reviews-list__item-date"><?php echo $blog['date_added']; ?>г.</span>
									</div>
									<div class="reviews-list__item-share text-uppercase text-sm text--blue">
										<span class="reviews-list__item-share-btn"><i class="fa fa-heart-o" aria-hidden="true"></i> в избранное</span>
										<span class="reviews-list__item-share-btn"><i class="fa fa-share-alt" aria-hidden="true"></i> Поделиться</span>
									</div>
								</div>
							</div>
							<?php } ?>
							<?php $s++; ?>
						<?php } ?>
					</div>
				</div>
				<?php if ($pagination) { ?>
				<div class="catalogue__content-bottom">
					<div class="catalogue__pagination">
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
			<?php echo $column_right ? '<aside class="aside aside-right col-sm-3 blog__right">' . $column_right . '</aside>' : ''?>
		</div>
	</div>

	<?php echo $content_bottom ? $content_bottom : ''; ?>
	</div>
</main>
<?php echo $footer; ?>
</body></html>