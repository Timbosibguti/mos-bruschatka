<?php
	$this->load->model('tool/image');

	$images = [];

	$imgList = [
		'catalog/office/1.jpg',
		'catalog/office/2.jpg',
		'catalog/office/3.jpg',
		'catalog/office/6.jpg',
		'catalog/office/7.jpg',
		'catalog/office/8.jpg',
		'catalog/office/9.jpg',
		'catalog/office/10.jpg'
	];

	foreach($imgList as $image) {
	$images[] = [
			'thumb'		=> $this->model_tool_image->resize($image, 555, 450),
			'mini'		=> $this->model_tool_image->resize($image, 140, 100)
		];
	}
?>
<div class="section about" id="about">
	<div class="container container--constraint">
		<div class="row">
			<div class="col-md-5">
				<h2 class="whitespace-nowrap">РостовБрусчатка</h2>
				<h3 class="about__sub-title">крупнейший магазин<br />тротуарной плитки<br />в Ростове</h3>
				<ul class="about__list">
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-christmas-day about__icon-block"></div>
						<p><span class="text--yellow text--bold">25 лет на рынке</span> тротуарной плитки</p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-hand about__icon-block"></div>
						<p><span class="text--yellow text--bold">шоу-рум</span> в центре Ростова </p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-team about__icon-block"></div>
						<p><span class="text--yellow text--bold">74 штатных сотрудника</span> в 5 офисах РФ</p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-factory2 about__icon-block"></div>
						<p><span class="text--yellow text--bold">современное производство</span> на 3500 м<sup>2</sup>/сутки</p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-worker about__icon-block"></div>
						<p><span class="text--yellow text--bold">80 сертифицированных</span> бригад укладчиков</p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-pantone about__icon-block"></div>
						<p><span class="text--yellow text--bold">25 000 м <sup>2</sup> плитки</span> в наличии ,более 500  моделей</p>
					</li>
					<li class="about__list-item">
						<div class="svg-border svg-border--50 icon-house-big about__icon-block"></div>
						<p><span class="text--yellow text--bold">8 точек отгрузки</span> и самовывоза по Ростову</p>
					</li>
				</ul>
			</div>
			<div class="col-md-7">
				<div class="about__slider js-about-slider mb-20">
					<?php foreach($images as $image) { ?>
					<div class="about__slider-item">
						<img data-src="<?php echo $image['thumb']; ?>" alt="" />
					</div>
					<?php } ?>
				</div>
				<div class="about__nav-slider js-about-nav-slider">
					<?php foreach($images as $image) { ?>
					<div class="about__slider-nav-item">
						<img data-src="<?php echo $image['mini']; ?>" alt="" />
					</div>
					<?php } ?>
				</div>
			</div>
		</div>
	</div><!-- container -->
</div>
