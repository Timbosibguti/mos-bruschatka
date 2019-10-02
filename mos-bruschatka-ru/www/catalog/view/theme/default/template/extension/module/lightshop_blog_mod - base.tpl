	<?php if (!empty($blogs)) { ?>	
		<div class="blog--module">
			<div class="container">
				<div class="section-title">
					<h2><?php echo $heading_title; ?></h2><a href="<?php echo $blog_href; ?>"><?php echo $text_all_blogs; ?></a>
				</div>
				<div class="blog__list-container">
					<div class="blog__list-inner">
						<ul class="blog__list">
							<?php foreach ($blogs as $blog) { ?>
							<li class="blog__list-item">
								<div class="blog__img">
									<a href="<?php echo $blog['href']; ?>"><img src="<?php echo $blog['image']; ?>" alt=""></a>
								</div>
								<span class="blog__time">
								<?php echo $blog['date_added']; ?>
								</span>
								<span class="blog__title">
									<a href="<?php echo $blog['href']; ?>" class="blog__title-link">
										<?php echo $blog['title']; ?>
									</a>
								</span>
								<!-- <span class="blog__text">
									<a href="<?php echo $blog['href']; ?>" class="blog__text-link">
										<?php echo $blog['description']; ?>
									</a>
								</span> -->
							</li>
							<?php } ?>
						</ul>
					</div>	
				</div>		
			</div>
		</div>
	<?php } ?>