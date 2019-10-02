<?php echo $header; ?>

<main class="container--rd" id="wrapper">

	<?php echo $content_top ? $content_top : ''; ?>

	<?php if ($blog_background) { ?>
		<div class="blog-top">

			<div class="blog-top__bg">
			</div>

			<div class="info-overlay">
				<div class="container">
					<div class="info-wrap">
						<div class="breadcrumb">
							<ul class="breadcrumb__list">
							<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
								<?php if($i == 0) { ?>
									<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>>🏡</span></a></li>
								<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
									<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a data-href="#categories-popup<?php echo $i; ?>" class="js-popup-call-hover-off breadload" data-id="<?php echo $breadcrumb['cat_id']; ?>" data-i="<?php echo $i; ?>" href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
								<?php } else { ?>
									<li class="breadcrumb__list-item"><?php echo $breadcrumb['text']; ?></li>
								<?php } ?>
							<?php } ?>
							</ul>
						</div>
						
						<div class="info-block">
						
							<h1 class="blog-top__title"><?php echo $heading_title; ?></h1>

							<div class="icons-block text--white text-sm">
								<span class="icon-views">
									<?php echo $viewed; ?>
									<i class="fa fa-eye" aria-hidden="true"></i>
								</span>
								<?php if ($commenrtsenable) { ?>
								<span class="icon-chat">
									<i class="fa fa-commenting" aria-hidden="true"></i>
									<?php echo $totalComments; ?> Комментариев
								</span>
								<?php } ?>
								<span class="blog-top__date"><?php echo $date_added; ?>г.</span>
								<span class="blog-top__share-btn">Поделиться <i class="fa fa-share-alt" aria-hidden="true"></i></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<?php } else { ?>
		<div class="container">
			<div class="breadcrumbs breadcrumbs--sm-pad">
				<ul class="breadcrumb__list">
				<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
				<?php if($i == 0) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>
				<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
					<li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>><span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span></a></li>		
				<?php } else { ?>
					<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><?php echo $breadcrumb['text']; ?></li>		
				<?php } ?>
				<?php } ?> 			
				</ul>
			</div>
			
			<div class="h2 blog-top__title"><?php echo $heading_title; ?></div>
		</div>
		<?php } ?>


		<div class="blog-inner">

			<div class="blog-inner__top">
				<div class="container">
					<p  class="blog-inner__top-row">
						<i class="fa fa-clock-o" aria-hidden="true"></i> 
						<span>Время чтения: <strong>15 минут</strong></span>
					</p>
					<form class="blog-form" action="">
						<h3>Отправим материал Вам на:</h3>
						<input class="blog-form__input" id="email" type="radio" checked value="email" name="sposob">
						<label for="email" class="col-md-2 blog-form__items">
							<i class="fa fa-envelope-open-o" aria-hidden="true"></i>
							<span>Почту</span>
						</label>
						<input class="blog-form__input" id="WhatsApp" type="radio" value="WhatsApp" name="sposob">
						<label for="WhatsApp" class="col-md-2 blog-form__items">
							<i class="fa fa-whatsapp" aria-hidden="true"></i>
							<span>WhatsApp</span>	
						</label>
						<input class="blog-form__input" id="telegram" type="radio" value="telegram" name="sposob">
						<label for="telegram" class="col-md-2 blog-form__items">
							<i class="fa fa-telegram" aria-hidden="true"></i>
							<span>Телеграм</span>
						</label>
						<div class="col-md-5 blog-form__data">
							<input type="text" placeholder="Имя" required>
							<input class="js-blog__input" type="email" placeholder="mail@mail.ru" required>
							<div class="privacy-info privacy-info--inline">Отправляя форму Вы соглашаетесь с 
							<a href="/privacy" data-fancybox="" data-filter=".editor" data-type="ajax">политикой конфиденциальности</a></div>
							<button class="btn btn--inline btn--yellow" type="button">ПОЛУЧИТЬ МАТЕРИАЛ!</button>
						</div>
					</form>
					<div class="blog-inner__top-video">
						<div class="blog-inner__top-video">
							<div class="youtube js-youtube" data-embed="5yYXEfHtwn4">
								<div class="play-button"></div> 
							</div>
						</div>
					</div>	
				</div>
			</div>

			<section class="section">
				<div class="container">
					<article class="blog-inner__editor">
						<?php echo $description; ?>
					</article>
				</div>
			</section>

			<div class="section--gradient-blue blog-inner__transition">
				<div class="container">
					<div class="blog-inner__transition-row">
						<div class="svg-block svg-block--mail">
							<i class="fa fa-envelope-o blog-icon__mail" aria-hidden="true"></i>
						</div>

						<div class="blog-inner__transition-col">
							<h3 class="blog-inner__transition-title">Введите Ваши данные, чтобы получить эту статью на почту!</h3>

							<form action="javascri[t:voi(0);" class="blog-inner__transition-form">
								<input type="name" name="name" placeholder="" class="input input--inline">
								<input type="mail" name="mail" placeholder="" class="input input--inline">
								<div class="privacy-info privacy-info--inline privacy-info--white">Отправляя форму Вы соглашаетесь с <a href="/privacy">политикой конфиденциальности</a></div>
								<buton type="button" class="btn btn--inline btn--yellow">получить!</buton>
							</form>
						</div>
					</div>
				</div>
			</div>

		</div>

	<?php echo $content_bottom ? $content_bottom : ''; ?>
</main>
<?php echo $footer; ?>
<script>
	$('.js-blog__input').inputmask({alias:"email", "clearIncomplete": true});
	
    $('input[name="sposob"]').change( function() {
        
        if ($('input[name="sposob"]:checked').val() !== 'email') {
        	$('.js-blog__input').inputmask({mask:"+ 7 (999) 999 - 99 - 99", clearIncomplete: true});
            $('.js-blog__input').attr('name', 'phone')
            $('.js-blog__input').attr('type', 'phone')
            $('.js-blog__input').attr('placeholder', '+ 7 (999) 999-99-99')
        }
        else{
        	$('.js-blog__input').inputmask({alias:"email", "clearIncomplete": true});
            $('.js-blog__input').attr('name', 'email')
            $('.js-blog__input').attr('type', 'email')
            $('.js-blog__input').attr('placeholder', 'mail@mail.ru')
        }
        $('.js-blog__input').val('');
        
    });

</script>
</body></html>
