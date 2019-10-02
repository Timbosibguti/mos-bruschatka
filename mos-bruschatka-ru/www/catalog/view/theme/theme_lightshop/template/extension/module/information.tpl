<div class="sidebar">
	<a href="#sidebar-information" class="js-popup-call sidebar-mobile-btn"><?php echo $text_lightshop_information; ?></a>
	<div class="popup left popup-nav" id="sidebar-information">
	<span class="popup-close js-popup-close"><svg class="icon-chevron-left"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#chevron-small-left"></use></svg></span>
	<span class="popup__title"><?php echo $text_lightshop_information; ?></span>
	<div class="nav-submenu nav-submenu--sidebar">
		<ul class="nav-submenu__list">
        <?php foreach ($informations as $information) { ?>
            <li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
        <?php } ?>
		<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $contact; ?>" ><?php echo $text_contact; ?></a></li>
		<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $sitemap; ?>" ><?php echo $text_sitemap; ?></a></li>
		</ul>
	</div>
	</div>
</div>