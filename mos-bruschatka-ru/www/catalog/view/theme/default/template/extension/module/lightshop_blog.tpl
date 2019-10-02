<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>

<main class="content">

	<?php echo $content_top; ?>
	<?php if ($blog_background) { ?>
		<div class="blog-top">
			<img src="<?php echo $image; ?>" alt="<?php echo $heading_title; ?>">
			<div class="info-wrap" style="background-image: url(<?php echo $image; ?>)">
				<div class="info-block text-center">
					<div class="breadcrumbs">
						<ul class="breadcrumb__list">
							<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
							<?php if($i == 0) { ?>
								<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>
							<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
								<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>" itemprop="url"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></a></li>		
							<?php } else { ?>
								<li itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span itemprop="title"><?php echo $breadcrumb['text']; ?></span></li>
							<?php } ?>
							<?php } ?> 	
						</ul>
					</div>
					<h1 class="content__title"><?php echo $heading_title; ?></h1>

					<div class="icons-block">
						<div class="looks">
							<span class="icon eye-icon">
								<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M10,4.4C3.439,4.4,0,9.232,0,10c0,0.766,3.439,5.6,10,5.6c6.56,0,10-4.834,10-5.6C20,9.232,16.56,4.4,10,4.4z M10,14.307  c-2.455,0-4.445-1.928-4.445-4.307c0-2.379,1.99-4.309,4.445-4.309c2.455,0,4.444,1.93,4.444,4.309  C14.444,12.379,12.455,14.307,10,14.307z M10,10c-0.407-0.447,0.663-2.154,0-2.154c-1.228,0-2.223,0.965-2.223,2.154  c0,1.189,0.995,2.154,2.223,2.154c1.227,0,2.223-0.965,2.223-2.154C12.223,9.453,10.346,10.379,10,10z"/></svg>
							</span>
							<?php echo $viewed; ?>
						</div>
						<?php if ($commenrtsenable) { ?>
						<div class="comments">
							<span class="icon typing-icon">
								<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M16,4H4C2.899,4,2,4.9,2,6v7c0,1.1,0.899,2,2,2h4l4,3v-3h4c1.1,0,2-0.9,2-2V6C18,4.9,17.1,4,16,4z M6,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C7.1,10.107,6.607,10.6,6,10.6z M10,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C11.1,10.107,10.607,10.6,10,10.6z M14,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C15.1,10.107,14.607,10.6,14,10.6z"/></svg>
							</span>
							<?php echo $totalComments; ?>
						</div>
						<?php } ?>
						<div class="blog-top-date"><?php echo $date_added; ?></div>
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
			<h1 class="content__title"><?php echo $heading_title; ?></h1>
			</div>
			<?php } ?>
		<div class="blog-inner">
			<div class="btns-block clearfix">
				<?php if ($soc_share_blog) { ?>
				<div class="left">
					<button class="btn--transparent share-btn">
						<span class="icon share-icon">
							<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" style="enable-background:new 0 0 20 20;" xml:space="preserve"><path d="M15,13.442c-0.633,0-1.204,0.246-1.637,0.642l-5.938-3.463C7.471,10.433,7.5,10.237,7.5,10.037S7.471,9.642,7.425,9.454  L13.3,6.025C13.746,6.442,14.342,6.7,15,6.7c1.379,0,2.5-1.121,2.5-2.5S16.379,1.7,15,1.7s-2.5,1.121-2.5,2.5  c0,0.2,0.029,0.396,0.075,0.583L6.7,8.212C6.254,7.796,5.658,7.537,5,7.537c-1.379,0-2.5,1.121-2.5,2.5s1.121,2.5,2.5,2.5  c0.658,0,1.254-0.258,1.7-0.675l5.938,3.463c-0.042,0.175-0.067,0.358-0.067,0.546c0,1.342,1.087,2.429,2.429,2.429  s2.429-1.088,2.429-2.429S16.342,13.442,15,13.442z"/></svg>
						</span>
						<?php echo $text_share; ?>
					</button>
					<div class="share-btns">
						<?php if ($soc_share_code) { ?>
							<?php echo $soc_share_code; ?>
						<?php } else { ?>
							<script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-4dc053ae406c06af"></script>
							<div class="addthis_inline_share_toolbox"></div>
						<?php } ?>
					</div>
				</div>
				<?php } ?>
				<div class="right">
					<?php foreach ($tags as $tag) { ?>
					<a href="<?php echo $tag['href']; ?>" class="btn btn--transparent"><?php echo $tag['title']; ?></a>
					<?php } ?>
				</div>
			</div>
			<?php echo $description; ?>
			<div class="icons-block btns-block">
				<div class="icons-block__looks">
					<span class="icon eye-icon">
						<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M10,4.4C3.439,4.4,0,9.232,0,10c0,0.766,3.439,5.6,10,5.6c6.56,0,10-4.834,10-5.6C20,9.232,16.56,4.4,10,4.4z M10,14.307  c-2.455,0-4.445-1.928-4.445-4.307c0-2.379,1.99-4.309,4.445-4.309c2.455,0,4.444,1.93,4.444,4.309  C14.444,12.379,12.455,14.307,10,14.307z M10,10c-0.407-0.447,0.663-2.154,0-2.154c-1.228,0-2.223,0.965-2.223,2.154  c0,1.189,0.995,2.154,2.223,2.154c1.227,0,2.223-0.965,2.223-2.154C12.223,9.453,10.346,10.379,10,10z"/></svg>
					</span>
					<?php echo $viewed; ?>
				</div>
				<?php if ($commenrtsenable) { ?>
				<div class="icons-block__comments">
					<span class="icon typing-icon">
						<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve"><path d="M16,4H4C2.899,4,2,4.9,2,6v7c0,1.1,0.899,2,2,2h4l4,3v-3h4c1.1,0,2-0.9,2-2V6C18,4.9,17.1,4,16,4z M6,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C7.1,10.107,6.607,10.6,6,10.6z M10,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C11.1,10.107,10.607,10.6,10,10.6z M14,10.6  c-0.607,0-1.1-0.492-1.1-1.1c0-0.608,0.492-1.1,1.1-1.1s1.1,0.492,1.1,1.1C15.1,10.107,14.607,10.6,14,10.6z"/></svg>
					</span>
					<?php echo $totalComments; ?>
				</div>
				<?php } ?>
				<div class="icons-block__date"><?php echo $date_added; ?></div>
				<div class="icons-block right">
					<?php foreach ($tags as $tag) { ?>
					<a href="<?php echo $tag['href']; ?>" class="btn btn--transparent"><?php echo $tag['title']; ?></a>
					<?php } ?>
				</div>
			</div>

		</div>
		<?php if (!empty($blogs)) { ?>
		<div class="container">
			<div class="recommendations2">
				<h2 class="recommendations2__title">
					<?php echo $text_related; ?>
				</h2>
				<div class="news-slider js-recom-slider2">
					<?php foreach ($blogs as $blog) { ?>

					<div class="news-slider__item">
						<a href="<?php echo $blog['href']; ?>"><div class="news__img">
							<img src="<?php echo $blog['thumb']; ?>" alt="img">
						</div>
						<div class="news__descr">
							<div class="news__descr-date"><?php echo $blog['date']; ?></div>
							<div class="news__descr-text"><a href="<?php echo $blog['href']; ?>"><?php echo $blog['name']; ?></a></div>
						</div></a>
					</div>

					<?php } ?> 
				</div>
			</div>
		</div>
		<?php } ?> 
		<?php if ($commenrtsenable) { ?>
		<div class="container">
			<div class="comments-sec">
				<?php if ($totalComments != 0) { ?>
				<div class="all-comments">
					<div class="all-comments-title text-center"><?php echo $totalComments; ?> <?php echo $text_comments; ?></div>
					<?php foreach ($comments as $comment) { ?>
					<div class="comments-sec__item">
						<div class="comments-sec__item-img">
							<div class="icon-user">
								<svg id="User" class="icon-user" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 18 20" style="enable-background:new 0 0 18 20;" xml:space="preserve"><path d="M6.7,2.1c-1,0.8-1.3,2-1.2,2.6c0.1,0.8,0.2,1.8,0.2,1.8S5.4,6.7,5.4,7.4c0.1,1.7,0.7,1,0.8,1.7c0.3,1.8,0.9,1.5,0.9,2.5 c0,1.6-0.7,2.4-2.8,3.3C2.2,15.8,0,17,0,19v1h18v-1c0-2-2.2-3.2-4.3-4.1c-2.1-0.9-2.8-1.7-2.8-3.3c0-1,0.6-0.7,0.9-2.5 c0.1-0.8,0.7,0,0.8-1.7c0-0.7-0.3-0.9-0.3-0.9s0.2-1,0.2-1.8c0.1-0.8-0.4-2.6-2.3-3.1c-0.3-0.3-0.6-0.9,0.5-1.4 C8.4,0.1,7.9,1.3,6.7,2.1z"></svg>
							</div>
						</div>
						<div class="comments-sec__item-desc">
							<div class="comments-sec__item-name"><?php echo $comment['author']; ?><span class="comments-sec__item-time"><?php echo $comment['date_added']; ?></span></div>
							<div class="comments-sec__item-text"><?php echo $comment['text']; ?></div>
						</div>
					</div>
					<?php } ?> 

				</div>
				<?php } else { ?>
				<div class="comments-sec-title text-center"><?php echo $text_first_comment; ?></div>
				<?php } ?>
				<div class="write-comment">
				<div class="message"></div>
					<form id="form-comment">
						<div class="row">
							<div class="col-sm-12">
								<div class="form-group">
									<input type="text" class="form-control" name="name" placeholder="<?php echo $text_comment_name; ?>">
								</div>
							</div>

						</div>
						<div class="form-group">
							<textarea name="text" class="form-control" placeholder="<?php echo $text_comment_text; ?>"></textarea>
						</div>
						<input type="hidden"  name="blog_id" value="<?php echo $blog_id; ?>">
						<button type="button" class="btn btn-primary" onclick="comment.add('<?php echo $blog_id; ?>');"><?php echo $text_comment_add; ?></button>
					</form>
				</div>
			</div>
		</div>
		<?php } ?> 
		<?php if (!empty($products)) { ?>
		<div class="container">
			<div class="recommendations">
				<h2 class="recommendations__title">
					<?php echo $text_related_products; ?>
				</h2>
				<div class="recomend-slider js-recom-slider">
					<?php foreach ($products as $product) { ?>
					<div class="recomend-slider__item product product--min">
						<div class="product__img">
							<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt=""></a>
						</div>
						<div class="product__descr">
							<div class="product__rating product__rating--sm">
								<div class="product__rating-fill" style="width: <?php echo 20*$product['rating']; ?>%;">
								</div>
							</div>
							<a href="<?php echo $product['href']; ?>" class="link--brown"><?php echo $product['name']; ?></a>
							<span class="product__price"><?php echo $product['price']; ?><span class="rub">j</span></span>
						</div>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>
		<?php } ?>
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>