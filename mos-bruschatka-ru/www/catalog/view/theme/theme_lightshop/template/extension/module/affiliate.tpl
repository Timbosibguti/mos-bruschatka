<div class="sidebar">
	<a href="#sidebar-navigation" class="js-popup-call sidebar-mobile-btn"><?php echo $text_lightshop_menu; ?></a>
	<div class="popup left popup-nav" id="sidebar-navigation">
	<span class="popup-close js-popup-close"><svg class="icon-chevron-left"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#chevron-small-left"></use></svg></span>
	<span class="popup__title"><?php echo $text_lightshop_menu; ?></span>
	<div class="popup__submenu-scroll">
		<div class="nav-submenu nav-submenu--sidebar">
			<ul class="nav-submenu__list">
				<?php if (!$logged) { ?>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $login; ?>"><?php echo $text_login; ?></a></li>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $register; ?>"><?php echo $text_register; ?></a></li>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
				<?php } ?>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $account; ?>"><?php echo $text_account; ?></a>
				<?php if ($logged) { ?>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $password; ?>"><?php echo $text_password; ?></a>
				<?php } ?>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a>
				<?php if ($logged) { ?>
				<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $logout; ?>"><?php echo $text_logout; ?></a>
				<?php } ?>
			</ul>
		</div>
	</div>
	</div>
</div>