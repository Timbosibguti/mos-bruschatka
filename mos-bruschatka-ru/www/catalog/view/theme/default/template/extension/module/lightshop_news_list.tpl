		<!-- news -->
		
		<div class="news-min">
			<div class="container">
				<div class="section-title">
					<h2><?php echo $heading_title; ?></h2><a href="<?php echo $news_href; ?>"><?php echo $text_all_news; ?></a>
				</div>
				<ul class="news__list">
				<?php foreach ($newss as $news) { ?>
					<li class="news__list-item">
						<span class="news__date">
						<?php echo $news['date_added']; ?>
						</span>
						<span class="news__title">
							<a href="<?php echo $news['href']; ?>" class="news__link news__title-inner">
								<?php echo $news['title']; ?>
							</a>
						</span>
					</li>
				<?php } ?>
				</ul>
			</div>
		</div>

