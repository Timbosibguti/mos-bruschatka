						<span class="account__title"><svg class="icon-heart"><use xlink:href="#heart"></use></svg><?php echo $text_lightshop_wish_head; ?>
							<?php echo '('.$count.')'; ?>
						</span>
						<?php if ($islogged) { ?>
							<?php if ($productswish) { ?>
								
								<ul class="account__list">
								  <?php if ($islogged) { ?>
									  <?php  foreach ($productswish as $key => $product) { ?>
										<li class="account__list-item">
											<div class="account__list-img">
												<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt=""></a>
											</div>
											<span class="link"><a href="<?php echo $product['href']; ?>" class="link--brown"><?php echo $product['name']; ?></a></span>
										</li>
									  <?php } ?>		   
								   <?php } ?>
								</ul>
								<?php echo $text_wish_href; ?>
							<?php } else { ?>
								<span class="account__empty-text">
									<span><?php echo $text_empty_wish; ?></span>
								</span>	
							<?php } ?>
						<?php } else { ?>
						<span class="account__empty-text">
							<span><?php echo $text_islogged; ?></span>
						</span>
						<?php } ?>
