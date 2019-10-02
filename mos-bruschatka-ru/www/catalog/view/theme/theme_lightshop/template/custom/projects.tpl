<?php echo $header; ?>
<main class="section" id="wrapper">
	<div class="container">
        <?php if ($content_top) { ?>
            <?php echo $content_top; ?>
        <?php } ?>
		<section class="main-section">
			<div class="projects-map section--highlight">
				<div class="projects-map__iframe"><iframe class="js-load-iframe" data-src="https://www.google.com/maps/d/embed?mid=1HYg41BIonLmrXvRCKrlOzONN4S4&amp%3Bz=9%3Fscroll%3Dfalse&ll=55.727831830373766%2C37.205404142968746&z=8" width="100%" height="400"></iframe></div>
			</div>
			<div class="projects-tabs">
				<div class="projects-tabs__btns mb-30">
					<a href="<?php echo $link; ?>" class="btn btn--spacing btn--gray projects-tabs__btn js-ajax" data-target="#projectsItems" data-options="btnStatus: true,"><svg width="18" height="19" class="icon icon--home"><use xlink:href="#iconList"></use></svg>Все проекты</a>
					<?php foreach($groups as $group) { ?>
					<a href="<?php echo $group['href']; ?>" class="btn btn--spacing btn--gray projects-tabs__btn js-ajax" data-target="#projectsItems">
						<svg width="18" height="19" class="icon icon--home"><use xlink:href="#<?php echo $group['icon']; ?>"></use></svg><?php echo $group['name']; ?></a>
					<?php } ?>
				</div>
				<div id="projectsItems">
					<div class="row">
						<?php foreach($projects as $project) { ?>
						<div class="col-6 col-md-4">
							<a href="javascript:void(0);" class="projects-tabs__item">

								<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $project['thumb']; ?>" alt="<?php echo $project['name']; ?>" />

								<div class="text-left">
									<span class="text--white projects-tabs__item-group bg--<?php echo $groups[$project['group']]['color']; ?>">
										<svg width="12" height="12" class="icon icon--home"><use xlink:href="#<?php echo $groups[$project['group']]['icon']; ?>"></use></svg><?php echo $groups[$project['group']]['name']; ?>
									</span>
								</div>

								<h3 class="text--white"><?php echo $project['name']; ?></h3>
							</a>
						</div>
						<?php } ?>
					</div>
				</div>
			</div>
		</section>
	</div><!-- container -->
	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<?php echo $footer; ?>
</body></html>
