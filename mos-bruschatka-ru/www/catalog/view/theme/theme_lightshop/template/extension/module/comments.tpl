<div>
<div class="section section--highlight comments-home tabs" id="comments">
	<div class="container">
		<div class="comments-home__row">
			<div class="comments-home__col">
				<div class="h2 comments-home__h2">Все еще  ищете  поставщика  плитки?</div>
				<h3 class="comments-home__h3">Они уже нашли!</h3>
				<button type="button" class="btn btn--inline comments-home__btn js-slick-filter" data-slick-filter=".filter-classic" data-slick-slider=".js-comments-home-slider">классические отзывы</button><br />
				<button type="button" class="btn btn--inline comments-home__btn js-slick-filter" data-slick-filter=".filter-video" data-slick-slider=".js-comments-home-slider">видеоотзывы</button><br />
			</div>
			<div class="comments-home__col">
				<div class="comments-home__slider js-comments-home-slider">
					<?php foreach ($comments as $banner) { ?>
						<?php foreach ($banner as $comment) { ?>
						<div class="comments-home__item comments-home__item--classic filter-classic">
							<div class="comments-home__item-content">
								<div class="comments-home__item-title"><?php echo $comment['text_big']; ?></div>
								<div class="comments-home__item-body"><?php echo $comment['text_small']; ?></div>
								<div class="comments-home__item-footer">
									<div class="comments-home__item-footer__float-left">
										<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $comment['thumb_profil']; ?>"alt="" class="comments-home__item-profil" />
										<span class="text--bold"><?php echo $comment['author']; ?></span>
									</div>
									<div class="comments-home__item-footer__float-right">
										<div class="comments-home__item-location"><?php echo $comment['location']; ?></div>
										<div class="text-sm"><?php echo $comment['date']; ?></div>
									</div>
								</div>
							</div>
							<div class="comments-home__item-showcase js-load-bg" data-src="<?php echo $comment['thumb_showcase']; ?>"></div>
						</div>
						<?php } ?>
					<?php } ?>
				<div class="comments-home__item filter-video">
					<div class="youtube js-youtube" data-embed="cex93T2JnNU" id="commentsHomeVideo1"> 
						<div class="play-button"></div> 
					</div>
				</div>
				<div class="comments-home__item filter-video">
					<div class="youtube js-youtube" data-embed="THiYtdnPUQo" id="commentsHomeVideo2"> 
						<div class="play-button"></div> 
					</div>
				</div>
				<div class="comments-home__item filter-video">
					<div class="youtube js-youtube" data-embed="lrKnk7b6QTU" id="commentsHomeVideo3"> 
						<div class="play-button"></div> 
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</div>
