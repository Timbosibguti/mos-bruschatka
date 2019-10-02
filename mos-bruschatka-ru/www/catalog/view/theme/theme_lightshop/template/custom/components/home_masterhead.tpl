<div class="masterhead js-load-bg" id="masterhead" data-src="<?php echo $store['thumb']; ?>">
	<div class="masterhead__overlay">
		<div class="container container--constraint">
			<h3 class="masterhead__sub-title"><?php echo $store['sub_title']; ?></h3>
			<h1 class="masterhead__title"><?php echo $store['title']; ?></h1>
			<ul class="masterhead__list">
				<?php foreach($store['descr'] as $item) { ?>
                <li class="masterhead__list-item icon-checked-light"><?php echo $item; ?></li>
                <?php } ?>
			</ul>
			<button data-target="<?php echo $store['button_target']; ?>" class="btn btn--inline btn--yellow masterhead__btn <?php echo ($store['version'] == 1) ? 'js-anim-scroll' : 'js-modal icon-download'; ?>"><?php echo $store['button_text']; ?></button>
		</div><!-- container -->
	</div>
</div>