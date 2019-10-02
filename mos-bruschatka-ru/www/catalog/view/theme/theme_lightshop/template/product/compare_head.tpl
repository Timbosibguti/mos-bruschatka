						<span class="account__title"><svg class="icon-add-to-list"><use xlink:href="#list"></use></svg><?php echo $text_lightshop_comp_head; ?>
							<?php  echo '('.$countcomp.')';  ?>
						</span>
						<?php if ($productscomp) { ?>
						<ul class="account__list">
						  
							  <?php  foreach ($productscomp as $key => $product) { ?>
								<li class="account__list-item">
									<div class="account__list-img">
										<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt=""></a>
									</div>
									<span class="link"><a href="<?php echo $product['href']; ?>" class="link--brown"><?php echo $product['name']; ?></a></span>
								</li>
							  <?php } ?>
						</ul>
						<?php echo $text_compare_href; ?>
						<?php } else { ?>
							<span class="account__empty-text">
								<span><?php echo $text_empty_compare; ?></span>
							</span>
						<?php } ?>
