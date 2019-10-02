<?php echo $header; ?>
<main class="section" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>
	<div class="container">			
		<section class="main-section">
			<div class="h2 mb-30">Реализованные проекты</div>
			<div class="projects-banner js-bg-img" data-bg="fabian-mardi.jpg">
				<div class="projects-banner__title">
					<p class="h2 text--white mb-10">Акция!</p>
					<p class="h3 text--white">Дизайн-проект бесплатно при заказе от 200 м2</p>
				</div>
				<a href="javascript:void(0);" class="mb-0 btn btn--inline btn--yellow">я участвую!</a>
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

								<img src="<?php echo placeholder_img; ?>" data-src="<?php echo $project['thumb']; ?>" alt="<?php echo $project['name']; ?>" height="<?php echo $project['thumb_height']; ?>" width="<?php echo $project['thum_width']; ?>" />

								<div class="text-left">
									<span class="text--white projects-tabs__item-group bg--<?php echo $project['group']['color']; ?>">
										<svg width="12" height="12" class="icon icon--home"><use xlink:href="#<?php echo $project['group']['icon']; ?>"></use></svg><?php echo $project['group']['name']; ?>
									</span>
								</div>

								<h3 class="text--white"><?php echo $project['name']; ?></h3>
								<div class="projects-tabs__item-hovered">
									<p class="projects-tabs__item-hovered-text"><svg height="20" width="20" class="icon icon--zoom-in"><use xlink:href="#iconZoomInBtn"></use></svg> Подробнее</p>
								</div>
							</a>
						</div>
						<?php } ?>
					</div>
				</div>
				<div class=""><?php echo $pagination; ?></div>
			</div>
		</section>
	</div><!-- container -->
	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<?php echo $footer; ?>
</body></html>