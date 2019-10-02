<div class="catalogue__news">

	<span class="catalogue__news-title">
		<?php echo $heading_title; ?>
	</span>

		<ul class="catalogue__news-list">
        <?php foreach ($newss as $news) { ?>
            <li class="catalogue__news-list-item">
				<div class="catalogue__news-text">
					<span class="catalogue__news-span">
						<?php echo $news['date_added']; ?>
					</span>
					<span class="catalogue__news-link">
						<a href="<?php echo $news['href']; ?>" class="catalogue__news-link-inner">
							<?php echo $news['title']; ?>
						</a>
					</span>					
				</div>
			</li>
        <?php } ?>
		</ul>

</div>

