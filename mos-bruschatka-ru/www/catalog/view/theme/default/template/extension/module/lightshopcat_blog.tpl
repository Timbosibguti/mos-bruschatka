<div class="sidebar">
	<!--<a href="#sidebar-navigation" class="js-popup-call sidebar-mobile-btn"><?php echo $heading_title; ?></a>-->
	<div class="popup left popup-nav" id="sidebar-navigation">
	<span class="popup-close js-popup-close"><svg class="icon-chevron-left"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#chevron-small-left"></use></svg></span>
	<span class="popup__title"><?php echo $heading_title; ?></span>
	<div class="popup__submenu-scroll">

						<div class="blog-widget">
							<div class="blog-widget__title"><?php echo $heading_title; ?></div>
							<div class="blog-line"></div>
							<div class="blog-widget__list">								
								<ul class="list-unstyled">
								<?php foreach ($blogcategories as $category) { ?>	
									<li class="blog-widget__list-item">
										<a href = "<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
										<span class="count" ><?php echo $category['count']; ?></span>
									</li>
								<?php } ?>	
								</ul>
							</div>
						</div>
	</div>
	</div>
</div>