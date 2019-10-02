<div class="section projects" id="projects">
	<div class="container container--constraint">
		<div class="h2 projects__h2">Наши свежие работы</div>
		<div class="projects-slideshow-titles js-projects-slideshow-titles">
			<?php foreach($projects as $project) { ?>
			<h3 class="projects__item-title"><?php echo $project['name']; ?></h3>
			<?php } ?>
		</div>
		<div class="projects__slideshow-imgs js-projects-slideshow-imgs">
			<?php foreach($projects as $project) { ?>
			<div class="projects__item-imgs">
				<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $project['thumb']; ?>" alt="" class="projects__item-img" />
			</div>
			<?php } ?>
		</div>
		<div class="projects__slideshow-infos js-projects-slideshow-infos">
			<?php foreach($projects as $project) { ?>
			<div class="projects__item-info">
				<div class="projects__item-row">
					<div class="projects__item-col">
						<p class="projects__text-small">Дата начала работы</p>
						<p><?php echo $project['start_date']; ?></p>
						<p class="projects__text-small">Дата окончания работы</p>
						<p class="projects__text mb-25"><?php echo $project['end_date']; ?></p>
					</div>
					<div class="projects__item-col">
						<p class="projects__text-small">Список произведенных работ</p>
						<ol>
							<li>Замеры территории</li>
							<li>Дизайн-проект</li>
							<li>Доставка</li>
							<li>Укладка</li>
						</ol>
					</div>
					<div class="projects__item-col">
						<p class="projects__text-small">Использованные материалы</p>
						<ul>
							<?php foreach($project['materials'] as $material) { ?>
							<li><?php echo $material; ?></li>
							<?php } ?>
						</ul>
					</div>
				</div>
			</div>
			<?php } ?>
		</div>
	</div>
</div>