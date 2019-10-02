<div class="catalogue__categories">
	<div class="nav-submenu nav-submenu--sidebar">
		<ul class="nav-submenu__list">
			<?php foreach ($categories as $category) { ?>
			<?php if ($category['category_id'] == $category_id) { ?>
			<li class="nav-submenu__list-item"><a class="nav-submenu__link active" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
			<?php if ($category['children']) { ?>
			<?php foreach ($category['children'] as $child) { ?>
			<?php if ($child['category_id'] == $child_id) { ?>
			<li class="nav-submenu__list-item"><a class="nav-submenu__link active" href="<?php echo $child['href']; ?>">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a></li>
			<?php } else { ?>
			<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $child['href']; ?>">&nbsp;&nbsp;&nbsp;- <?php echo $child['name']; ?></a></li>
			<?php } ?>
			<?php } ?>
			<?php } ?>
			<?php } else { ?>
			<li class="nav-submenu__list-item"><a class="nav-submenu__link" href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
			<?php } ?>
			<?php } ?>
		</ul>
	</div>
</div>