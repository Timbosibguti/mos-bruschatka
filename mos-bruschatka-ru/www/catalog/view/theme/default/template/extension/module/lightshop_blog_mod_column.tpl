	<?php if (!empty($blogs)) { ?>	

	<div class="catalogue__news">

	<span class="catalogue__news-title">
		<?php echo $heading_title; ?>
	</span>

		<ul class="catalogue__news-list">
        <?php foreach ($blogs as $blog) { ?>
            <li class="catalogue__news-list-item">
				<div class="catalogue__news-img">
					<a href="<?php echo $blog['href']; ?>"><img src="<?php echo $blog['image']; ?>" alt="<?php echo $blog['title']; ?>"></a>
				</div>
				<div class="catalogue__news-text catalogue__news-text--img">
					<span class="catalogue__news-span">
						<?php echo $blog['date_added']; ?>
					</span>
					<span class="catalogue__news-link">
						<a href="<?php echo $blog['href']; ?>" class="catalogue__news-link-inner">
							<?php echo $blog['title']; ?>
						</a>
					</span>					
				</div>
			</li>
        <?php } ?>
		</ul>

	</div>

	<?php } ?>