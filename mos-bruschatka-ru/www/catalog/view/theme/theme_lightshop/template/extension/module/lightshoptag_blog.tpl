
<?php if (!empty($tags)) { ?>
						<div class="blog-tags card">
							<h3 class="blog-widget__title"><?php echo $heading_title; ?></h3>
							<?php foreach ($tags as $tag) { ?>
							<div class="blog-tags__items">
								<a class="blog-tags__link" href = "<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?>
									<span class="count"><?php echo $tag['total']; ?></span>
								</a>
							</div>	
							<?php } ?>
						</div>
<?php } ?>
