

						<div class="blog-tags">
							<div class="blog-widget__title"><?php echo $heading_title; ?></div>
							<div class="blog-line"></div>
							<?php foreach ($tags as $tag) { ?>
								<a class="btn btn--transparent" href = "<?php echo $tag['href']; ?>"><?php echo $tag['tag']; ?>
									<span class="count"><?php echo $tag['total']; ?></span>
								</a>
							<?php } ?>
						</div>

