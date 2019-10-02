	<?php if (!empty($blogs)) { ?>	
		<div class="section section--highlight blog--module js-fade-in">
			<div class="container container--constraint">
				<div class="h2 blog--module__title">Советы экспертов<br />по выбору и укладке плитки <a href="<?php echo $blog_href; ?>" class="text-sm about-video__link">Все статьи <i class="fa fa-angle-right"></i></a></div >
				<div class="blog__list-container">
					<div class="blog__list-inner">
						<ul class="blog__list">
							<?php foreach ($blogs as $blog) { ?>
							<li class="blog__list-item">
								<div class="blog__img">
									<a href="<?php echo $blog['href']; ?>"><img data-src="<?php echo $blog['image']; ?>" src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAIBAQIBAQICAgICAgICAwUDAwMDAwYEBAMFBwYHBwcGBwcICQsJCAgKCAcHCg0KCgsMDAwMBwkODw0MDgsMDAz/2wBDAQICAgMDAwYDAwYMCAcIDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAz/wAARCAABAAEDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9/KKKKAP/2Q==" alt=""></a>
								</div>
								<span class="blog__title">
									<a href="<?php echo $blog['href']; ?>" class="blog__title-link">
										<?php echo $blog['title']; ?>
									</a>
								</span>
								<span class="blog__time">
								<?php echo $blog['date_added']; ?>
								</span>
							</li>
							<?php } ?>
						</ul>
					</div>	
				</div>		
			</div>
		</div>
	<?php } ?>