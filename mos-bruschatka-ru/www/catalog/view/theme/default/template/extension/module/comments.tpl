<div class="section section--highlight comments-home js-fade-in" id="comments">
	<div class="container">
		<div class="comments-home__row">
			<div class="comments-home__col">
				<div class="h2 comments-home__h2">Все еще  ищете  поставщика  плитки?</div>
				<h3 class="comments-home__h3">Они уже нашли!</h3>
				<button type="button" class="btn btn--inline comments-home__btn js-comments-home-btn" data-target="classic">классические отзывы</button><br />
				<button type="button" class="btn btn--inline comments-home__btn js-comments-home-btn" data-target="video">видеоотзывы</button><br />
				<button type="button" class="btn btn--inline comments-home__btn js-comments-home-btn" data-target="map">карта отзывы</button>
			</div>
			<div class="comments-home__col">
				<div class="comments-home__col-sub js-comments-home-col-sub" data-target="classic">
					<div class="comments-home__slideshow js-comments-home-slideshow">
					<?php foreach ($comments as $banner) { ?>
						<?php foreach ($banner as $comment) { ?>
						<div class="comments-home__item">
							<div class="comments-home__item-content">
								<div class="comments-home__item-title"><?php echo $comment['text_big']; ?></div>
								<div class="comments-home__item-body"><?php echo $comment['text_small']; ?></div>
								<div class="comments-home__item-footer">
									<div class="comments-home__item-footer__float-left">
										<img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $comment['profil']; ?>" height="100%" width="100%" alt="" class="comments-home__item-profil">
										<span class="text--bold"><?php echo $comment['author']; ?></span>
									</div>
									<div class="comments-home__item-footer__float-right">
										<div class="comments-home__item-location"><?php echo $comment['location']; ?></div>
										<div class="text-sm"><?php echo $comment['date']; ?></div>
									</div>
								</div>
							</div>
							<div class="comments-home__item-img"><img src="<?php echo $placeholder_img; ?>" data-src="../image/<?php echo $comment['image']; ?>" height="100%" width="100%" alt="" height="500" width="250"></div>
						</div>
						<?php } ?>
					<?php } ?>
					</div>
				</div>
				<div class="comments-home__col-sub js-comments-home-col-sub" data-target="video">
					<div class="comments-home__videos-slideshow js-comments-home-videos-slideshow">
						<div class="comments-home__videos-item">
							<div class="youtube js-youtube" data-embed="cex93T2JnNU"> 
								<div class="play-button"></div> 
							</div>
						</div>
						<div class="comments-home__videos-item">
							<div class="youtube js-youtube" data-embed="THiYtdnPUQo"> 
								<div class="play-button"></div> 
							</div>
						</div>
						<div class="comments-home__videos-item">
							<div class="youtube js-youtube" data-embed="lrKnk7b6QTU"> 
								<div class="play-button"></div> 
							</div>
						</div>
					</div>
				</div>
				<div class="comments-home__col-sub js-comments-home-col-sub" data-target="map">
					<div class="comments-home__map">
						<img src="../image/catalog/map.png" alt="" width="100%" />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
